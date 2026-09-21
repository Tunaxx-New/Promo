// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Flutter Demo';

  @override
  String appVersion(Object version, Object build, Object platform) {
    return 'Версия приложения: v$version ($build) $platform';
  }

  @override
  String authorizationAgreementPrefix(Object button) {
    return 'Нажимая кнопку \"$button\", вы соглашаетесь с';
  }

  @override
  String get termOfUse => 'условиями использования';

  @override
  String get privacyPolicy => 'политикой конфиденциальности';

  @override
  String get privacyPolicyTitle => 'Политика конфиденциальности';

  @override
  String get termOfUseTitle => 'Условия использования';

  @override
  String get promocode => 'промокод';

  @override
  String get promocodes => 'Промокоды';

  @override
  String get no_promocodes => 'Нет промокодов';

  @override
  String get api_tokens => 'API токены';

  @override
  String get api_token => 'API токен';

  @override
  String get no_tokens => 'Нет API токенов';

  @override
  String get id => 'ID';

  @override
  String get company_id => 'ID компании';

  @override
  String get title => 'Название';

  @override
  String get name => 'ФИО';

  @override
  String get code => 'Код';

  @override
  String get description => 'Описание';

  @override
  String get created_at => 'Дата создания';

  @override
  String get starts_at => 'Начало';

  @override
  String get expires_at => 'Истекает';

  @override
  String get discount_percent => 'Скидка %';

  @override
  String get discount_amount => 'Сумма скидки';

  @override
  String get usage_limit => 'Лимит использования';

  @override
  String get used_count => 'Использовано раз';

  @override
  String get is_active => 'Активен';

  @override
  String get created => 'Создано';

  @override
  String get qr_code => 'QR-код';

  @override
  String get hintSaveThisToken =>
      'Запишите токен безопасности и сохраните его в надежном месте. ЭТОТ ТОКЕН ВИДЕН ТОЛЬКО ПРИ СОЗДАНИИ!';

  @override
  String get userUpdateTitle => 'Обновить профиль';

  @override
  String get username => 'ФИО';

  @override
  String get userDeleteTitle => 'Удалить профиль';

  @override
  String get userDeleteDescription =>
      'Вы уверены, что хотите удалить свой аккаунт?';

  @override
  String get companyUpdateTitle => 'Обновление профиля компании';

  @override
  String get companyName => 'Название компании';

  @override
  String get and => 'и';

  @override
  String are_you_sure_to_delete(String item, String id) {
    return 'Вы уверены, что хотите удалить этот $item?\n\nID: $id';
  }

  @override
  String get ok => 'ОК';

  @override
  String get create => 'Создать';

  @override
  String get delete => 'Удалить';

  @override
  String get cancel => 'Отмена';

  @override
  String get edit => 'Изменить';

  @override
  String get save => 'Сохранить';

  @override
  String get update => 'Обновить';

  @override
  String get close => 'Закрыть';

  @override
  String get share => 'Поделиться';

  @override
  String get activate => 'Активировать';

  @override
  String get success => 'Успешно';

  @override
  String get warning => 'Предупреждение';

  @override
  String get unknownError => 'Неизвестная ошибка';

  @override
  String get connectionError => 'Не удалось подключиться к сервису';

  @override
  String get userIdIsNull => 'ID пользователя пуст';

  @override
  String get authorizationTitle => 'Авторизация аккаунта';

  @override
  String get authorizationDescription => 'Введите номер телефона';

  @override
  String get authorizationLoginTitle => 'Войти в аккаунт';

  @override
  String get authorizationRegisterTitle => 'Создать аккаунт';

  @override
  String get authorizationPhoneTitle => 'Номер телефона';

  @override
  String get authorizationGetCodeTitle => 'Получить код';

  @override
  String get authorizationCodeTitle => 'Подтверждение кода';

  @override
  String get authorizationPasteCodeDescription => 'Вставьте полученный код';

  @override
  String get authorizationLogoutTitle => 'Выйти';

  @override
  String get companyTitle => 'Компания';

  @override
  String get companyDescription => 'Настройки компании';

  @override
  String get companyCreatePromocode => 'Создать промокод';

  @override
  String get companyListPromocodes => 'Существующие промокоды';

  @override
  String get companyUpdatePromocodeTitle => 'Обновить промокод';

  @override
  String get companyUpdatePromocodeDescription =>
      'Редактирование информации о промокоде';

  @override
  String get companyCreatePromocodeTitle => 'Создать промокод';

  @override
  String get companyCreatePromocodeDescription =>
      'Форма создания нового промокода';

  @override
  String get companyCreateTokenTitle => 'Создать API токен';

  @override
  String get companyCreateTokenDescription =>
      'Форма создания нового API токена';

  @override
  String get homeTitle => 'Главная';

  @override
  String get homeDescription => 'Список акций';

  @override
  String get no_promotions => 'Нет акций';

  @override
  String get promocodesTitle => 'Промокоды';

  @override
  String get promocodesDescription => 'Мои промокоды';

  @override
  String get promocodesUsed => 'Использован';

  @override
  String get promocodesActive => 'Активен';

  @override
  String get promocodesEmpty => 'У вас пока нет промокодов';

  @override
  String get activated => 'Активирован';

  @override
  String get used => 'Использован';

  @override
  String get promocodeActivate => 'АКТИВИРОВАТЬ QR';

  @override
  String get promocodeShare => 'ПОДЕЛИТЬСЯ QR';

  @override
  String get scannerTitle => 'Сканер';

  @override
  String get scannerDescription => 'Сканировать промокоды';

  @override
  String get myCards => 'Мои карточки';

  @override
  String get unknownCompany => 'Неизвестная компания';

  @override
  String get bin => 'БИН';

  @override
  String get products => 'Товары';

  @override
  String get bonusov => 'Бонусы';

  @override
  String get check => 'Чек';

  @override
  String get checkov => 'Чеков';

  @override
  String get bonuses => 'Бонусы';

  @override
  String get summary => 'Итого';

  @override
  String get written_off => 'Списано';

  @override
  String get expired_off => 'Сгорит';

  @override
  String get expires => 'Сгорит';

  @override
  String get expired => 'Сгорело';

  @override
  String get no => 'Нет';

  @override
  String get paymentSum => 'Сумма покупки';

  @override
  String get bonusesAccured => 'Начислено бонусов';

  @override
  String get code_active_for => 'Код активен ещё';

  @override
  String get code_has_expired => 'Срок действия кода истёк';

  @override
  String get refresh_in => 'Обновить через';

  @override
  String get get_code_from_cassier => 'Получить код с кассы';

  @override
  String get slogan => 'Чистый автомобиль - всегда в плюсе!';

  @override
  String get hello => 'Привет';

  @override
  String get your_bonuses => 'Ваши бонусы';

  @override
  String get your_bonusov => 'Ваши бонусов';

  @override
  String until_next_level(Object level) {
    return 'До следующего уровня $level';
  }

  @override
  String get washing => 'Мойка';

  @override
  String get promotions => 'Акции';

  @override
  String get promotion => 'Акция';

  @override
  String get partners => 'Партнеры';

  @override
  String get partner => 'Партнер';

  @override
  String get auto => 'Авто';

  @override
  String get company => 'Компания';

  @override
  String get useful => 'Полезное';

  @override
  String get new_ => 'Новое';

  @override
  String get all => 'Всё';

  @override
  String get read_more => 'Подробнее';

  @override
  String get ads => 'Реклама';

  @override
  String get weather => 'Погода';

  @override
  String get news => 'Новости';

  @override
  String get no_news => 'Нет новостей';

  @override
  String get main => 'Главная';

  @override
  String get history => 'История';

  @override
  String get map => 'Карта';

  @override
  String get mapPoints => 'точек';

  @override
  String get mapLoadError => 'Не удалось загрузить точки карты';

  @override
  String get retry => 'Повторная попытка';

  @override
  String get profile => 'Профиль';

  @override
  String get spend => 'Потратить';

  @override
  String get spend_bonuses => 'Потратить бонусы';

  @override
  String get your_level => 'Ваш уровень';

  @override
  String get how_to_pile_up => 'Как накопить';

  @override
  String get my_bonuses => 'Мои бонусы';

  @override
  String get my_cars => 'Мои автомобили';

  @override
  String get notifications => 'Уведомления';

  @override
  String get settings => 'Настройки';

  @override
  String get about_app => 'О приложении';

  @override
  String get current => 'Текущий';

  @override
  String get bronze => 'Бронза';

  @override
  String get silver => 'Серебро';

  @override
  String get gold => 'Золото';

  @override
  String get diamond => 'Бриллиант';

  @override
  String get guest => 'Гость';

  @override
  String get is_not_available_yet => 'пока недоступны';

  @override
  String get show_code_to_cassier => 'Показать код кассиру';

  @override
  String get searchCityHint => 'Поиск города';

  @override
  String get selectCity => 'Выберите город';

  @override
  String get humidity => 'Влажность';

  @override
  String get wind => 'Ветер';

  @override
  String get pressure => 'Давление';

  @override
  String get errorLoadingWeather => 'Не удалось загрузить данные о погоде';

  @override
  String get noCitiesResults => 'Города не найдены';

  @override
  String get changeCity => 'Сменить город';

  @override
  String get weatherClear => 'Ясно';

  @override
  String get weatherPartlyCloudy => 'Переменная облачность';

  @override
  String get weatherCloudy => 'Облачно';

  @override
  String get weatherOvercast => 'Пасмурно';

  @override
  String get weatherFog => 'Туман';

  @override
  String get weatherDrizzle => 'Морось';

  @override
  String get weatherRain => 'Дождь';

  @override
  String get weatherSnow => 'Снег';

  @override
  String get weatherThunderstorm => 'Гроза';

  @override
  String get metersPerSecond => 'м/с';

  @override
  String get hectopascals => 'гПа';

  @override
  String get currency => 'Валюта';

  @override
  String get price => 'Цена';

  @override
  String get priceType => 'Тип цены';

  @override
  String get naming => 'Название';

  @override
  String get nothing_was_found => 'Ничего не найдено';

  @override
  String get services_search => 'Поиск услуг';

  @override
  String get without_company => 'Без компании';

  @override
  String get services_that_app_added => 'Услуги, добавленные приложением';

  @override
  String get from_services => 'услуг';

  @override
  String get contributors => 'авторы';
}
