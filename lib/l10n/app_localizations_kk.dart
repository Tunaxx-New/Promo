// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get appTitle => 'Flutter Demo';

  @override
  String appVersion(Object version, Object build, Object platform) {
    return 'Қолданба нұсқасы: v$version ($build) $platform';
  }

  @override
  String authorizationAgreementPrefix(Object button) {
    return '\"$button\" батырмасын басу арқылы сіз';
  }

  @override
  String get termOfUse => 'пайдалану шарттарымен';

  @override
  String get privacyPolicy => 'құпиялылық саясатымен';

  @override
  String get privacyPolicyTitle => 'Құпиялылық саясаты';

  @override
  String get termOfUseTitle => 'Пайдалану шарттары';

  @override
  String get promocode => 'промокод';

  @override
  String get promocodes => 'Промокодтар';

  @override
  String get no_promocodes => 'Промокодтар жоқ';

  @override
  String get api_tokens => 'API токендер';

  @override
  String get api_token => 'API токен';

  @override
  String get no_tokens => 'API токендер жоқ';

  @override
  String get id => 'ID';

  @override
  String get company_id => 'Компания ID';

  @override
  String get title => 'Атауы';

  @override
  String get name => 'Толық аты-жөні';

  @override
  String get code => 'Код';

  @override
  String get description => 'Сипаттама';

  @override
  String get created_at => 'Құрылған күні';

  @override
  String get starts_at => 'Басталады';

  @override
  String get expires_at => 'Аяқталады';

  @override
  String get discount_percent => 'Жеңілдік %';

  @override
  String get discount_amount => 'Жеңілдік сомасы';

  @override
  String get usage_limit => 'Пайдалану шегі';

  @override
  String get used_count => 'Пайдаланылған саны';

  @override
  String get is_active => 'Белсенді';

  @override
  String get created => 'Құрылды';

  @override
  String get qr_code => 'QR-код';

  @override
  String get hintSaveThisToken =>
      'Қауіпсіздік токенін жазып алып, сенімді жерде сақтаңыз. БҰЛ ТОКЕН ТЕК ҚҰРУ КЕЗІНДЕ ҒАНА КӨРІНЕДІ!';

  @override
  String get userUpdateTitle => 'Пайдаланушы профилін жаңарту';

  @override
  String get username => 'Толық аты-жөні';

  @override
  String get userDeleteTitle => 'Профильді жою';

  @override
  String get userDeleteDescription =>
      'Тіркелгіңізді жойғыңыз келетініне сенімдісіз бе?';

  @override
  String get companyUpdateTitle => 'Компания профилін жаңарту';

  @override
  String get companyName => 'Компания атауы';

  @override
  String get and => 'және';

  @override
  String are_you_sure_to_delete(String item, String id) {
    return 'Осы $item жойғыңыз келетініне сенімдісіз бе?\n\nID: $id';
  }

  @override
  String get ok => 'ОК';

  @override
  String get create => 'Құру';

  @override
  String get delete => 'Жою';

  @override
  String get cancel => 'Бас тарту';

  @override
  String get edit => 'Өзгерту';

  @override
  String get save => 'Сақтау';

  @override
  String get update => 'Жаңарту';

  @override
  String get close => 'Жабу';

  @override
  String get share => 'Бөлісу';

  @override
  String get activate => 'Белсендіру';

  @override
  String get success => 'Сәтті';

  @override
  String get warning => 'Ескерту';

  @override
  String get unknownError => 'Белгісіз қате';

  @override
  String get connectionError => 'Қызметке қосылу мүмкін емес';

  @override
  String get userIdIsNull => 'Пайдаланушы ID бос';

  @override
  String get authorizationTitle => 'Аккаунтты авторизациялау';

  @override
  String get authorizationDescription => 'Телефон нөмірін енгізіңіз';

  @override
  String get authorizationLoginTitle => 'Аккаунтқа кіру';

  @override
  String get authorizationRegisterTitle => 'Аккаунт құру';

  @override
  String get authorizationPhoneTitle => 'Телефон нөмірі';

  @override
  String get authorizationGetCodeTitle => 'Кодты алу';

  @override
  String get authorizationCodeTitle => 'Кодты растау';

  @override
  String get authorizationPasteCodeDescription => 'Алынған кодты енгізіңіз';

  @override
  String get authorizationLogoutTitle => 'Шығу';

  @override
  String get companyTitle => 'Компания';

  @override
  String get companyDescription => 'Компания баптаулары';

  @override
  String get companyCreatePromocode => 'Промокод құру';

  @override
  String get companyListPromocodes => 'Қолданыстағы промокодтар';

  @override
  String get companyUpdatePromocodeTitle => 'Промокодты жаңарту';

  @override
  String get companyUpdatePromocodeDescription => 'Промокод ақпаратын өңдеу';

  @override
  String get companyCreatePromocodeTitle => 'Промокод құру';

  @override
  String get companyCreatePromocodeDescription => 'Жаңа промокод құру формасы';

  @override
  String get companyCreateTokenTitle => 'API токен құру';

  @override
  String get companyCreateTokenDescription => 'Жаңа API токен құру формасы';

  @override
  String get homeTitle => 'Басты бет';

  @override
  String get homeDescription => 'Акциялар тізімі';

  @override
  String get no_promotions => 'Акциялар жоқ';

  @override
  String get promocodesTitle => 'Промокодтар';

  @override
  String get promocodesDescription => 'Менің промокодтарым';

  @override
  String get promocodesUsed => 'Пайдаланылды';

  @override
  String get promocodesActive => 'Белсенді';

  @override
  String get promocodesEmpty => 'Сізде әлі промокодтар жоқ';

  @override
  String get activated => 'Белсендірілді';

  @override
  String get used => 'Пайдаланылды';

  @override
  String get promocodeActivate => 'QR БЕЛСЕНДІРУ';

  @override
  String get promocodeShare => 'QR БӨЛІСУ';

  @override
  String get scannerTitle => 'Сканер';

  @override
  String get scannerDescription => 'Промокодтарды сканерлеу';

  @override
  String get myCards => 'Менің карталарым';

  @override
  String get unknownCompany => 'Белгісіз компания';

  @override
  String get bin => 'BIN';

  @override
  String get products => 'Өнімдер';

  @override
  String get bonusov => 'Бонустар';

  @override
  String get check => 'Чек';

  @override
  String get checkov => 'Чектер';

  @override
  String get bonuses => 'Бонустар';

  @override
  String get summary => 'Барлығы';

  @override
  String get written_off => 'Өшірілді';

  @override
  String get expired_off => 'Жанып кетеді';

  @override
  String get expires => 'Мерзімі аяқталады';

  @override
  String get expired => 'Мерзімі аяқталды';

  @override
  String get no => 'Жоқ';

  @override
  String get paymentSum => 'Сатып алу сомасы';

  @override
  String get bonusesAccured => 'Жиналған бонустар';

  @override
  String get code_active_for => 'Код белсенді';

  @override
  String get code_has_expired => 'Кодтың мерзімі бітті';

  @override
  String get refresh_in => 'Жаңарту арқылы';

  @override
  String get get_code_from_cassier => 'Кассадан кодты алыңыз';

  @override
  String get slogan => 'Таза көлік - әрқашан ұтыста!';

  @override
  String get hello => 'Сәлем';

  @override
  String get your_bonuses => 'Сіздің бонустарыңыз';

  @override
  String get your_bonusov => 'Сіздің бонустарыңыз';

  @override
  String until_next_level(Object level) {
    return 'Келесі деңгейге дейін ($level)';
  }

  @override
  String get washing => 'Жуу';

  @override
  String get promotions => 'Жарнамалар';

  @override
  String get promotion => 'Жарнама';

  @override
  String get partners => 'Серіктестер';

  @override
  String get partner => 'Серіктестер';

  @override
  String get auto => 'Auto';

  @override
  String get company => 'Компания';

  @override
  String get useful => 'Пайдалы';

  @override
  String get new_ => 'Жаңа';

  @override
  String get all => 'Барлығы';

  @override
  String get read_more => 'Қосымша мәліметтер';

  @override
  String get ads => 'Жарнама';

  @override
  String get weather => 'Ауа райы';

  @override
  String get news => 'Жаңалықтар';

  @override
  String get no_news => 'Жаңалықтар жоқ';

  @override
  String get main => 'Басты бет';

  @override
  String get history => 'Тарих';

  @override
  String get map => 'Карта';

  @override
  String get mapPoints => 'ұпайлар';

  @override
  String get mapLoadError => 'Карта нүктелерін жүктеу сәтсіз аяқталды';

  @override
  String get retry => 'Қайталау';

  @override
  String get profile => 'Профиль';

  @override
  String get spend => 'Жұмса';

  @override
  String get spend_bonuses => 'Бонустарды жұмсау';

  @override
  String get your_level => 'Сіздің деңгейіңіз';

  @override
  String get how_to_pile_up => 'Қалай жинақтау';

  @override
  String get my_bonuses => 'Менің бонустарым';

  @override
  String get my_cars => 'Менің көліктерім';

  @override
  String get notifications => 'Хабарландырулар';

  @override
  String get settings => 'Параметрлер';

  @override
  String get about_app => 'Қолданба туралы';

  @override
  String get current => 'Ағымдағы';

  @override
  String get bronze => 'Қола';

  @override
  String get silver => 'Күміс';

  @override
  String get gold => 'Алтын';

  @override
  String get diamond => 'Гауһар';

  @override
  String get guest => 'Қонақ';

  @override
  String get is_not_available_yet => 'әлі қолжетімді емес';

  @override
  String get show_code_to_cassier => 'Кодты кассирге көрсету';

  @override
  String get searchCityHint => 'Қаланы іздеу';

  @override
  String get selectCity => 'Қаланы таңдау';

  @override
  String get humidity => 'Ылғалдылық';

  @override
  String get wind => 'Жел';

  @override
  String get pressure => 'Қысым';

  @override
  String get errorLoadingWeather =>
      'Ауа райы туралы деректерді жүктеу мүмкін болмады';

  @override
  String get noCitiesResults => 'Қалалар табылмады';

  @override
  String get changeCity => 'Қаланы өзгерту';

  @override
  String get weatherClear => 'Ашық';

  @override
  String get weatherPartlyCloudy => 'Аздап бұлтты';

  @override
  String get weatherCloudy => 'Бұлтты';

  @override
  String get weatherOvercast => 'Тұтас бұлтты';

  @override
  String get weatherFog => 'Тұман';

  @override
  String get weatherDrizzle => 'Сіркіреген жаңбыр';

  @override
  String get weatherRain => 'Жаңбыр';

  @override
  String get weatherSnow => 'Қар';

  @override
  String get weatherThunderstorm => 'Найзағай';

  @override
  String get metersPerSecond => 'м/с';

  @override
  String get hectopascals => 'гПа';

  @override
  String get currency => 'Валюта';

  @override
  String get price => 'Баға';

  @override
  String get priceType => 'Баға түрі';

  @override
  String get naming => 'Атауы';

  @override
  String get nothing_was_found => 'Ештеңе табылмады';

  @override
  String get services_search => 'Қызметтерді іздеу';

  @override
  String get without_company => 'Компаниясыз';

  @override
  String get services_that_app_added => 'Қолданба қосқан қызметтер';

  @override
  String get from_services => 'қызметтер';

  @override
  String get contributors => 'үлес қосушылар';
}
