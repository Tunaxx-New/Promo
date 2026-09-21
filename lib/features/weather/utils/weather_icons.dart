import 'package:flutter/material.dart';

/// Pairs an icon with the l10n key describing an Open-Meteo WMO weather code.
class WeatherCondition {
  final String iconAsset;
  final String labelKey;
  const WeatherCondition(this.iconAsset, this.labelKey);
}

/// Maps WMO weather codes (used by Open-Meteo) to an icon + l10n key.
/// Reference: https://open-meteo.com/en/docs#weathervariables
WeatherCondition weatherConditionFromCode(int code) {
  if (code == 0) {
    return const WeatherCondition(
      'assets/weather/weather_clear.png',
      'weatherClear',
    );
  } else if (code == 1 || code == 2) {
    return const WeatherCondition(
      'assets/weather/weather_partly_cloudy.png',
      'weatherPartlyCloudy',
    );
  } else if (code == 3) {
    return const WeatherCondition(
      'assets/weather/weather_overcast.png',
      'weatherOvercast',
    );
  } else if (code == 45 || code == 48) {
    return const WeatherCondition(
      'assets/weather/weather_fog.png',
      'weatherFog',
    );
  } else if (code >= 51 && code <= 57) {
    return const WeatherCondition(
      'assets/weather/weather_drizzle.png',
      'weatherDrizzle',
    );
  } else if ((code >= 61 && code <= 67) || (code >= 80 && code <= 82)) {
    return const WeatherCondition(
      'assets/weather/weather_rain.png',
      'weatherRain',
    );
  } else if ((code >= 71 && code <= 77) || (code >= 85 && code <= 86)) {
    return const WeatherCondition(
      'assets/weather/weather_snow.png',
      'weatherSnow',
    );
  } else if (code >= 95) {
    return const WeatherCondition(
      'assets/weather/weather_thunderstorm.png',
      'weatherThunderstorm',
    );
  }
  return const WeatherCondition(
    'assets/weather/weather_cloudy.png',
    'weatherCloudy',
  );
}
