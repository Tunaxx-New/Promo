import 'package:promo/l10n/app_localizations.dart';

String weatherLabel(AppLocalizations l10n, String key) {
  switch (key) {
    case 'weatherClear':
      return l10n.weatherClear;
    case 'weatherPartlyCloudy':
      return l10n.weatherPartlyCloudy;
    case 'weatherCloudy':
      return l10n.weatherCloudy;
    case 'weatherOvercast':
      return l10n.weatherOvercast;
    case 'weatherFog':
      return l10n.weatherFog;
    case 'weatherDrizzle':
      return l10n.weatherDrizzle;
    case 'weatherRain':
      return l10n.weatherRain;
    case 'weatherSnow':
      return l10n.weatherSnow;
    case 'weatherThunderstorm':
      return l10n.weatherThunderstorm;
    default:
      return key;
  }
}
