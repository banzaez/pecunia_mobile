// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get yes => 'так';

  @override
  String get no => 'ні';

  @override
  String get light => 'світла';

  @override
  String get dark => 'темна';

  @override
  String get labelCategory => 'категорія';

  @override
  String get homeButtonIncome => 'дохід';

  @override
  String get homeButtonExpense => 'витрата';

  @override
  String get profileTitle => 'Налаштування профілю';

  @override
  String get profileMyWallets => 'мої гаманці';

  @override
  String get profileTheme => 'тема';

  @override
  String get profileMainCurrency => 'основна валюта';

  @override
  String get profileSupport => 'підтримка';

  @override
  String get profileEdit => 'редагувати';

  @override
  String get settingWalletTitleAdd => 'Створити гаманець';

  @override
  String get settingWalletTitleUpdate => 'Налаштування поточного гаманця';

  @override
  String get settingWalletName => 'назва*';

  @override
  String get settingWalletDescription => 'примітка';

  @override
  String get settingWalletCurrency => 'валюта*';

  @override
  String get settingWalletShowBalance => 'показувати баланс на головній';

  @override
  String get settingWalletIsRoundUp => 'округляти суми до цілих';

  @override
  String get settingWalletButtonAdd => 'додати гаманець';

  @override
  String get settingWalletButtonSave => 'Зберегти';

  @override
  String get settingWalletErrorName => 'Введіть назву';

  @override
  String get settingWalletErrorCurrency => 'Введіть примітку';

  @override
  String get walletItemName => 'назва';

  @override
  String get walletItemDescription => 'примітка';

  @override
  String get currentWalletTitle => 'поточний гаманець';

  @override
  String get currentWalletBottomTitle => 'ваші гаманці';

  @override
  String get tranItemToday => 'сьогодні';

  @override
  String get tranItemYesterday => 'вчора';

  @override
  String get tranItemIncome => 'доходи від';

  @override
  String get tranItemExpense => 'витрати на';

  @override
  String get tranItemErrorAmount => 'Введіть суму';

  @override
  String get tranItemErrorCategory => 'Введіть категорію';

  @override
  String get dialogDeleteTitle => 'Підтвердіть';

  @override
  String get dialogDeleteContent =>
      'Ви впевнені, що хочете видалити цей елемент?';

  @override
  String get dialogDeleteDelete => 'Видалити';

  @override
  String get dialogDeleteCancel => 'Скасувати';

  @override
  String get analyticsTitle => 'Аналітика';

  @override
  String get analyticsCategoryItemCount => 'транзакцій';

  @override
  String analyticsCategoryPeriod(String period) {
    return 'за період $period року';
  }

  @override
  String analyticsCategoryEmpty(String period) {
    return 'аналітики за період $period року немає';
  }

  @override
  String get analyticsIncome => 'доходи';

  @override
  String get analyticsExpenses => 'витрати';

  @override
  String get analyticsTotal => 'загалом';

  @override
  String get analyticsTotalPeriod => 'разом';

  @override
  String get walletFieldEmpty => 'виберіть гаманець';

  @override
  String get transferTitle => 'переказ між гаманцями';

  @override
  String get transferAmount => 'сума';

  @override
  String get transferExchangeRate => 'обмінний курс';

  @override
  String get transferTotal => 'всього';

  @override
  String get transferDone => 'готово';

  @override
  String get transferErrorWallet => 'Виберіть різні гаманці';

  @override
  String transferDescription(String from, String to, String rate) {
    return 'переказ з $from до $to, обмінний курс $rate';
  }

  @override
  String get from => 'з';

  @override
  String get to => 'до';

  @override
  String get rfcSalary => 'Зарплата';

  @override
  String get rfcBonuses => 'Бонуси';

  @override
  String get rfcGifts => 'Подарунки';

  @override
  String get rfcSales => 'Продажі';

  @override
  String get rfcInvestments => 'Інвестиції';

  @override
  String get rfcRent => 'Оренда';

  @override
  String get rfcFreelance => 'Фриланс';

  @override
  String get rfcDividends => 'Дивіденди';

  @override
  String get rfcTaxRefunds => 'Податкові повернення';

  @override
  String get rfcCashback => 'Кешбек';

  @override
  String get rfcOtherIncome => 'Інші доходи';

  @override
  String get rfcFoodAndDrinks => 'Їжа та напої';

  @override
  String get rfcGroceries => 'Продукти';

  @override
  String get rfcRestaurantsAndCafes => 'Ресторани та кафе';

  @override
  String get rfcTransport => 'Транспорт';

  @override
  String get rfcPublicTransport => 'Громадський транспорт';

  @override
  String get rfcPrivateTransport => 'Приватний транспорт';

  @override
  String get rfcFuel => 'Паливо';

  @override
  String get rfcParking => 'Паркування';

  @override
  String get rfcHousing => 'Житло';

  @override
  String get rfcRentExpenses => 'Оренда';

  @override
  String get rfcMortgage => 'Іпотека';

  @override
  String get rfcUtilities => 'Комунальні послуги';

  @override
  String get rfcRepairsAndMaintenance => 'Ремонт та обслуговування';

  @override
  String get rfcClothingAndFootwear => 'Одяг та взуття';

  @override
  String get rfcHealth => 'Здоров\'я';

  @override
  String get rfcMedicine => 'Ліки';

  @override
  String get rfcInsurance => 'Страхування';

  @override
  String get rfcDoctorVisits => 'Візити до лікаря';

  @override
  String get rfcEntertainment => 'Розваги';

  @override
  String get rfcMoviesAndTheater => 'Фільми та театр';

  @override
  String get rfcTravelAndVacations => 'Подорожі та відпустки';

  @override
  String get rfcHobbies => 'Хобі';

  @override
  String get rfcSportsAndFitness => 'Спорт та фітнес';

  @override
  String get rfcGymMemberships => 'Абонементи в спортзал';

  @override
  String get rfcSportsEvents => 'Спортивні події';

  @override
  String get rfcEducation => 'Освіта';

  @override
  String get rfcCoursesAndTraining => 'Курси та тренінги';

  @override
  String get rfcLearningMaterials => 'Навчальні матеріали';

  @override
  String get rfcLoansAndDebts => 'Позики та борги';

  @override
  String get rfcLoanPayments => 'Погашення позик';

  @override
  String get rfcLoanInterest => 'Процент по позикам';

  @override
  String get rfcPets => 'Домашні тварини';

  @override
  String get rfcFoodAndCare => 'Їжа та догляд';

  @override
  String get rfcVeterinary => 'Ветеринар';

  @override
  String get rfcGiftsAndCharity => 'Подарунки та благодійність';

  @override
  String get rfcInternetAndCommunication => 'Інтернет та зв\'язок';

  @override
  String get rfcPersonalExpenses => 'Особисті витрати';

  @override
  String get rfcInvestmentsExpenses => 'Інвестиції';

  @override
  String get rfcOtherExpenses => 'Інші витрати';

  @override
  String get rfcTransfer => 'Переказ';

  @override
  String get rfcAuto => 'Авто';

  @override
  String get rfcAutoFuel => 'Паливо';

  @override
  String get rfcAutoMaintenance => 'Обслуговування';

  @override
  String get rfcAutoInsurance => 'Страхування';

  @override
  String get rfcAutoRepairs => 'Ремонт';

  @override
  String get rfcAutoParking => 'Паркування';

  @override
  String get rfcAutoCarTolls => 'Дорожні збори';

  @override
  String get rfcAutoCarWash => 'Мийка авто';

  @override
  String get rfcAutoTires => 'Шини';

  @override
  String get rfcAutoRegistration => 'Реєстрація';

  @override
  String get settingTranTitle => 'Редагування';

  @override
  String get settingTranSave => 'Зберегти';

  @override
  String get settingTranIncome => 'дохід';

  @override
  String get settingTranExpenses => 'витрата';

  @override
  String get settingTranAmount => 'сума';

  @override
  String get settingTranCategory => 'категорія';

  @override
  String get settingTranDescription => 'примітка';

  @override
  String get totalSum => 'Баланс';

  @override
  String get incomesSum => 'Доходи';

  @override
  String get expensesSum => 'Витрати';

  @override
  String totalHint(String period) {
    return 'за $period';
  }

  @override
  String get backupTitle => 'Архівація та Відновлення';

  @override
  String get backupButton => 'архівація та відновлення';

  @override
  String get backupFilename => 'ім\'я файлу';

  @override
  String get backupSize => 'розмір';

  @override
  String get backupArchiving => 'архівація';

  @override
  String get backupRecovery => 'відновлення';

  @override
  String get backupRestarting => 'Перезапуск';

  @override
  String get backupRestartingBody =>
      'Натисніть тут, щоб відкрити додаток знову.';

  @override
  String get walletsTitle => 'Мої гаманці';

  @override
  String get walletsButton => 'мої гаманці';

  @override
  String get transactionsTitle => 'Транзакції';

  @override
  String get error => 'Помилка';

  @override
  String get success => 'Успіх';

  @override
  String get backupSavedSuccess => 'Резервну копію успішно збережено';

  @override
  String get backupRestoredSuccess => 'Дані успішно відновлено';

  @override
  String get backupDeletedSuccess => 'Резервну копію успішно видалено';

  @override
  String get driveErrorRead => 'Помилка читання файлів у хмарі';

  @override
  String get driveErrorDelete => 'Помилка видалення файлу у хмарі';

  @override
  String get driveErrorDownload => 'Помилка завантаження з хмари';

  @override
  String get backupErrorMsg => 'Обраний файл не у форматі \"db\"';

  @override
  String get labelSubcategory => 'підкатегорія';

  @override
  String get signOutWithGoogle => 'Вийти з Google';

  @override
  String get signInWithGoogle => 'Увійти через Google';

  @override
  String get backupCloudDialogDelete => 'Підтвердити видалення';

  @override
  String get backupCloudDialogDeleteContent =>
      'Ви впевнені, що хочете видалити цей файл?';

  @override
  String get backupCloudDialogRecovery => 'Підтвердити відновлення';

  @override
  String get backupCloudDialogRecoveryContent =>
      'Ви впевнені, що хочете відновити цей файл?';

  @override
  String get backupCreateCloudRecovery => 'Створити резервну копію в хмарі';

  @override
  String get backupCloudEmpty => 'Хмара порожня';
}
