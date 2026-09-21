import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:promo/features/weather/utils/weather_label.dart';
import 'package:promo/features/weather/weather_service.dart';
import 'package:promo/features/weather/widgets/daily_forecast_item.dart';
import 'package:promo/features/weather/widgets/hourly_forecast_item.dart';
import 'package:promo/features/weather/utils/weather_icons.dart';
import 'package:promo/features/weather/widgets/weather_info_card.dart';
import 'package:promo/l10n/app_localizations.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/models/city.dart';
import 'package:promo/shared/models/weather_data.dart';
import 'city_search_screen.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _service = WeatherService();

  // Default city shown on first launch (Almaty, as in the reference design).
  City _city = City(
    name: 'Петропавловск',
    country: 'Казахстан',
    latitude: 54.855298,
    longitude: 69.118146,
  );

  WeatherData? _weather;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadWeather());
  }

  Future<void> _loadWeather() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final weather = await _service.fetchWeather(_city);
      if (!mounted) return;
      setState(() {
        _weather = weather;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = context.l10n.errorLoadingWeather;
        _loading = false;
      });
    }
  }

  Future<void> _pickCity() async {
    final city = await Navigator.of(
      context,
    ).push<City>(MaterialPageRoute(builder: (_) => const CitySearchScreen()));
    if (city != null) {
      setState(() => _city = city);
      _loadWeather();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadWeather,
          child: _buildBody(context.l10n),
        ),
      ),
    );
  }

  Widget _buildBody(AppLocalizations l10n) {
    if (_loading && _weather == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 12),
            Text('...', style: const TextStyle(color: Colors.white70)),
          ],
        ),
      );
    }

    if (_error != null && _weather == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error!, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _loadWeather, child: Text(l10n.retry)),
          ],
        ),
      );
    }

    final weather = _weather!;
    final condition = weatherConditionFromCode(weather.current.weatherCode);
    final localeTag = Localizations.localeOf(context).toString();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          l10n.weather,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // City selector — tap to open the search screen.
        GestureDetector(
          onTap: _pickCity,
          child: Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.lightBlueAccent,
                size: 18,
              ),
              const SizedBox(width: 4),
              Text(
                _city.name,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Big current temperature + icon.
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(condition.iconAsset, width: 128, height: 128),
            const SizedBox(width: 16),
            Text(
              '${weather.current.temperature.round()}°',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 56,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        Text(
          weatherLabel(l10n, condition.labelKey),
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        const SizedBox(height: 24),

        // Humidity / Wind / Pressure row.
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WeatherInfoItem(
                icon: Icons.water_drop_outlined,
                label: l10n.humidity,
                value: '${weather.current.humidity}%',
              ),
              WeatherInfoItem(
                icon: Icons.air,
                label: l10n.wind,
                value:
                    '${weather.current.windSpeed.round()} ${l10n.metersPerSecond}',
              ),
              WeatherInfoItem(
                icon: Icons.speed_outlined,
                label: l10n.pressure,
                value:
                    '${weather.current.pressure.round()} ${l10n.hectopascals}',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Hourly forecast strip.
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: weather.hourly.length > 8 ? 8 : weather.hourly.length,
            itemBuilder: (context, index) {
              final hour = weather.hourly[index];
              final hourCondition = weatherConditionFromCode(hour.weatherCode);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: HourlyForecastTile(
                  time: DateFormat.Hm().format(hour.time),
                  imagePath: hourCondition.iconAsset,
                  temperature: '${hour.temperature.round()}°',
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),

        // 7-day forecast list.
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: weather.daily.map((day) {
              final dayCondition = weatherConditionFromCode(day.weatherCode);
              final weekday = DateFormat.E(localeTag).format(day.date);
              return DailyForecastTile(
                weekday: weekday,
                imagePath: dayCondition.iconAsset,
                maxTemp: '+${day.tempMax.round()}°',
                minTemp: '+${day.tempMin.round()}°',
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
