import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('kk'),
    Locale('ru')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Flutter Demo'**
  String get appTitle;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App version: v{version} ({build}) {platform}'**
  String appVersion(Object version, Object build, Object platform);

  /// No description provided for @authorizationAgreementPrefix.
  ///
  /// In en, this message translates to:
  /// **'By pressing the \"{button}\" button, you agree to the'**
  String authorizationAgreementPrefix(Object button);

  /// No description provided for @termOfUse.
  ///
  /// In en, this message translates to:
  /// **'term of use'**
  String get termOfUse;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'privacy policy'**
  String get privacyPolicy;

  /// No description provided for @promocode.
  ///
  /// In en, this message translates to:
  /// **'promocode'**
  String get promocode;

  /// No description provided for @promocodes.
  ///
  /// In en, this message translates to:
  /// **'Promo codes'**
  String get promocodes;

  /// No description provided for @no_promocodes.
  ///
  /// In en, this message translates to:
  /// **'No promo codes'**
  String get no_promocodes;

  /// No description provided for @api_tokens.
  ///
  /// In en, this message translates to:
  /// **'API Tokens'**
  String get api_tokens;

  /// No description provided for @api_token.
  ///
  /// In en, this message translates to:
  /// **'API Token'**
  String get api_token;

  /// No description provided for @no_tokens.
  ///
  /// In en, this message translates to:
  /// **'No API tokens'**
  String get no_tokens;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get id;

  /// No description provided for @company_id.
  ///
  /// In en, this message translates to:
  /// **'Company ID'**
  String get company_id;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get name;

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @created_at.
  ///
  /// In en, this message translates to:
  /// **'Created at'**
  String get created_at;

  /// No description provided for @starts_at.
  ///
  /// In en, this message translates to:
  /// **'Starts'**
  String get starts_at;

  /// No description provided for @expires_at.
  ///
  /// In en, this message translates to:
  /// **'Expires'**
  String get expires_at;

  /// No description provided for @discount_percent.
  ///
  /// In en, this message translates to:
  /// **'Discount %'**
  String get discount_percent;

  /// No description provided for @discount_amount.
  ///
  /// In en, this message translates to:
  /// **'Discount Amount'**
  String get discount_amount;

  /// No description provided for @usage_limit.
  ///
  /// In en, this message translates to:
  /// **'Usage Limit'**
  String get usage_limit;

  /// No description provided for @used_count.
  ///
  /// In en, this message translates to:
  /// **'Used Count'**
  String get used_count;

  /// No description provided for @is_active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get is_active;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @qr_code.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get qr_code;

  /// No description provided for @hintSaveThisToken.
  ///
  /// In en, this message translates to:
  /// **'Write security token, and save in some place. THIS TOKEN VISIBLE ONLY ON CREATION!'**
  String get hintSaveThisToken;

  /// No description provided for @userUpdateTitle.
  ///
  /// In en, this message translates to:
  /// **'Update profile'**
  String get userUpdateTitle;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get username;

  /// No description provided for @userDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete profile'**
  String get userDeleteTitle;

  /// No description provided for @userDeleteDescription.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account?'**
  String get userDeleteDescription;

  /// No description provided for @companyUpdateTitle.
  ///
  /// In en, this message translates to:
  /// **'Company update profile'**
  String get companyUpdateTitle;

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'Company name'**
  String get companyName;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @are_you_sure_to_delete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this {item}?\n\nID: {id}'**
  String are_you_sure_to_delete(String item, String id);

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @activate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get activate;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get unknownError;

  /// No description provided for @connectionError.
  ///
  /// In en, this message translates to:
  /// **'Cannot connect to service'**
  String get connectionError;

  /// No description provided for @userIdIsNull.
  ///
  /// In en, this message translates to:
  /// **'User ID is empty'**
  String get userIdIsNull;

  /// No description provided for @authorizationTitle.
  ///
  /// In en, this message translates to:
  /// **'Account authorization'**
  String get authorizationTitle;

  /// No description provided for @authorizationDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get authorizationDescription;

  /// No description provided for @authorizationLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter into account'**
  String get authorizationLoginTitle;

  /// No description provided for @authorizationRegisterTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authorizationRegisterTitle;

  /// No description provided for @authorizationPhoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get authorizationPhoneTitle;

  /// No description provided for @authorizationGetCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Get code'**
  String get authorizationGetCodeTitle;

  /// No description provided for @authorizationCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Code confirmation'**
  String get authorizationCodeTitle;

  /// No description provided for @authorizationPasteCodeDescription.
  ///
  /// In en, this message translates to:
  /// **'Paste received code'**
  String get authorizationPasteCodeDescription;

  /// No description provided for @authorizationLogoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get authorizationLogoutTitle;

  /// No description provided for @companyTitle.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get companyTitle;

  /// No description provided for @companyDescription.
  ///
  /// In en, this message translates to:
  /// **'Company settings'**
  String get companyDescription;

  /// No description provided for @companyCreatePromocode.
  ///
  /// In en, this message translates to:
  /// **'Create promo code'**
  String get companyCreatePromocode;

  /// No description provided for @companyListPromocodes.
  ///
  /// In en, this message translates to:
  /// **'Existing promocodes'**
  String get companyListPromocodes;

  /// No description provided for @companyUpdatePromocodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Update promo code'**
  String get companyUpdatePromocodeTitle;

  /// No description provided for @companyUpdatePromocodeDescription.
  ///
  /// In en, this message translates to:
  /// **'Edit promo code information'**
  String get companyUpdatePromocodeDescription;

  /// No description provided for @companyCreatePromocodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Create promo code'**
  String get companyCreatePromocodeTitle;

  /// No description provided for @companyCreatePromocodeDescription.
  ///
  /// In en, this message translates to:
  /// **'New promo code creation form'**
  String get companyCreatePromocodeDescription;

  /// No description provided for @companyCreateTokenTitle.
  ///
  /// In en, this message translates to:
  /// **'Create API Token'**
  String get companyCreateTokenTitle;

  /// No description provided for @companyCreateTokenDescription.
  ///
  /// In en, this message translates to:
  /// **'New API token creation form'**
  String get companyCreateTokenDescription;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @homeDescription.
  ///
  /// In en, this message translates to:
  /// **'List of promotions'**
  String get homeDescription;

  /// No description provided for @no_promotions.
  ///
  /// In en, this message translates to:
  /// **'No promotions'**
  String get no_promotions;

  /// No description provided for @promocodesTitle.
  ///
  /// In en, this message translates to:
  /// **'Promo codes'**
  String get promocodesTitle;

  /// No description provided for @promocodesDescription.
  ///
  /// In en, this message translates to:
  /// **'My promocodes'**
  String get promocodesDescription;

  /// No description provided for @promocodesUsed.
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get promocodesUsed;

  /// No description provided for @promocodesActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get promocodesActive;

  /// No description provided for @promocodesEmpty.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any promo codes yet'**
  String get promocodesEmpty;

  /// No description provided for @activated.
  ///
  /// In en, this message translates to:
  /// **'Activated'**
  String get activated;

  /// No description provided for @used.
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get used;

  /// No description provided for @promocodeActivate.
  ///
  /// In en, this message translates to:
  /// **'ACTIVATE QR'**
  String get promocodeActivate;

  /// No description provided for @promocodeShare.
  ///
  /// In en, this message translates to:
  /// **'SHARE QR'**
  String get promocodeShare;

  /// No description provided for @scannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Scanner'**
  String get scannerTitle;

  /// No description provided for @scannerDescription.
  ///
  /// In en, this message translates to:
  /// **'Scan promo codes'**
  String get scannerDescription;

  /// No description provided for @myCards.
  ///
  /// In en, this message translates to:
  /// **'My cards'**
  String get myCards;

  /// No description provided for @unknownCompany.
  ///
  /// In en, this message translates to:
  /// **'Unknown company'**
  String get unknownCompany;

  /// No description provided for @bin.
  ///
  /// In en, this message translates to:
  /// **'BIN'**
  String get bin;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @bonusov.
  ///
  /// In en, this message translates to:
  /// **'bonuses'**
  String get bonusov;

  /// No description provided for @check.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get check;

  /// No description provided for @checkov.
  ///
  /// In en, this message translates to:
  /// **'Checks'**
  String get checkov;

  /// No description provided for @bonuses.
  ///
  /// In en, this message translates to:
  /// **'Bonuses'**
  String get bonuses;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @written_off.
  ///
  /// In en, this message translates to:
  /// **'Written off'**
  String get written_off;

  /// No description provided for @expired_off.
  ///
  /// In en, this message translates to:
  /// **'Will burn out'**
  String get expired_off;

  /// No description provided for @expires.
  ///
  /// In en, this message translates to:
  /// **'Expires'**
  String get expires;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @paymentSum.
  ///
  /// In en, this message translates to:
  /// **'Payment sum'**
  String get paymentSum;

  /// No description provided for @bonusesAccured.
  ///
  /// In en, this message translates to:
  /// **'Bonuses accured'**
  String get bonusesAccured;

  /// No description provided for @code_active_for.
  ///
  /// In en, this message translates to:
  /// **'The code is active for'**
  String get code_active_for;

  /// No description provided for @code_has_expired.
  ///
  /// In en, this message translates to:
  /// **'The code has expired'**
  String get code_has_expired;

  /// No description provided for @refresh_in.
  ///
  /// In en, this message translates to:
  /// **'Refresh in'**
  String get refresh_in;

  /// No description provided for @get_code_from_cassier.
  ///
  /// In en, this message translates to:
  /// **'Get code from cassier'**
  String get get_code_from_cassier;

  /// No description provided for @slogan.
  ///
  /// In en, this message translates to:
  /// **'A clean car - always a win!'**
  String get slogan;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @your_bonuses.
  ///
  /// In en, this message translates to:
  /// **'Your bonuses'**
  String get your_bonuses;

  /// No description provided for @your_bonusov.
  ///
  /// In en, this message translates to:
  /// **'Your bonuses'**
  String get your_bonusov;

  /// No description provided for @until_next_level.
  ///
  /// In en, this message translates to:
  /// **'Until next level'**
  String get until_next_level;

  /// No description provided for @washing.
  ///
  /// In en, this message translates to:
  /// **'Washing'**
  String get washing;

  /// No description provided for @promotions.
  ///
  /// In en, this message translates to:
  /// **'Promotions'**
  String get promotions;

  /// No description provided for @promotion.
  ///
  /// In en, this message translates to:
  /// **'Promotion'**
  String get promotion;

  /// No description provided for @partners.
  ///
  /// In en, this message translates to:
  /// **'Partners'**
  String get partners;

  /// No description provided for @partner.
  ///
  /// In en, this message translates to:
  /// **'Partner'**
  String get partner;

  /// No description provided for @useful.
  ///
  /// In en, this message translates to:
  /// **'Useful'**
  String get useful;

  /// No description provided for @read_more.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get read_more;

  /// No description provided for @ads.
  ///
  /// In en, this message translates to:
  /// **'Ads'**
  String get ads;

  /// No description provided for @weather.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get weather;

  /// No description provided for @news.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news;

  /// No description provided for @main.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get main;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @spend_bonuses.
  ///
  /// In en, this message translates to:
  /// **'Spend bonuses'**
  String get spend_bonuses;

  /// No description provided for @your_level.
  ///
  /// In en, this message translates to:
  /// **'Your level'**
  String get your_level;

  /// No description provided for @how_to_pile_up.
  ///
  /// In en, this message translates to:
  /// **'How to pile up'**
  String get how_to_pile_up;

  /// No description provided for @my_bonuses.
  ///
  /// In en, this message translates to:
  /// **'My bonuses'**
  String get my_bonuses;

  /// No description provided for @my_cars.
  ///
  /// In en, this message translates to:
  /// **'My cars'**
  String get my_cars;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @about_app.
  ///
  /// In en, this message translates to:
  /// **'About app'**
  String get about_app;

  /// No description provided for @bronze.
  ///
  /// In en, this message translates to:
  /// **'Bronze'**
  String get bronze;

  /// No description provided for @silver.
  ///
  /// In en, this message translates to:
  /// **'Silver'**
  String get silver;

  /// No description provided for @gold.
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get gold;

  /// No description provided for @diamon.
  ///
  /// In en, this message translates to:
  /// **'Diamond'**
  String get diamon;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'kk', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'kk': return AppLocalizationsKk();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
