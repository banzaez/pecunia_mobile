import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uk.dart';

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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('es'),
    Locale('fr'),
    Locale('pl'),
    Locale('uk'),
  ];

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'no'**
  String get no;

  /// No description provided for @bottomSheetClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get bottomSheetClose;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'dark'**
  String get dark;

  /// No description provided for @labelCategory.
  ///
  /// In en, this message translates to:
  /// **'category'**
  String get labelCategory;

  /// No description provided for @homeButtonIncome.
  ///
  /// In en, this message translates to:
  /// **'income'**
  String get homeButtonIncome;

  /// No description provided for @homeButtonExpense.
  ///
  /// In en, this message translates to:
  /// **'expense'**
  String get homeButtonExpense;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile settings'**
  String get profileTitle;

  /// No description provided for @profileMyWallets.
  ///
  /// In en, this message translates to:
  /// **'my wallets'**
  String get profileMyWallets;

  /// No description provided for @profileTheme.
  ///
  /// In en, this message translates to:
  /// **'theme'**
  String get profileTheme;

  /// No description provided for @profileMainCurrency.
  ///
  /// In en, this message translates to:
  /// **'main currency'**
  String get profileMainCurrency;

  /// No description provided for @profileSupport.
  ///
  /// In en, this message translates to:
  /// **'support'**
  String get profileSupport;

  /// No description provided for @profileEdit.
  ///
  /// In en, this message translates to:
  /// **'edit'**
  String get profileEdit;

  /// No description provided for @settingWalletTitleAdd.
  ///
  /// In en, this message translates to:
  /// **'Create a wallet'**
  String get settingWalletTitleAdd;

  /// No description provided for @settingWalletTitleUpdate.
  ///
  /// In en, this message translates to:
  /// **'Current wallet settings'**
  String get settingWalletTitleUpdate;

  /// No description provided for @settingWalletName.
  ///
  /// In en, this message translates to:
  /// **'name*'**
  String get settingWalletName;

  /// No description provided for @settingWalletDescription.
  ///
  /// In en, this message translates to:
  /// **'description'**
  String get settingWalletDescription;

  /// No description provided for @settingWalletCurrency.
  ///
  /// In en, this message translates to:
  /// **'currency*'**
  String get settingWalletCurrency;

  /// No description provided for @settingWalletShowBalance.
  ///
  /// In en, this message translates to:
  /// **'show balance on main'**
  String get settingWalletShowBalance;

  /// No description provided for @settingWalletIsRoundUp.
  ///
  /// In en, this message translates to:
  /// **'round amounts to whole numbers'**
  String get settingWalletIsRoundUp;

  /// No description provided for @settingWalletButtonAdd.
  ///
  /// In en, this message translates to:
  /// **'add wallet'**
  String get settingWalletButtonAdd;

  /// No description provided for @settingWalletButtonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get settingWalletButtonSave;

  /// No description provided for @settingWalletErrorName.
  ///
  /// In en, this message translates to:
  /// **'Enter the name'**
  String get settingWalletErrorName;

  /// No description provided for @settingWalletErrorCurrency.
  ///
  /// In en, this message translates to:
  /// **'Enter the description'**
  String get settingWalletErrorCurrency;

  /// No description provided for @walletItemName.
  ///
  /// In en, this message translates to:
  /// **'name'**
  String get walletItemName;

  /// No description provided for @walletItemDescription.
  ///
  /// In en, this message translates to:
  /// **'description'**
  String get walletItemDescription;

  /// No description provided for @currentWalletTitle.
  ///
  /// In en, this message translates to:
  /// **'current wallet'**
  String get currentWalletTitle;

  /// No description provided for @currentWalletBottomTitle.
  ///
  /// In en, this message translates to:
  /// **'your wallets'**
  String get currentWalletBottomTitle;

  /// No description provided for @tranItemToday.
  ///
  /// In en, this message translates to:
  /// **'today'**
  String get tranItemToday;

  /// No description provided for @tranItemYesterday.
  ///
  /// In en, this message translates to:
  /// **'yesterday'**
  String get tranItemYesterday;

  /// No description provided for @tranItemIncome.
  ///
  /// In en, this message translates to:
  /// **'income from'**
  String get tranItemIncome;

  /// No description provided for @tranItemExpense.
  ///
  /// In en, this message translates to:
  /// **'expenses on'**
  String get tranItemExpense;

  /// No description provided for @tranItemErrorAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter the amount'**
  String get tranItemErrorAmount;

  /// No description provided for @tranItemErrorCategory.
  ///
  /// In en, this message translates to:
  /// **'Enter the category'**
  String get tranItemErrorCategory;

  /// No description provided for @dialogDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get dialogDeleteTitle;

  /// No description provided for @dialogDeleteContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you wish to delete this item?'**
  String get dialogDeleteContent;

  /// No description provided for @dialogDeleteDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get dialogDeleteDelete;

  /// No description provided for @dialogDeleteCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get dialogDeleteCancel;

  /// No description provided for @analyticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analyticsTitle;

  /// No description provided for @analyticsCategoryItemCount.
  ///
  /// In en, this message translates to:
  /// **'transactions'**
  String get analyticsCategoryItemCount;

  /// No description provided for @analyticsCategoryPeriod.
  ///
  /// In en, this message translates to:
  /// **'for the period {period}'**
  String analyticsCategoryPeriod(String period);

  /// No description provided for @analyticsCategoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'there are no analytics for the period {period}'**
  String analyticsCategoryEmpty(String period);

  /// No description provided for @analyticsCategoryEmptyDesc.
  ///
  /// In en, this message translates to:
  /// **'Add transactions or select another period to see detailed analytics charts.'**
  String get analyticsCategoryEmptyDesc;

  /// No description provided for @analyticsIncome.
  ///
  /// In en, this message translates to:
  /// **'income'**
  String get analyticsIncome;

  /// No description provided for @analyticsExpenses.
  ///
  /// In en, this message translates to:
  /// **'expenses'**
  String get analyticsExpenses;

  /// No description provided for @analyticsTotal.
  ///
  /// In en, this message translates to:
  /// **'total'**
  String get analyticsTotal;

  /// No description provided for @analyticsTotalPeriod.
  ///
  /// In en, this message translates to:
  /// **'total'**
  String get analyticsTotalPeriod;

  /// No description provided for @walletFieldEmpty.
  ///
  /// In en, this message translates to:
  /// **'choose a wallet'**
  String get walletFieldEmpty;

  /// No description provided for @transferTitle.
  ///
  /// In en, this message translates to:
  /// **'transfer between wallets'**
  String get transferTitle;

  /// No description provided for @transferAmount.
  ///
  /// In en, this message translates to:
  /// **'amount'**
  String get transferAmount;

  /// No description provided for @transferExchangeRate.
  ///
  /// In en, this message translates to:
  /// **'exchange rate'**
  String get transferExchangeRate;

  /// No description provided for @transferTotal.
  ///
  /// In en, this message translates to:
  /// **'total'**
  String get transferTotal;

  /// No description provided for @transferDone.
  ///
  /// In en, this message translates to:
  /// **'done'**
  String get transferDone;

  /// No description provided for @transferErrorWallet.
  ///
  /// In en, this message translates to:
  /// **'Enter different wallets'**
  String get transferErrorWallet;

  /// No description provided for @transferDescription.
  ///
  /// In en, this message translates to:
  /// **'transfer from {from} to {to}, exchange rate {rate}'**
  String transferDescription(String from, String to, String rate);

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'from'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get to;

  /// No description provided for @rfcSalary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get rfcSalary;

  /// No description provided for @rfcBonuses.
  ///
  /// In en, this message translates to:
  /// **'Bonuses'**
  String get rfcBonuses;

  /// No description provided for @rfcGifts.
  ///
  /// In en, this message translates to:
  /// **'Gifts'**
  String get rfcGifts;

  /// No description provided for @rfcSales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get rfcSales;

  /// No description provided for @rfcInvestments.
  ///
  /// In en, this message translates to:
  /// **'Investments'**
  String get rfcInvestments;

  /// No description provided for @rfcRent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get rfcRent;

  /// No description provided for @rfcFreelance.
  ///
  /// In en, this message translates to:
  /// **'Freelance'**
  String get rfcFreelance;

  /// No description provided for @rfcDividends.
  ///
  /// In en, this message translates to:
  /// **'Dividends'**
  String get rfcDividends;

  /// No description provided for @rfcTaxRefunds.
  ///
  /// In en, this message translates to:
  /// **'Tax Refunds'**
  String get rfcTaxRefunds;

  /// No description provided for @rfcCashback.
  ///
  /// In en, this message translates to:
  /// **'Cashback'**
  String get rfcCashback;

  /// No description provided for @rfcOtherIncome.
  ///
  /// In en, this message translates to:
  /// **'Other Income'**
  String get rfcOtherIncome;

  /// No description provided for @rfcFoodAndDrinks.
  ///
  /// In en, this message translates to:
  /// **'Food & Drinks'**
  String get rfcFoodAndDrinks;

  /// No description provided for @rfcGroceries.
  ///
  /// In en, this message translates to:
  /// **'Groceries'**
  String get rfcGroceries;

  /// No description provided for @rfcRestaurantsAndCafes.
  ///
  /// In en, this message translates to:
  /// **'Restaurants & Cafes'**
  String get rfcRestaurantsAndCafes;

  /// No description provided for @rfcTransport.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get rfcTransport;

  /// No description provided for @rfcPublicTransport.
  ///
  /// In en, this message translates to:
  /// **'Public Transport'**
  String get rfcPublicTransport;

  /// No description provided for @rfcPrivateTransport.
  ///
  /// In en, this message translates to:
  /// **'Private Transport'**
  String get rfcPrivateTransport;

  /// No description provided for @rfcFuel.
  ///
  /// In en, this message translates to:
  /// **'Fuel'**
  String get rfcFuel;

  /// No description provided for @rfcParking.
  ///
  /// In en, this message translates to:
  /// **'Parking'**
  String get rfcParking;

  /// No description provided for @rfcHousing.
  ///
  /// In en, this message translates to:
  /// **'Housing'**
  String get rfcHousing;

  /// No description provided for @rfcRentExpenses.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get rfcRentExpenses;

  /// No description provided for @rfcMortgage.
  ///
  /// In en, this message translates to:
  /// **'Mortgage'**
  String get rfcMortgage;

  /// No description provided for @rfcUtilities.
  ///
  /// In en, this message translates to:
  /// **'Utilities'**
  String get rfcUtilities;

  /// No description provided for @rfcRepairsAndMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Repairs & Maintenance'**
  String get rfcRepairsAndMaintenance;

  /// No description provided for @rfcClothingAndFootwear.
  ///
  /// In en, this message translates to:
  /// **'Clothing & Footwear'**
  String get rfcClothingAndFootwear;

  /// No description provided for @rfcHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get rfcHealth;

  /// No description provided for @rfcMedicine.
  ///
  /// In en, this message translates to:
  /// **'Medicine'**
  String get rfcMedicine;

  /// No description provided for @rfcInsurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get rfcInsurance;

  /// No description provided for @rfcDoctorVisits.
  ///
  /// In en, this message translates to:
  /// **'Doctor Visits'**
  String get rfcDoctorVisits;

  /// No description provided for @rfcEntertainment.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get rfcEntertainment;

  /// No description provided for @rfcMoviesAndTheater.
  ///
  /// In en, this message translates to:
  /// **'Movies & Theater'**
  String get rfcMoviesAndTheater;

  /// No description provided for @rfcTravelAndVacations.
  ///
  /// In en, this message translates to:
  /// **'Travel & Vacations'**
  String get rfcTravelAndVacations;

  /// No description provided for @rfcHobbies.
  ///
  /// In en, this message translates to:
  /// **'Hobbies'**
  String get rfcHobbies;

  /// No description provided for @rfcSportsAndFitness.
  ///
  /// In en, this message translates to:
  /// **'Sports & Fitness'**
  String get rfcSportsAndFitness;

  /// No description provided for @rfcGymMemberships.
  ///
  /// In en, this message translates to:
  /// **'Gym Memberships'**
  String get rfcGymMemberships;

  /// No description provided for @rfcSportsEvents.
  ///
  /// In en, this message translates to:
  /// **'Sports Events'**
  String get rfcSportsEvents;

  /// No description provided for @rfcEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get rfcEducation;

  /// No description provided for @rfcCoursesAndTraining.
  ///
  /// In en, this message translates to:
  /// **'Courses & Training'**
  String get rfcCoursesAndTraining;

  /// No description provided for @rfcLearningMaterials.
  ///
  /// In en, this message translates to:
  /// **'Learning Materials'**
  String get rfcLearningMaterials;

  /// No description provided for @rfcLoansAndDebts.
  ///
  /// In en, this message translates to:
  /// **'Loans & Debts'**
  String get rfcLoansAndDebts;

  /// No description provided for @rfcLoanPayments.
  ///
  /// In en, this message translates to:
  /// **'Loan Payments'**
  String get rfcLoanPayments;

  /// No description provided for @rfcLoanInterest.
  ///
  /// In en, this message translates to:
  /// **'Loan Interest'**
  String get rfcLoanInterest;

  /// No description provided for @rfcPets.
  ///
  /// In en, this message translates to:
  /// **'Pets'**
  String get rfcPets;

  /// No description provided for @rfcFoodAndCare.
  ///
  /// In en, this message translates to:
  /// **'Food & Care'**
  String get rfcFoodAndCare;

  /// No description provided for @rfcVeterinary.
  ///
  /// In en, this message translates to:
  /// **'Veterinary'**
  String get rfcVeterinary;

  /// No description provided for @rfcGiftsAndCharity.
  ///
  /// In en, this message translates to:
  /// **'Gifts & Charity'**
  String get rfcGiftsAndCharity;

  /// No description provided for @rfcInternetAndCommunication.
  ///
  /// In en, this message translates to:
  /// **'Internet & Communication'**
  String get rfcInternetAndCommunication;

  /// No description provided for @rfcPersonalExpenses.
  ///
  /// In en, this message translates to:
  /// **'Personal Expenses'**
  String get rfcPersonalExpenses;

  /// No description provided for @rfcInvestmentsExpenses.
  ///
  /// In en, this message translates to:
  /// **'Investments'**
  String get rfcInvestmentsExpenses;

  /// No description provided for @rfcOtherExpenses.
  ///
  /// In en, this message translates to:
  /// **'Other Expenses'**
  String get rfcOtherExpenses;

  /// No description provided for @rfcTransfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get rfcTransfer;

  /// No description provided for @rfcAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get rfcAuto;

  /// No description provided for @rfcAutoFuel.
  ///
  /// In en, this message translates to:
  /// **'Fuel'**
  String get rfcAutoFuel;

  /// No description provided for @rfcAutoMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get rfcAutoMaintenance;

  /// No description provided for @rfcAutoInsurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get rfcAutoInsurance;

  /// No description provided for @rfcAutoRepairs.
  ///
  /// In en, this message translates to:
  /// **'Repairs'**
  String get rfcAutoRepairs;

  /// No description provided for @rfcAutoParking.
  ///
  /// In en, this message translates to:
  /// **'Parking'**
  String get rfcAutoParking;

  /// No description provided for @rfcAutoCarTolls.
  ///
  /// In en, this message translates to:
  /// **'Tolls'**
  String get rfcAutoCarTolls;

  /// No description provided for @rfcAutoCarWash.
  ///
  /// In en, this message translates to:
  /// **'Car Wash'**
  String get rfcAutoCarWash;

  /// No description provided for @rfcAutoTires.
  ///
  /// In en, this message translates to:
  /// **'Tires'**
  String get rfcAutoTires;

  /// No description provided for @rfcAutoRegistration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get rfcAutoRegistration;

  /// No description provided for @settingTranTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get settingTranTitle;

  /// No description provided for @settingTranTitleNew.
  ///
  /// In en, this message translates to:
  /// **'New transaction'**
  String get settingTranTitleNew;

  /// No description provided for @settingTranSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get settingTranSave;

  /// No description provided for @settingTranIncome.
  ///
  /// In en, this message translates to:
  /// **'income'**
  String get settingTranIncome;

  /// No description provided for @settingTranExpenses.
  ///
  /// In en, this message translates to:
  /// **'expenses'**
  String get settingTranExpenses;

  /// No description provided for @settingTranAmount.
  ///
  /// In en, this message translates to:
  /// **'amount'**
  String get settingTranAmount;

  /// No description provided for @settingTranCategory.
  ///
  /// In en, this message translates to:
  /// **'category'**
  String get settingTranCategory;

  /// No description provided for @settingTranDescription.
  ///
  /// In en, this message translates to:
  /// **'description'**
  String get settingTranDescription;

  /// No description provided for @totalSum.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get totalSum;

  /// No description provided for @incomesSum.
  ///
  /// In en, this message translates to:
  /// **'Incomes'**
  String get incomesSum;

  /// No description provided for @expensesSum.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expensesSum;

  /// No description provided for @totalHint.
  ///
  /// In en, this message translates to:
  /// **'for {period}'**
  String totalHint(String period);

  /// No description provided for @backupTitle.
  ///
  /// In en, this message translates to:
  /// **'Archiving & Recovery'**
  String get backupTitle;

  /// No description provided for @backupButton.
  ///
  /// In en, this message translates to:
  /// **'archiving & recovery'**
  String get backupButton;

  /// No description provided for @backupFilename.
  ///
  /// In en, this message translates to:
  /// **'filename'**
  String get backupFilename;

  /// No description provided for @backupSize.
  ///
  /// In en, this message translates to:
  /// **'size'**
  String get backupSize;

  /// No description provided for @backupArchiving.
  ///
  /// In en, this message translates to:
  /// **'archiving'**
  String get backupArchiving;

  /// No description provided for @backupRecovery.
  ///
  /// In en, this message translates to:
  /// **'recovery'**
  String get backupRecovery;

  /// No description provided for @backupRestarting.
  ///
  /// In en, this message translates to:
  /// **'Restarting'**
  String get backupRestarting;

  /// No description provided for @backupRestartingBody.
  ///
  /// In en, this message translates to:
  /// **'Please tap here to open the app again.'**
  String get backupRestartingBody;

  /// No description provided for @walletsTitle.
  ///
  /// In en, this message translates to:
  /// **'My wallets'**
  String get walletsTitle;

  /// No description provided for @walletsButton.
  ///
  /// In en, this message translates to:
  /// **'my wallets'**
  String get walletsButton;

  /// No description provided for @transactionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactionsTitle;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @backupSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Backup successfully saved'**
  String get backupSavedSuccess;

  /// No description provided for @backupRestoredSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data successfully restored'**
  String get backupRestoredSuccess;

  /// No description provided for @backupDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Backup deleted successfully'**
  String get backupDeletedSuccess;

  /// No description provided for @driveErrorRead.
  ///
  /// In en, this message translates to:
  /// **'Error reading Drive files'**
  String get driveErrorRead;

  /// No description provided for @driveErrorDelete.
  ///
  /// In en, this message translates to:
  /// **'Error deleting Drive file'**
  String get driveErrorDelete;

  /// No description provided for @driveErrorDownload.
  ///
  /// In en, this message translates to:
  /// **'Error downloading from Drive'**
  String get driveErrorDownload;

  /// No description provided for @driveErrorCreate.
  ///
  /// In en, this message translates to:
  /// **'Error uploading backup to Drive'**
  String get driveErrorCreate;

  /// No description provided for @backupCancelled.
  ///
  /// In en, this message translates to:
  /// **'Backup save cancelled'**
  String get backupCancelled;

  /// No description provided for @backupErrorMsg.
  ///
  /// In en, this message translates to:
  /// **'The selected file is not in \"db\" format'**
  String get backupErrorMsg;

  /// No description provided for @labelSubcategory.
  ///
  /// In en, this message translates to:
  /// **'subcategory'**
  String get labelSubcategory;

  /// No description provided for @signOutWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign out with Google'**
  String get signOutWithGoogle;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// No description provided for @backupCloudDialogDelete.
  ///
  /// In en, this message translates to:
  /// **'Confirm deletion'**
  String get backupCloudDialogDelete;

  /// No description provided for @backupCloudDialogDeleteContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this file?'**
  String get backupCloudDialogDeleteContent;

  /// No description provided for @backupCloudDialogRecovery.
  ///
  /// In en, this message translates to:
  /// **'Confirm recovery'**
  String get backupCloudDialogRecovery;

  /// No description provided for @backupCloudDialogRecoveryContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to recover this file?'**
  String get backupCloudDialogRecoveryContent;

  /// No description provided for @backupCreateCloudRecovery.
  ///
  /// In en, this message translates to:
  /// **'Create cloud recovery'**
  String get backupCreateCloudRecovery;

  /// No description provided for @backupCloudEmpty.
  ///
  /// In en, this message translates to:
  /// **'The cloud is empty'**
  String get backupCloudEmpty;

  /// No description provided for @startupErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Failed to start the app'**
  String get startupErrorTitle;

  /// No description provided for @startupErrorRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get startupErrorRetry;

  /// No description provided for @dataLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load data'**
  String get dataLoadError;

  /// No description provided for @routeErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get routeErrorTitle;

  /// No description provided for @routeErrorHome.
  ///
  /// In en, this message translates to:
  /// **'Go to home'**
  String get routeErrorHome;

  /// No description provided for @walletDeleteLastError.
  ///
  /// In en, this message translates to:
  /// **'Cannot delete the last wallet'**
  String get walletDeleteLastError;

  /// No description provided for @driveScopeError.
  ///
  /// In en, this message translates to:
  /// **'Google Drive access was not granted. Sign out and sign in again.'**
  String get driveScopeError;

  /// No description provided for @monthlySummary.
  ///
  /// In en, this message translates to:
  /// **'Monthly summary'**
  String get monthlySummary;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search by description, category, or amount...'**
  String get searchPlaceholder;

  /// No description provided for @emptySearchTitle.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get emptySearchTitle;

  /// No description provided for @emptySearchDesc.
  ///
  /// In en, this message translates to:
  /// **'Try changing your search query or clearing the filter.'**
  String get emptySearchDesc;

  /// No description provided for @emptyTransactionsTitle.
  ///
  /// In en, this message translates to:
  /// **'No transactions'**
  String get emptyTransactionsTitle;

  /// No description provided for @emptyTransactionsDesc.
  ///
  /// In en, this message translates to:
  /// **'No operations found in this category for the selected period.'**
  String get emptyTransactionsDesc;

  /// No description provided for @totalForPeriod.
  ///
  /// In en, this message translates to:
  /// **'Total for period'**
  String get totalForPeriod;

  /// No description provided for @dateToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get dateToday;

  /// No description provided for @dateYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get dateYesterday;

  /// No description provided for @emptyHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'History is empty'**
  String get emptyHistoryTitle;

  /// No description provided for @emptyHistoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Your recent transactions for this wallet will appear here.'**
  String get emptyHistoryDesc;

  /// No description provided for @profileDonate.
  ///
  /// In en, this message translates to:
  /// **'support project'**
  String get profileDonate;

  /// No description provided for @donateTitle.
  ///
  /// In en, this message translates to:
  /// **'Support Project'**
  String get donateTitle;

  /// No description provided for @donateThanks.
  ///
  /// In en, this message translates to:
  /// **'Thanks for using Pecunia!'**
  String get donateThanks;

  /// No description provided for @donateDescription.
  ///
  /// In en, this message translates to:
  /// **'If you like the app, you can support the author with a donation or write your feedback and suggestions to the email.'**
  String get donateDescription;

  /// No description provided for @donateContactAuthor.
  ///
  /// In en, this message translates to:
  /// **'Contact the author'**
  String get donateContactAuthor;

  /// No description provided for @donateCrypto.
  ///
  /// In en, this message translates to:
  /// **'Donate crypto'**
  String get donateCrypto;

  /// No description provided for @donateCoinNetwork.
  ///
  /// In en, this message translates to:
  /// **'Coin / Network'**
  String get donateCoinNetwork;

  /// No description provided for @donateWalletAddress.
  ///
  /// In en, this message translates to:
  /// **'Wallet address'**
  String get donateWalletAddress;

  /// No description provided for @donateCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get donateCopy;

  /// No description provided for @donateCopied.
  ///
  /// In en, this message translates to:
  /// **'Address copied to clipboard'**
  String get donateCopied;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'en',
    'es',
    'fr',
    'pl',
    'ru',
    'uk',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'pl':
      return AppLocalizationsPl();
    case 'ru':
      return AppLocalizationsRu();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
