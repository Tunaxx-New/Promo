class CurrentWeather {
  final double temperature;
  final int weatherCode;
  final int humidity;
  final double windSpeed;
  final double pressure;

  CurrentWeather({
    required this.temperature,
    required this.weatherCode,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        temperature: (json['temperature_2m'] as num).toDouble(),
        weatherCode: (json['weather_code'] as num).toInt(),
        humidity: (json['relative_humidity_2m'] as num).toInt(),
        windSpeed: (json['wind_speed_10m'] as num).toDouble(),
        pressure: (json['surface_pressure'] as num).toDouble(),
      );
}

class HourlyForecast {
  final DateTime time;
  final double temperature;
  final int weatherCode;

  HourlyForecast({
    required this.time,
    required this.temperature,
    required this.weatherCode,
  });
}

class DailyForecast {
  final DateTime date;
  final double tempMax;
  final double tempMin;
  final int weatherCode;

  DailyForecast({
    required this.date,
    required this.tempMax,
    required this.tempMin,
    required this.weatherCode,
  });
}

class WeatherData {
  final CurrentWeather current;
  final List<HourlyForecast> hourly;
  final List<DailyForecast> daily;

  WeatherData({
    required this.current,
    required this.hourly,
    required this.daily,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final current = CurrentWeather.fromJson(json['current'] as Map<String, dynamic>);

    final hourlyJson = json['hourly'] as Map<String, dynamic>;
    final hourlyTimes = (hourlyJson['time'] as List).cast<String>();
    final hourlyTemps = (hourlyJson['temperature_2m'] as List).cast<num>();
    final hourlyCodes = (hourlyJson['weather_code'] as List).cast<num>();

    final hourly = <HourlyForecast>[];
    for (var i = 0; i < hourlyTimes.length; i++) {
      hourly.add(HourlyForecast(
        time: DateTime.parse(hourlyTimes[i]),
        temperature: hourlyTemps[i].toDouble(),
        weatherCode: hourlyCodes[i].toInt(),
      ));
    }

    final dailyJson = json['daily'] as Map<String, dynamic>;
    final dailyDates = (dailyJson['time'] as List).cast<String>();
    final dailyMax = (dailyJson['temperature_2m_max'] as List).cast<num>();
    final dailyMin = (dailyJson['temperature_2m_min'] as List).cast<num>();
    final dailyCodes = (dailyJson['weather_code'] as List).cast<num>();

    final daily = <DailyForecast>[];
    for (var i = 0; i < dailyDates.length; i++) {
      daily.add(DailyForecast(
        date: DateTime.parse(dailyDates[i]),
        tempMax: dailyMax[i].toDouble(),
        tempMin: dailyMin[i].toDouble(),
        weatherCode: dailyCodes[i].toInt(),
      ));
    }

    return WeatherData(current: current, hourly: hourly, daily: daily);
  }
}
