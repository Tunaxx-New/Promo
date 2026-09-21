import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:promo/shared/models/city.dart';
import 'package:promo/shared/models/weather_data.dart';

/// Uses Open-Meteo (https://open-meteo.com) — free, no API key required.
class WeatherService {
  static const _geocodeUrl = 'https://geocoding-api.open-meteo.com/v1/search';
  static const _forecastUrl = 'https://api.open-meteo.com/v1/forecast';

  /// Search cities by name for the city-picker screen.
  Future<List<City>> searchCities(String query) async {
    if (query.trim().isEmpty) return [];
    final uri = Uri.parse(_geocodeUrl).replace(queryParameters: {
      'name': query,
      'count': '10',
      'language': 'ru',
      'format': 'json',
    });
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Geocoding request failed: ${response.statusCode}');
    }
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final results = body['results'] as List<dynamic>?;
    if (results == null) return [];
    return results.map((e) => City.fromJson(e as Map<String, dynamic>)).toList();
  }

  /// Fetch current + hourly + 7-day forecast for a given city.
  Future<WeatherData> fetchWeather(City city) async {
    final uri = Uri.parse(_forecastUrl).replace(queryParameters: {
      'latitude': city.latitude.toString(),
      'longitude': city.longitude.toString(),
      'current':
          'temperature_2m,relative_humidity_2m,wind_speed_10m,surface_pressure,weather_code',
      'hourly': 'temperature_2m,weather_code',
      'daily': 'temperature_2m_max,temperature_2m_min,weather_code',
      'timezone': 'auto',
      'forecast_days': '7',
    });
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Weather request failed: ${response.statusCode}');
    }
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return WeatherData.fromJson(body);
  }
}
