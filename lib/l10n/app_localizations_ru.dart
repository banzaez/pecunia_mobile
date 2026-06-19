// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get yes => 'да';

  @override
  String get no => 'нет';

  @override
  String get bottomSheetClose => 'Закрыть';

  @override
  String get light => 'светлая';

  @override
  String get dark => 'темная';

  @override
  String get labelCategory => 'категория';

  @override
  String get homeButtonIncome => 'доход';

  @override
  String get homeButtonExpense => 'расход';

  @override
  String get profileTitle => 'Настройки профиля';

  @override
  String get profileMyWallets => 'мои кошельки';

  @override
  String get profileTheme => 'тема';

  @override
  String get profileMainCurrency => 'основная валюта';

  @override
  String get profileSupport => 'поддержка';

  @override
  String get profileEdit => 'редактировать';

  @override
  String get settingWalletTitleAdd => 'Создать кошелек';

  @override
  String get settingWalletTitleUpdate => 'Настройки текущего кошелька';

  @override
  String get settingWalletName => 'название*';

  @override
  String get settingWalletDescription => 'примечание';

  @override
  String get settingWalletCurrency => 'валюта*';

  @override
  String get settingWalletShowBalance => 'показывать баланс на главной';

  @override
  String get settingWalletIsRoundUp => 'округлять суммы до целых';

  @override
  String get settingWalletButtonAdd => 'добавить кошелек';

  @override
  String get settingWalletButtonSave => 'Cохранить';

  @override
  String get settingWalletErrorName => 'Введите название';

  @override
  String get settingWalletErrorCurrency => 'Введите примечание';

  @override
  String get walletItemName => 'название';

  @override
  String get walletItemDescription => 'примечание';

  @override
  String get currentWalletTitle => 'текущий кошелек';

  @override
  String get currentWalletBottomTitle => 'ваши кошельки';

  @override
  String get tranItemToday => 'сегодня';

  @override
  String get tranItemYesterday => 'вчера';

  @override
  String get tranItemIncome => 'доходы от';

  @override
  String get tranItemExpense => 'расходы на';

  @override
  String get tranItemErrorAmount => 'Введите сумму';

  @override
  String get tranItemErrorCategory => 'Введите категорию';

  @override
  String get dialogDeleteTitle => 'Подтвердите';

  @override
  String get dialogDeleteContent =>
      'Вы уверены, что хотите удалить этот элемент?';

  @override
  String get dialogDeleteDelete => 'Удалить';

  @override
  String get dialogDeleteCancel => 'Отменить';

  @override
  String get analyticsTitle => 'Аналитика';

  @override
  String get analyticsCategoryItemCount => 'транзакций';

  @override
  String analyticsCategoryPeriod(String period) {
    return 'за период $period года';
  }

  @override
  String analyticsCategoryEmpty(String period) {
    return 'аналитики за период $period года нет';
  }

  @override
  String get analyticsIncome => 'доходы';

  @override
  String get analyticsExpenses => 'расходы';

  @override
  String get analyticsTotal => 'суммарно';

  @override
  String get analyticsTotalPeriod => 'итого';

  @override
  String get walletFieldEmpty => 'выберите кошелек';

  @override
  String get transferTitle => 'перевод между кошельками';

  @override
  String get transferAmount => 'сумма';

  @override
  String get transferExchangeRate => 'обменный курс';

  @override
  String get transferTotal => 'итого';

  @override
  String get transferDone => 'готово';

  @override
  String get transferErrorWallet => 'Выберите разные кошельки';

  @override
  String transferDescription(String from, String to, String rate) {
    return 'перевод с $from на $to, обменный курс $rate';
  }

  @override
  String get from => 'с';

  @override
  String get to => 'на';

  @override
  String get rfcSalary => 'Зарплата';

  @override
  String get rfcBonuses => 'Бонусы';

  @override
  String get rfcGifts => 'Подарки';

  @override
  String get rfcSales => 'Продажи';

  @override
  String get rfcInvestments => 'Инвестиции';

  @override
  String get rfcRent => 'Аренда';

  @override
  String get rfcFreelance => 'Фриланс';

  @override
  String get rfcDividends => 'Дивиденды';

  @override
  String get rfcTaxRefunds => 'Возврат налогов';

  @override
  String get rfcCashback => 'Кэшбэк';

  @override
  String get rfcOtherIncome => 'Другие доходы';

  @override
  String get rfcFoodAndDrinks => 'Еда и напитки';

  @override
  String get rfcGroceries => 'Продукты';

  @override
  String get rfcRestaurantsAndCafes => 'Рестораны и кафе';

  @override
  String get rfcTransport => 'Транспорт';

  @override
  String get rfcPublicTransport => 'Общественный транспорт';

  @override
  String get rfcPrivateTransport => 'Частный транспорт';

  @override
  String get rfcFuel => 'Топливо';

  @override
  String get rfcParking => 'Парковка';

  @override
  String get rfcHousing => 'Жилищные расходы';

  @override
  String get rfcRentExpenses => 'Аренда';

  @override
  String get rfcMortgage => 'Ипотека';

  @override
  String get rfcUtilities => 'Коммунальные услуги';

  @override
  String get rfcRepairsAndMaintenance => 'Ремонт и обслуживание';

  @override
  String get rfcClothingAndFootwear => 'Одежда и обувь';

  @override
  String get rfcHealth => 'Здоровье';

  @override
  String get rfcMedicine => 'Медицина';

  @override
  String get rfcInsurance => 'Страхование';

  @override
  String get rfcDoctorVisits => 'Визиты к врачу';

  @override
  String get rfcEntertainment => 'Развлечения';

  @override
  String get rfcMoviesAndTheater => 'Фильмы и театр';

  @override
  String get rfcTravelAndVacations => 'Путешествия и отпуска';

  @override
  String get rfcHobbies => 'Хобби';

  @override
  String get rfcSportsAndFitness => 'Спорт и фитнес';

  @override
  String get rfcGymMemberships => 'Абонементы в спортзал';

  @override
  String get rfcSportsEvents => 'Спортивные события';

  @override
  String get rfcEducation => 'Образование';

  @override
  String get rfcCoursesAndTraining => 'Курсы и тренинги';

  @override
  String get rfcLearningMaterials => 'Учебные материалы';

  @override
  String get rfcLoansAndDebts => 'Займы и долги';

  @override
  String get rfcLoanPayments => 'Погашение займов';

  @override
  String get rfcLoanInterest => 'Процент по займам';

  @override
  String get rfcPets => 'Домашние животные';

  @override
  String get rfcFoodAndCare => 'Питание и уход';

  @override
  String get rfcVeterinary => 'Ветеринар';

  @override
  String get rfcGiftsAndCharity => 'Подарки и благотворительность';

  @override
  String get rfcInternetAndCommunication => 'Интернет и связь';

  @override
  String get rfcPersonalExpenses => 'Личные расходы';

  @override
  String get rfcInvestmentsExpenses => 'Инвестиции';

  @override
  String get rfcOtherExpenses => 'Другие расходы';

  @override
  String get rfcTransfer => 'Перевод';

  @override
  String get rfcAuto => 'Авто';

  @override
  String get rfcAutoFuel => 'Топливо';

  @override
  String get rfcAutoMaintenance => 'Техническое обслуживание';

  @override
  String get rfcAutoInsurance => 'Страховка';

  @override
  String get rfcAutoRepairs => 'Ремонт';

  @override
  String get rfcAutoParking => 'Парковка';

  @override
  String get rfcAutoCarTolls => 'Дорожные сборы';

  @override
  String get rfcAutoCarWash => 'Мойка автомобиля';

  @override
  String get rfcAutoTires => 'Шины';

  @override
  String get rfcAutoRegistration => 'Регистрация';

  @override
  String get settingTranTitle => 'Редактирование';

  @override
  String get settingTranTitleNew => 'Новая транзакция';

  @override
  String get settingTranSave => 'Сохранить';

  @override
  String get settingTranIncome => 'доход';

  @override
  String get settingTranExpenses => 'расход';

  @override
  String get settingTranAmount => 'сумма';

  @override
  String get settingTranCategory => 'категория';

  @override
  String get settingTranDescription => 'примечание';

  @override
  String get totalSum => 'Баланс';

  @override
  String get incomesSum => 'Доходы';

  @override
  String get expensesSum => 'Расходы';

  @override
  String totalHint(String period) {
    return 'за $period';
  }

  @override
  String get backupTitle => 'Архивация и Восстановление';

  @override
  String get backupButton => 'архивация и восстановление';

  @override
  String get backupFilename => 'имя файла';

  @override
  String get backupSize => 'размер';

  @override
  String get backupArchiving => 'архивация';

  @override
  String get backupRecovery => 'восстановление';

  @override
  String get backupRestarting => 'Перезапуск';

  @override
  String get backupRestartingBody =>
      'Нажмите здесь, чтобы открыть приложение снова.';

  @override
  String get walletsTitle => 'Мои кошельки';

  @override
  String get walletsButton => 'мои кошельки';

  @override
  String get transactionsTitle => 'Транзакции';

  @override
  String get error => 'Ошибка';

  @override
  String get success => 'Успешно';

  @override
  String get backupSavedSuccess => 'Бэкап успешно сохранен';

  @override
  String get backupRestoredSuccess => 'Данные успешно восстановлены';

  @override
  String get backupDeletedSuccess => 'Бэкап успешно удален';

  @override
  String get driveErrorRead => 'Ошибка чтения файлов в облаке';

  @override
  String get driveErrorDelete => 'Ошибка удаления файла в облаке';

  @override
  String get driveErrorDownload => 'Ошибка загрузки из облака';

  @override
  String get backupErrorMsg => 'Выбранный файл не в формате \"db\"';

  @override
  String get labelSubcategory => 'подкатегория';

  @override
  String get signOutWithGoogle => 'Выйти из Google';

  @override
  String get signInWithGoogle => 'Войти через Google';

  @override
  String get backupCloudDialogDelete => 'Подтвердите удаление';

  @override
  String get backupCloudDialogDeleteContent =>
      'Вы уверены, что хотите удалить этот файл?';

  @override
  String get backupCloudDialogRecovery => 'Подтвердите восстановление';

  @override
  String get backupCloudDialogRecoveryContent =>
      'Вы уверены, что хотите восстановить этот файл?';

  @override
  String get backupCreateCloudRecovery => 'Создать резервную копию в облаке';

  @override
  String get backupCloudEmpty => 'Облако пусто';

  @override
  String get startupErrorTitle => 'Не удалось запустить приложение';

  @override
  String get startupErrorRetry => 'Повторить';

  @override
  String get dataLoadError => 'Не удалось загрузить данные';

  @override
  String get routeErrorTitle => 'Страница не найдена';

  @override
  String get routeErrorHome => 'На главную';

  @override
  String get walletDeleteLastError => 'Нельзя удалить последний кошелёк';

  @override
  String get driveScopeError =>
      'Доступ к Google Drive не предоставлен. Выйдите и войдите снова.';
}
