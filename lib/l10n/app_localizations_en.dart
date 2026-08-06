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
  String get name => 'Name';

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
  String get hintSaveThisToken => 'Write security token, and save in some place. THIS TOKEN VISIBLE ONLY ON CREATION!';

  @override
  String get userUpdateTitle => 'User update profile';

  @override
  String get username => 'User name';

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
  String get companyCreatePromocodeDescription => 'New promo code creation form';

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
}
