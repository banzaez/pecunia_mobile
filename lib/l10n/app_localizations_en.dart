// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get yes => 'yes';

  @override
  String get no => 'no';

  @override
  String get bottomSheetClose => 'Close';

  @override
  String get light => 'light';

  @override
  String get dark => 'dark';

  @override
  String get labelCategory => 'category';

  @override
  String get homeButtonIncome => 'income';

  @override
  String get homeButtonExpense => 'expense';

  @override
  String get homeWalletSwipeHint => 'Swipe to switch wallets';

  @override
  String get profileTitle => 'Profile settings';

  @override
  String get profileMyWallets => 'my wallets';

  @override
  String get profileTheme => 'theme';

  @override
  String get profileMainCurrency => 'main currency';

  @override
  String get profileSupport => 'support';

  @override
  String get profileEdit => 'edit';

  @override
  String get settingWalletTitleAdd => 'Create a wallet';

  @override
  String get settingWalletTitleUpdate => 'Current wallet settings';

  @override
  String get settingWalletName => 'name*';

  @override
  String get settingWalletDescription => 'description';

  @override
  String get settingWalletCurrency => 'currency*';

  @override
  String get settingWalletShowBalance => 'show balance on main';

  @override
  String get settingWalletIsRoundUp => 'round amounts to whole numbers';

  @override
  String get settingWalletButtonAdd => 'add wallet';

  @override
  String get settingWalletButtonSave => 'Save';

  @override
  String get settingWalletErrorName => 'Enter the name';

  @override
  String get settingWalletErrorCurrency => 'Enter the description';

  @override
  String get walletItemName => 'name';

  @override
  String get walletItemDescription => 'description';

  @override
  String get currentWalletTitle => 'current wallet';

  @override
  String get currentWalletBottomTitle => 'your wallets';

  @override
  String get tranItemToday => 'today';

  @override
  String get tranItemYesterday => 'yesterday';

  @override
  String get tranItemIncome => 'income from';

  @override
  String get tranItemExpense => 'expenses on';

  @override
  String get tranItemErrorAmount => 'Enter the amount';

  @override
  String get tranItemErrorCategory => 'Enter the category';

  @override
  String get dialogDeleteTitle => 'Confirm';

  @override
  String get dialogDeleteContent =>
      'Are you sure you wish to delete this item?';

  @override
  String get dialogDeleteDelete => 'Delete';

  @override
  String get dialogDeleteCancel => 'Cancel';

  @override
  String get analyticsTitle => 'Analytics';

  @override
  String get analyticsCategoryItemCount => 'transactions';

  @override
  String analyticsCategoryPeriod(String period) {
    return 'for the period $period';
  }

  @override
  String analyticsCategoryEmpty(String period) {
    return 'there are no analytics for the period $period';
  }

  @override
  String get analyticsCategoryEmptyDesc =>
      'Add transactions or select another period to see detailed analytics charts.';

  @override
  String get analyticsIncome => 'income';

  @override
  String get analyticsExpenses => 'expenses';

  @override
  String get analyticsTotal => 'total';

  @override
  String get analyticsTotalPeriod => 'total';

  @override
  String get walletFieldEmpty => 'choose a wallet';

  @override
  String get transferTitle => 'transfer between wallets';

  @override
  String get transferAmount => 'amount';

  @override
  String get transferExchangeRate => 'exchange rate';

  @override
  String get transferTotal => 'total';

  @override
  String get transferDone => 'done';

  @override
  String get transferErrorWallet => 'Enter different wallets';

  @override
  String transferDescription(String from, String to, String rate) {
    return 'transfer from $from to $to, exchange rate $rate';
  }

  @override
  String get from => 'from';

  @override
  String get to => 'to';

  @override
  String get rfcSalary => 'Salary';

  @override
  String get rfcBonuses => 'Bonuses';

  @override
  String get rfcGifts => 'Gifts';

  @override
  String get rfcSales => 'Sales';

  @override
  String get rfcInvestments => 'Investments';

  @override
  String get rfcRent => 'Rent';

  @override
  String get rfcFreelance => 'Freelance';

  @override
  String get rfcDividends => 'Dividends';

  @override
  String get rfcTaxRefunds => 'Tax Refunds';

  @override
  String get rfcCashback => 'Cashback';

  @override
  String get rfcOtherIncome => 'Other Income';

  @override
  String get rfcFoodAndDrinks => 'Food & Drinks';

  @override
  String get rfcGroceries => 'Groceries';

  @override
  String get rfcRestaurantsAndCafes => 'Restaurants & Cafes';

  @override
  String get rfcTransport => 'Transport';

  @override
  String get rfcPublicTransport => 'Public Transport';

  @override
  String get rfcPrivateTransport => 'Private Transport';

  @override
  String get rfcFuel => 'Fuel';

  @override
  String get rfcParking => 'Parking';

  @override
  String get rfcHousing => 'Housing';

  @override
  String get rfcRentExpenses => 'Rent';

  @override
  String get rfcMortgage => 'Mortgage';

  @override
  String get rfcUtilities => 'Utilities';

  @override
  String get rfcRepairsAndMaintenance => 'Repairs & Maintenance';

  @override
  String get rfcClothingAndFootwear => 'Clothing & Footwear';

  @override
  String get rfcHealth => 'Health';

  @override
  String get rfcMedicine => 'Medicine';

  @override
  String get rfcInsurance => 'Insurance';

  @override
  String get rfcDoctorVisits => 'Doctor Visits';

  @override
  String get rfcEntertainment => 'Entertainment';

  @override
  String get rfcMoviesAndTheater => 'Movies & Theater';

  @override
  String get rfcTravelAndVacations => 'Travel & Vacations';

  @override
  String get rfcHobbies => 'Hobbies';

  @override
  String get rfcSportsAndFitness => 'Sports & Fitness';

  @override
  String get rfcGymMemberships => 'Gym Memberships';

  @override
  String get rfcSportsEvents => 'Sports Events';

  @override
  String get rfcEducation => 'Education';

  @override
  String get rfcCoursesAndTraining => 'Courses & Training';

  @override
  String get rfcLearningMaterials => 'Learning Materials';

  @override
  String get rfcLoansAndDebts => 'Loans & Debts';

  @override
  String get rfcLoanPayments => 'Loan Payments';

  @override
  String get rfcLoanInterest => 'Loan Interest';

  @override
  String get rfcPets => 'Pets';

  @override
  String get rfcFoodAndCare => 'Food & Care';

  @override
  String get rfcVeterinary => 'Veterinary';

  @override
  String get rfcGiftsAndCharity => 'Gifts & Charity';

  @override
  String get rfcInternetAndCommunication => 'Internet & Communication';

  @override
  String get rfcPersonalExpenses => 'Personal Expenses';

  @override
  String get rfcInvestmentsExpenses => 'Investments';

  @override
  String get rfcOtherExpenses => 'Other Expenses';

  @override
  String get rfcTransfer => 'Transfer';

  @override
  String get rfcAuto => 'Auto';

  @override
  String get rfcAutoFuel => 'Fuel';

  @override
  String get rfcAutoMaintenance => 'Maintenance';

  @override
  String get rfcAutoInsurance => 'Insurance';

  @override
  String get rfcAutoRepairs => 'Repairs';

  @override
  String get rfcAutoParking => 'Parking';

  @override
  String get rfcAutoCarTolls => 'Tolls';

  @override
  String get rfcAutoCarWash => 'Car Wash';

  @override
  String get rfcAutoTires => 'Tires';

  @override
  String get rfcAutoRegistration => 'Registration';

  @override
  String get settingTranTitle => 'Edit';

  @override
  String get settingTranTitleNew => 'New transaction';

  @override
  String get settingTranSave => 'Save';

  @override
  String get settingTranIncome => 'income';

  @override
  String get settingTranExpenses => 'expenses';

  @override
  String get settingTranAmount => 'amount';

  @override
  String get settingTranCategory => 'category';

  @override
  String get settingTranDescription => 'description';

  @override
  String get totalSum => 'Balance';

  @override
  String get incomesSum => 'Incomes';

  @override
  String get expensesSum => 'Expenses';

  @override
  String totalHint(String period) {
    return 'for $period';
  }

  @override
  String get backupTitle => 'Archiving & Recovery';

  @override
  String get backupButton => 'archiving & recovery';

  @override
  String get backupFilename => 'filename';

  @override
  String get backupSize => 'size';

  @override
  String get backupArchiving => 'archiving';

  @override
  String get backupRecovery => 'recovery';

  @override
  String get backupRestarting => 'Restarting';

  @override
  String get backupRestartingBody => 'Please tap here to open the app again.';

  @override
  String get walletsTitle => 'My wallets';

  @override
  String get walletsButton => 'my wallets';

  @override
  String get transactionsTitle => 'Transactions';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get backupSavedSuccess => 'Backup successfully saved';

  @override
  String get backupRestoredSuccess => 'Data successfully restored';

  @override
  String get backupDeletedSuccess => 'Backup deleted successfully';

  @override
  String get driveErrorRead => 'Error reading Drive files';

  @override
  String get driveErrorDelete => 'Error deleting Drive file';

  @override
  String get driveErrorDownload => 'Error downloading from Drive';

  @override
  String get driveErrorCreate => 'Error uploading backup to Drive';

  @override
  String get backupCancelled => 'Backup save cancelled';

  @override
  String get backupErrorMsg => 'The selected file is not in \"db\" format';

  @override
  String get labelSubcategory => 'subcategory';

  @override
  String get signOutWithGoogle => 'Sign out with Google';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get backupCloudDialogDelete => 'Confirm deletion';

  @override
  String get backupCloudDialogDeleteContent =>
      'Are you sure you want to delete this file?';

  @override
  String get backupCloudDialogRecovery => 'Confirm recovery';

  @override
  String get backupCloudDialogRecoveryContent =>
      'Are you sure you want to recover this file?';

  @override
  String get backupCreateCloudRecovery => 'Create cloud recovery';

  @override
  String get backupCloudEmpty => 'The cloud is empty';

  @override
  String get startupErrorTitle => 'Failed to start the app';

  @override
  String get startupErrorRetry => 'Retry';

  @override
  String get dataLoadError => 'Failed to load data';

  @override
  String get routeErrorTitle => 'Page not found';

  @override
  String get routeErrorHome => 'Go to home';

  @override
  String get walletDeleteLastError => 'Cannot delete the last wallet';

  @override
  String get driveScopeError =>
      'Google Drive access was not granted. Sign out and sign in again.';

  @override
  String get monthlySummary => 'Monthly summary';

  @override
  String get searchPlaceholder =>
      'Search by description, category, or amount...';

  @override
  String get emptySearchTitle => 'No results found';

  @override
  String get emptySearchDesc =>
      'Try changing your search query or clearing the filter.';

  @override
  String get emptyTransactionsTitle => 'No transactions';

  @override
  String get emptyTransactionsDesc =>
      'No operations found in this category for the selected period.';

  @override
  String get totalForPeriod => 'Total for period';

  @override
  String get dateToday => 'Today';

  @override
  String get dateYesterday => 'Yesterday';

  @override
  String get emptyHistoryTitle => 'History is empty';

  @override
  String get emptyHistoryDesc =>
      'Your recent transactions for this wallet will appear here.';

  @override
  String get profileDonate => 'support project';

  @override
  String get donateTitle => 'Support Project';

  @override
  String get donateThanks => 'Thanks for using Pecunia!';

  @override
  String get donateDescription =>
      'If you like the app, you can support the author with a donation or write your feedback and suggestions to the email.';

  @override
  String get donateContactAuthor => 'Contact the author';

  @override
  String get donateCrypto => 'Donate crypto';

  @override
  String get donateCoinNetwork => 'Coin / Network';

  @override
  String get donateWalletAddress => 'Wallet address';

  @override
  String get donateCopy => 'Copy';

  @override
  String get donateCopied => 'Address copied to clipboard';
}
