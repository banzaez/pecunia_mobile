// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get yes => 'tak';

  @override
  String get no => 'nie';

  @override
  String get bottomSheetClose => 'Zamknij';

  @override
  String get light => 'jasny';

  @override
  String get dark => 'ciemny';

  @override
  String get labelCategory => 'kategoria';

  @override
  String get homeButtonIncome => 'dochód';

  @override
  String get homeButtonExpense => 'wydatek';

  @override
  String get profileTitle => 'Ustawienia profilu';

  @override
  String get profileMyWallets => 'moje portfele';

  @override
  String get profileTheme => 'motyw';

  @override
  String get profileMainCurrency => 'główna waluta';

  @override
  String get profileSupport => 'wsparcie';

  @override
  String get profileEdit => 'edytuj';

  @override
  String get settingWalletTitleAdd => 'Utwórz portfel';

  @override
  String get settingWalletTitleUpdate => 'Ustawienia bieżącego portfela';

  @override
  String get settingWalletName => 'nazwa*';

  @override
  String get settingWalletDescription => 'uwaga';

  @override
  String get settingWalletCurrency => 'waluta*';

  @override
  String get settingWalletShowBalance => 'pokazuj saldo na stronie głównej';

  @override
  String get settingWalletIsRoundUp => 'zaokrąglaj kwoty do całych';

  @override
  String get settingWalletButtonAdd => 'dodaj portfel';

  @override
  String get settingWalletButtonSave => 'Zapisz';

  @override
  String get settingWalletErrorName => 'Wprowadź nazwę';

  @override
  String get settingWalletErrorCurrency => 'Wprowadź uwagę';

  @override
  String get walletItemName => 'nazwa';

  @override
  String get walletItemDescription => 'uwaga';

  @override
  String get currentWalletTitle => 'bieżący portfel';

  @override
  String get currentWalletBottomTitle => 'twoje portfele';

  @override
  String get tranItemToday => 'dzisiaj';

  @override
  String get tranItemYesterday => 'wczoraj';

  @override
  String get tranItemIncome => 'dochody z';

  @override
  String get tranItemExpense => 'wydatki na';

  @override
  String get tranItemErrorAmount => 'Wprowadź kwotę';

  @override
  String get tranItemErrorCategory => 'Wprowadź kategorię';

  @override
  String get dialogDeleteTitle => 'Potwierdź';

  @override
  String get dialogDeleteContent => 'Czy na pewno chcesz usunąć ten element?';

  @override
  String get dialogDeleteDelete => 'Usuń';

  @override
  String get dialogDeleteCancel => 'Anuluj';

  @override
  String get analyticsTitle => 'Analityka';

  @override
  String get analyticsCategoryItemCount => 'transakcji';

  @override
  String analyticsCategoryPeriod(String period) {
    return 'za okres $period roku';
  }

  @override
  String analyticsCategoryEmpty(String period) {
    return 'brak analizy za okres $period';
  }

  @override
  String get analyticsCategoryEmptyDesc =>
      'Dodaj transakcje lub wybierz inny okres, aby zobaczyć szczegółowe wykresy analityczne.';

  @override
  String get analyticsIncome => 'dochody';

  @override
  String get analyticsExpenses => 'wydatki';

  @override
  String get analyticsTotal => 'razem';

  @override
  String get analyticsTotalPeriod => 'łącznie';

  @override
  String get walletFieldEmpty => 'wybierz portfel';

  @override
  String get transferTitle => 'przelew między portfelami';

  @override
  String get transferAmount => 'kwota';

  @override
  String get transferExchangeRate => 'kurs wymiany';

  @override
  String get transferTotal => 'suma';

  @override
  String get transferDone => 'gotowe';

  @override
  String get transferErrorWallet => 'Wybierz różne portfele';

  @override
  String transferDescription(String from, String to, String rate) {
    return 'przelew z $from do $to, kurs wymiany $rate';
  }

  @override
  String get from => 'z';

  @override
  String get to => 'do';

  @override
  String get rfcSalary => 'Wynagrodzenie';

  @override
  String get rfcBonuses => 'Premie';

  @override
  String get rfcGifts => 'Prezenty';

  @override
  String get rfcSales => 'Sprzedaż';

  @override
  String get rfcInvestments => 'Inwestycje';

  @override
  String get rfcRent => 'Czynsz';

  @override
  String get rfcFreelance => 'Freelance';

  @override
  String get rfcDividends => 'Dywidendy';

  @override
  String get rfcTaxRefunds => 'Zwroty podatkowe';

  @override
  String get rfcCashback => 'Cashback';

  @override
  String get rfcOtherIncome => 'Inne dochody';

  @override
  String get rfcFoodAndDrinks => 'Jedzenie i napoje';

  @override
  String get rfcGroceries => 'Zakupy spożywcze';

  @override
  String get rfcRestaurantsAndCafes => 'Restauracje i kawiarnie';

  @override
  String get rfcTransport => 'Transport';

  @override
  String get rfcPublicTransport => 'Transport publiczny';

  @override
  String get rfcPrivateTransport => 'Transport prywatny';

  @override
  String get rfcFuel => 'Paliwo';

  @override
  String get rfcParking => 'Parking';

  @override
  String get rfcHousing => 'Zakwaterowanie';

  @override
  String get rfcRentExpenses => 'Czynsz';

  @override
  String get rfcMortgage => 'Kredyt hipoteczny';

  @override
  String get rfcUtilities => 'Media';

  @override
  String get rfcRepairsAndMaintenance => 'Naprawy i konserwacja';

  @override
  String get rfcClothingAndFootwear => 'Odzież i obuwie';

  @override
  String get rfcHealth => 'Zdrowie';

  @override
  String get rfcMedicine => 'Leki';

  @override
  String get rfcInsurance => 'Ubezpieczenie';

  @override
  String get rfcDoctorVisits => 'Wizyty u lekarza';

  @override
  String get rfcEntertainment => 'Rozrywka';

  @override
  String get rfcMoviesAndTheater => 'Filmy i teatr';

  @override
  String get rfcTravelAndVacations => 'Podróże i wakacje';

  @override
  String get rfcHobbies => 'Hobby';

  @override
  String get rfcSportsAndFitness => 'Sport i fitness';

  @override
  String get rfcGymMemberships => 'Karnety na siłownię';

  @override
  String get rfcSportsEvents => 'Wydarzenia sportowe';

  @override
  String get rfcEducation => 'Edukacja';

  @override
  String get rfcCoursesAndTraining => 'Kursy i szkolenia';

  @override
  String get rfcLearningMaterials => 'Materiały edukacyjne';

  @override
  String get rfcLoansAndDebts => 'Pożyczki i długi';

  @override
  String get rfcLoanPayments => 'Spłaty pożyczek';

  @override
  String get rfcLoanInterest => 'Odsetki od pożyczek';

  @override
  String get rfcPets => 'Zwierzęta';

  @override
  String get rfcFoodAndCare => 'Jedzenie i opieka';

  @override
  String get rfcVeterinary => 'Weterynarz';

  @override
  String get rfcGiftsAndCharity => 'Prezenty i charytatywność';

  @override
  String get rfcInternetAndCommunication => 'Internet i komunikacja';

  @override
  String get rfcPersonalExpenses => 'Wydatki osobiste';

  @override
  String get rfcInvestmentsExpenses => 'Inwestycje';

  @override
  String get rfcOtherExpenses => 'Inne wydatki';

  @override
  String get rfcTransfer => 'Przelew';

  @override
  String get rfcAuto => 'Auto';

  @override
  String get rfcAutoFuel => 'Paliwo';

  @override
  String get rfcAutoMaintenance => 'Konserwacja';

  @override
  String get rfcAutoInsurance => 'Ubezpieczenie';

  @override
  String get rfcAutoRepairs => 'Naprawy';

  @override
  String get rfcAutoParking => 'Parking';

  @override
  String get rfcAutoCarTolls => 'Opłaty drogowe';

  @override
  String get rfcAutoCarWash => 'Myjnia samochodowa';

  @override
  String get rfcAutoTires => 'Opony';

  @override
  String get rfcAutoRegistration => 'Rejestracja';

  @override
  String get settingTranTitle => 'Edycja';

  @override
  String get settingTranTitleNew => 'Nowa transakcja';

  @override
  String get settingTranSave => 'Zapisz';

  @override
  String get settingTranIncome => 'dochód';

  @override
  String get settingTranExpenses => 'wydatek';

  @override
  String get settingTranAmount => 'kwota';

  @override
  String get settingTranCategory => 'kategoria';

  @override
  String get settingTranDescription => 'uwaga';

  @override
  String get totalSum => 'Saldo';

  @override
  String get incomesSum => 'Przychody';

  @override
  String get expensesSum => 'Wydatki';

  @override
  String totalHint(String period) {
    return 'dla $period';
  }

  @override
  String get backupTitle => 'Archiwizacja i Odzyskiwanie';

  @override
  String get backupButton => 'archiwizacja i odzyskiwanie';

  @override
  String get backupFilename => 'nazwa pliku';

  @override
  String get backupSize => 'rozmiar';

  @override
  String get backupArchiving => 'archiwizacja';

  @override
  String get backupRecovery => 'odzyskiwanie';

  @override
  String get backupRestarting => 'Restartowanie';

  @override
  String get backupRestartingBody =>
      'Kliknij tutaj, aby ponownie otworzyć aplikację.';

  @override
  String get walletsTitle => 'Moje portfele';

  @override
  String get walletsButton => 'moje portfele';

  @override
  String get transactionsTitle => 'Transakcje';

  @override
  String get error => 'Błąd';

  @override
  String get success => 'Sukces';

  @override
  String get backupSavedSuccess => 'Kopia zapasowa zapisana pomyślnie';

  @override
  String get backupRestoredSuccess => 'Dane przywrócone pomyślnie';

  @override
  String get backupDeletedSuccess => 'Kopia zapasowa usunięta pomyślnie';

  @override
  String get driveErrorRead => 'Błąd odczytu plików Drive';

  @override
  String get driveErrorDelete => 'Błąd usunięcia pliku Drive';

  @override
  String get driveErrorDownload => 'Błąd pobierania z Drive';

  @override
  String get driveErrorCreate => 'Błąd przesyłania kopii zapasowej do Drive';

  @override
  String get backupCancelled => 'Zapisywanie kopii zapasowej anulowane';

  @override
  String get backupErrorMsg => 'Wybrany plik nie jest w formacie \"db\"';

  @override
  String get labelSubcategory => 'podkategoria';

  @override
  String get signOutWithGoogle => 'Wyloguj się z Google';

  @override
  String get signInWithGoogle => 'Zaloguj się przez Google';

  @override
  String get backupCloudDialogDelete => 'Potwierdź usunięcie';

  @override
  String get backupCloudDialogDeleteContent =>
      'Czy na pewno chcesz usunąć ten plik?';

  @override
  String get backupCloudDialogRecovery => 'Potwierdź przywracanie';

  @override
  String get backupCloudDialogRecoveryContent =>
      'Czy na pewno chcesz przywrócić ten plik?';

  @override
  String get backupCreateCloudRecovery => 'Utwórz kopię zapasową w chmurze';

  @override
  String get backupCloudEmpty => 'Chmura jest pusta';

  @override
  String get startupErrorTitle => 'Nie udało się uruchomić aplikacji';

  @override
  String get startupErrorRetry => 'Spróbuj ponownie';

  @override
  String get dataLoadError => 'Nie udało się załadować danych';

  @override
  String get routeErrorTitle => 'Nie znaleziono strony';

  @override
  String get routeErrorHome => 'Strona główna';

  @override
  String get walletDeleteLastError => 'Nie można usunąć ostatniego portfela';

  @override
  String get driveScopeError =>
      'Brak dostępu do Google Drive. Wyloguj się i zaloguj ponownie.';

  @override
  String get monthlySummary => 'Podsumowanie miesiąca';

  @override
  String get searchPlaceholder => 'Szukaj według opisu, kategorii lub kwoty...';

  @override
  String get emptySearchTitle => 'Nic nie znaleziono';

  @override
  String get emptySearchDesc =>
      'Spróbuj zmienić zapytanie lub zresetować filtry.';

  @override
  String get emptyTransactionsTitle => 'Brak transakcji';

  @override
  String get emptyTransactionsDesc =>
      'W tej kategorii w wybranym okresie nie znaleziono żadnych operacji.';

  @override
  String get totalForPeriod => 'Łącznie za okres';

  @override
  String get dateToday => 'Dzisiaj';

  @override
  String get dateYesterday => 'Wczoraj';

  @override
  String get emptyHistoryTitle => 'Historia jest pusta';

  @override
  String get emptyHistoryDesc =>
      'Tutaj będą wyświetlane Twoje ostatnie transakcje dla tego portfela.';

  @override
  String get profileDonate => 'wesprzyj projekt';

  @override
  String get donateTitle => 'Wsparcie Projektu';

  @override
  String get donateThanks => 'Dziękujemy za korzystanie z Pecunii!';

  @override
  String get donateDescription =>
      'Jeśli podoba Ci się aplikacja, możesz wesprzeć autora darowizną lub napisać swoje opinie i sugestie na e-mail.';

  @override
  String get donateContactAuthor => 'Skontaktuj się z autorem';

  @override
  String get donateCrypto => 'Przekaż darowiznę w krypto';

  @override
  String get donateCoinNetwork => 'Moneta / Sieć';

  @override
  String get donateWalletAddress => 'Adres portfela';

  @override
  String get donateCopy => 'Kopiuj';

  @override
  String get donateCopied => 'Adres skopiowany do schowka';
}
