// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter Demo';

  @override
  String appVersion(Object version, Object build, Object platform) {
    return 'App version: v$version ($build) $platform';
  }

  @override
  String authorizationAgreementPrefix(Object button) {
    return 'By pressing the \"$button\" button, you agree to the';
  }

  @override
  String get termOfUse => 'term of use';

  @override
  String get privacyPolicy => 'privacy policy';

  @override
  String get privacyPolicyTitle => 'Privacy Policy';

  @override
  String get termOfUseTitle => 'Terms of Use';

  @override
  String get promocode => 'promocode';

  @override
  String get promocodes => 'Promo codes';

  @override
  String get no_promocodes => 'No promo codes';

  @override
  String get api_tokens => 'API Tokens';

  @override
  String get api_token => 'API Token';

  @override
  String get no_tokens => 'No API tokens';

  @override
  String get id => 'ID';

  @override
  String get company_id => 'Company ID';

  @override
  String get title => 'Title';

  @override
  String get name => 'Full name';

  @override
  String get code => 'Code';

  @override
  String get description => 'Description';

  @override
  String get created_at => 'Created at';

  @override
  String get starts_at => 'Starts';

  @override
  String get expires_at => 'Expires';

  @override
  String get discount_percent => 'Discount %';

  @override
  String get discount_amount => 'Discount Amount';

  @override
  String get usage_limit => 'Usage Limit';

  @override
  String get used_count => 'Used Count';

  @override
  String get is_active => 'Active';

  @override
  String get created => 'Created';

  @override
  String get qr_code => 'QR Code';

  @override
  String get hintSaveThisToken =>
      'Write security token, and save in some place. THIS TOKEN VISIBLE ONLY ON CREATION!';

  @override
  String get userUpdateTitle => 'Update profile';

  @override
  String get username => 'Full name';

  @override
  String get userDeleteTitle => 'Delete profile';

  @override
  String get userDeleteDescription =>
      'Are you sure you want to delete your account?';

  @override
  String get companyUpdateTitle => 'Company update profile';

  @override
  String get companyName => 'Company name';

  @override
  String get and => 'and';

  @override
  String are_you_sure_to_delete(String item, String id) {
    return 'Are you sure you want to delete this $item?\n\nID: $id';
  }

  @override
  String get ok => 'OK';

  @override
  String get create => 'Create';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get edit => 'Edit';

  @override
  String get save => 'Save';

  @override
  String get update => 'Update';

  @override
  String get close => 'Close';

  @override
  String get share => 'Share';

  @override
  String get activate => 'Activate';

  @override
  String get success => 'Success';

  @override
  String get warning => 'Warning';

  @override
  String get unknownError => 'Unknown error';

  @override
  String get connectionError => 'Cannot connect to service';

  @override
  String get userIdIsNull => 'User ID is empty';

  @override
  String get authorizationTitle => 'Account authorization';

  @override
  String get authorizationDescription => 'Enter phone number';

  @override
  String get authorizationLoginTitle => 'Enter into account';

  @override
  String get authorizationRegisterTitle => 'Create account';

  @override
  String get authorizationPhoneTitle => 'Phone number';

  @override
  String get authorizationGetCodeTitle => 'Get code';

  @override
  String get authorizationCodeTitle => 'Code confirmation';

  @override
  String get authorizationPasteCodeDescription => 'Paste received code';

  @override
  String get authorizationLogoutTitle => 'Logout';

  @override
  String get companyTitle => 'Company';

  @override
  String get companyDescription => 'Company settings';

  @override
  String get companyCreatePromocode => 'Create promo code';

  @override
  String get companyListPromocodes => 'Existing promocodes';

  @override
  String get companyUpdatePromocodeTitle => 'Update promo code';

  @override
  String get companyUpdatePromocodeDescription => 'Edit promo code information';

  @override
  String get companyCreatePromocodeTitle => 'Create promo code';

  @override
  String get companyCreatePromocodeDescription =>
      'New promo code creation form';

  @override
  String get companyCreateTokenTitle => 'Create API Token';

  @override
  String get companyCreateTokenDescription => 'New API token creation form';

  @override
  String get homeTitle => 'Home';

  @override
  String get homeDescription => 'List of promotions';

  @override
  String get no_promotions => 'No promotions';

  @override
  String get promocodesTitle => 'Promo codes';

  @override
  String get promocodesDescription => 'My promocodes';

  @override
  String get promocodesUsed => 'Used';

  @override
  String get promocodesActive => 'Active';

  @override
  String get promocodesEmpty => 'You don\'t have any promo codes yet';

  @override
  String get activated => 'Activated';

  @override
  String get used => 'Used';

  @override
  String get promocodeActivate => 'ACTIVATE QR';

  @override
  String get promocodeShare => 'SHARE QR';

  @override
  String get scannerTitle => 'Scanner';

  @override
  String get scannerDescription => 'Scan promo codes';

  @override
  String get myCards => 'My cards';

  @override
  String get unknownCompany => 'Unknown company';

  @override
  String get bin => 'BIN';

  @override
  String get products => 'Products';

  @override
  String get bonusov => 'bonuses';

  @override
  String get check => 'Check';

  @override
  String get checkov => 'Checks';

  @override
  String get bonuses => 'Bonuses';

  @override
  String get summary => 'Summary';

  @override
  String get written_off => 'Written off';

  @override
  String get expired_off => 'Will burn out';

  @override
  String get expires => 'Expires';

  @override
  String get expired => 'Expired';

  @override
  String get no => 'No';

  @override
  String get paymentSum => 'Payment sum';

  @override
  String get bonusesAccured => 'Bonuses accured';

  @override
  String get code_active_for => 'The code is active for';

  @override
  String get code_has_expired => 'The code has expired';

  @override
  String get refresh_in => 'Refresh in';

  @override
  String get get_code_from_cassier => 'Get code from cassier';

  @override
  String get slogan => 'A clean car - always a win!';

  @override
  String get hello => 'Hello';

  @override
  String get your_bonuses => 'Your bonuses';

  @override
  String get your_bonusov => 'Your bonuses';

  @override
  String until_next_level(Object level) {
    return 'Until next level ($level)';
  }

  @override
  String get washing => 'Washing';

  @override
  String get promotions => 'Promotions';

  @override
  String get promotion => 'Promotion';

  @override
  String get partners => 'Partners';

  @override
  String get partner => 'Partner';

  @override
  String get auto => 'Auto';

  @override
  String get company => 'Company';

  @override
  String get useful => 'Useful';

  @override
  String get new_ => 'New';

  @override
  String get all => 'All';

  @override
  String get read_more => 'Read more';

  @override
  String get ads => 'Ads';

  @override
  String get weather => 'Weather';

  @override
  String get news => 'News';

  @override
  String get no_news => 'No news';

  @override
  String get main => 'Main';

  @override
  String get history => 'History';

  @override
  String get map => 'Map';

  @override
  String get mapPoints => 'points';

  @override
  String get mapLoadError => 'Failed to load map points';

  @override
  String get retry => 'Retry';

  @override
  String get profile => 'Profile';

  @override
  String get spend => 'Spend';

  @override
  String get spend_bonuses => 'Spend bonuses';

  @override
  String get your_level => 'Your level';

  @override
  String get how_to_pile_up => 'How to pile up';

  @override
  String get my_bonuses => 'My bonuses';

  @override
  String get my_cars => 'My cars';

  @override
  String get notifications => 'Notifications';

  @override
  String get settings => 'Settings';

  @override
  String get about_app => 'About app';

  @override
  String get current => 'Current';

  @override
  String get bronze => 'Bronze';

  @override
  String get silver => 'Silver';

  @override
  String get gold => 'Gold';

  @override
  String get diamond => 'Diamond';

  @override
  String get guest => 'Guest';

  @override
  String get is_not_available_yet => 'is not available yet';

  @override
  String get show_code_to_cassier => 'Show code to cassier';

  @override
  String get searchCityHint => 'Search city';

  @override
  String get selectCity => 'Select City';

  @override
  String get humidity => 'Humidity';

  @override
  String get wind => 'Wind';

  @override
  String get pressure => 'Pressure';

  @override
  String get errorLoadingWeather => 'Failed to load weather';

  @override
  String get noCitiesResults => 'No cities found';

  @override
  String get changeCity => 'Change city';

  @override
  String get weatherClear => 'Clear';

  @override
  String get weatherPartlyCloudy => 'Partly cloudy';

  @override
  String get weatherCloudy => 'Cloudy';

  @override
  String get weatherOvercast => 'Overcast';

  @override
  String get weatherFog => 'Fog';

  @override
  String get weatherDrizzle => 'Drizzle';

  @override
  String get weatherRain => 'Rain';

  @override
  String get weatherSnow => 'Snow';

  @override
  String get weatherThunderstorm => 'Thunderstorm';

  @override
  String get metersPerSecond => 'm/s';

  @override
  String get hectopascals => 'hPa';

  @override
  String get currency => 'Currency';

  @override
  String get price => 'Price';

  @override
  String get priceType => 'Price Type';

  @override
  String get naming => 'Title';

  @override
  String get nothing_was_found => 'Nothing was found';

  @override
  String get services_search => 'Search services';

  @override
  String get without_company => 'Without company';

  @override
  String get services_that_app_added => 'Services that app added';

  @override
  String get from_services => 'services';

  @override
  String get contributors => 'contributors';
}
