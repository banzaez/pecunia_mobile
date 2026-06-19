// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get yes => 'oui';

  @override
  String get no => 'non';

  @override
  String get light => 'clair';

  @override
  String get dark => 'sombre';

  @override
  String get labelCategory => 'catégorie';

  @override
  String get homeButtonIncome => 'revenu';

  @override
  String get homeButtonExpense => 'dépense';

  @override
  String get profileTitle => 'Paramètres du profil';

  @override
  String get profileMyWallets => 'mes portefeuilles';

  @override
  String get profileTheme => 'thème';

  @override
  String get profileMainCurrency => 'devise principale';

  @override
  String get profileSupport => 'support';

  @override
  String get profileEdit => 'modifier';

  @override
  String get settingWalletTitleAdd => 'Créer un portefeuille';

  @override
  String get settingWalletTitleUpdate => 'Paramètres du portefeuille actuel';

  @override
  String get settingWalletName => 'nom*';

  @override
  String get settingWalletDescription => 'note';

  @override
  String get settingWalletCurrency => 'devise*';

  @override
  String get settingWalletShowBalance =>
      'afficher le solde sur l\'écran principal';

  @override
  String get settingWalletIsRoundUp => 'arrondir les montants';

  @override
  String get settingWalletButtonAdd => 'ajouter un portefeuille';

  @override
  String get settingWalletButtonSave => 'Enregistrer';

  @override
  String get settingWalletErrorName => 'Entrez un nom';

  @override
  String get settingWalletErrorCurrency => 'Entrez une note';

  @override
  String get walletItemName => 'nom';

  @override
  String get walletItemDescription => 'note';

  @override
  String get currentWalletTitle => 'portefeuille actuel';

  @override
  String get currentWalletBottomTitle => 'vos portefeuilles';

  @override
  String get tranItemToday => 'aujourd\'hui';

  @override
  String get tranItemYesterday => 'hier';

  @override
  String get tranItemIncome => 'revenus de';

  @override
  String get tranItemExpense => 'dépenses pour';

  @override
  String get tranItemErrorAmount => 'Entrez le montant';

  @override
  String get tranItemErrorCategory => 'Entrez la catégorie';

  @override
  String get dialogDeleteTitle => 'Confirmer';

  @override
  String get dialogDeleteContent =>
      'Êtes-vous sûr de vouloir supprimer cet élément ?';

  @override
  String get dialogDeleteDelete => 'Supprimer';

  @override
  String get dialogDeleteCancel => 'Annuler';

  @override
  String get analyticsTitle => 'Analyse';

  @override
  String get analyticsCategoryItemCount => 'transactions';

  @override
  String analyticsCategoryPeriod(String period) {
    return 'pour la période de l\'année $period';
  }

  @override
  String analyticsCategoryEmpty(String period) {
    return 'aucune analyse pour la période de l\'année $period';
  }

  @override
  String get analyticsIncome => 'revenus';

  @override
  String get analyticsExpenses => 'dépenses';

  @override
  String get analyticsTotal => 'total';

  @override
  String get analyticsTotalPeriod => 'total cumulé';

  @override
  String get walletFieldEmpty => 'choisissez un portefeuille';

  @override
  String get transferTitle => 'transfert entre portefeuilles';

  @override
  String get transferAmount => 'montant';

  @override
  String get transferExchangeRate => 'taux de change';

  @override
  String get transferTotal => 'total';

  @override
  String get transferDone => 'terminé';

  @override
  String get transferErrorWallet => 'Sélectionnez des portefeuilles différents';

  @override
  String transferDescription(String from, String to, String rate) {
    return 'transfert de $from à $to, taux de change $rate';
  }

  @override
  String get from => 'de';

  @override
  String get to => 'à';

  @override
  String get rfcSalary => 'Salaire';

  @override
  String get rfcBonuses => 'Primes';

  @override
  String get rfcGifts => 'Cadeaux';

  @override
  String get rfcSales => 'Ventes';

  @override
  String get rfcInvestments => 'Investissements';

  @override
  String get rfcRent => 'Loyer';

  @override
  String get rfcFreelance => 'Freelance';

  @override
  String get rfcDividends => 'Dividendes';

  @override
  String get rfcTaxRefunds => 'Remboursements d\'impôts';

  @override
  String get rfcCashback => 'Cashback';

  @override
  String get rfcOtherIncome => 'Autres revenus';

  @override
  String get rfcFoodAndDrinks => 'Nourriture et boissons';

  @override
  String get rfcGroceries => 'Épicerie';

  @override
  String get rfcRestaurantsAndCafes => 'Restaurants et cafés';

  @override
  String get rfcTransport => 'Transport';

  @override
  String get rfcPublicTransport => 'Transport public';

  @override
  String get rfcPrivateTransport => 'Transport privé';

  @override
  String get rfcFuel => 'Carburant';

  @override
  String get rfcParking => 'Stationnement';

  @override
  String get rfcHousing => 'Logement';

  @override
  String get rfcRentExpenses => 'Loyer';

  @override
  String get rfcMortgage => 'Hypothèque';

  @override
  String get rfcUtilities => 'Services publics';

  @override
  String get rfcRepairsAndMaintenance => 'Réparations et entretien';

  @override
  String get rfcClothingAndFootwear => 'Vêtements et chaussures';

  @override
  String get rfcHealth => 'Santé';

  @override
  String get rfcMedicine => 'Médicaments';

  @override
  String get rfcInsurance => 'Assurance';

  @override
  String get rfcDoctorVisits => 'Visites chez le médecin';

  @override
  String get rfcEntertainment => 'Divertissement';

  @override
  String get rfcMoviesAndTheater => 'Films et théâtre';

  @override
  String get rfcTravelAndVacations => 'Voyages et vacances';

  @override
  String get rfcHobbies => 'Loisirs';

  @override
  String get rfcSportsAndFitness => 'Sport et fitness';

  @override
  String get rfcGymMemberships => 'Abonnements au gymnase';

  @override
  String get rfcSportsEvents => 'Événements sportifs';

  @override
  String get rfcEducation => 'Éducation';

  @override
  String get rfcCoursesAndTraining => 'Cours et formations';

  @override
  String get rfcLearningMaterials => 'Matériaux d\'apprentissage';

  @override
  String get rfcLoansAndDebts => 'Prêts et dettes';

  @override
  String get rfcLoanPayments => 'Remboursements de prêts';

  @override
  String get rfcLoanInterest => 'Intérêts sur les prêts';

  @override
  String get rfcPets => 'Animaux de compagnie';

  @override
  String get rfcFoodAndCare => 'Nourriture et soins';

  @override
  String get rfcVeterinary => 'Vétérinaire';

  @override
  String get rfcGiftsAndCharity => 'Cadeaux et charité';

  @override
  String get rfcInternetAndCommunication => 'Internet et communication';

  @override
  String get rfcPersonalExpenses => 'Dépenses personnelles';

  @override
  String get rfcInvestmentsExpenses => 'Investissements';

  @override
  String get rfcOtherExpenses => 'Autres dépenses';

  @override
  String get rfcTransfer => 'Transfert';

  @override
  String get rfcAuto => 'Auto';

  @override
  String get rfcAutoFuel => 'Carburant';

  @override
  String get rfcAutoMaintenance => 'Entretien';

  @override
  String get rfcAutoInsurance => 'Assurance';

  @override
  String get rfcAutoRepairs => 'Réparations';

  @override
  String get rfcAutoParking => 'Stationnement';

  @override
  String get rfcAutoCarTolls => 'Péages';

  @override
  String get rfcAutoCarWash => 'Lavage auto';

  @override
  String get rfcAutoTires => 'Pneus';

  @override
  String get rfcAutoRegistration => 'Enregistrement';

  @override
  String get settingTranTitle => 'Édition';

  @override
  String get settingTranSave => 'Enregistrer';

  @override
  String get settingTranIncome => 'revenu';

  @override
  String get settingTranExpenses => 'dépense';

  @override
  String get settingTranAmount => 'montant';

  @override
  String get settingTranCategory => 'catégorie';

  @override
  String get settingTranDescription => 'note';

  @override
  String get totalSum => 'Solde';

  @override
  String get incomesSum => 'Revenus';

  @override
  String get expensesSum => 'Dépenses';

  @override
  String totalHint(String period) {
    return 'pour $period';
  }

  @override
  String get backupTitle => 'Archivage et Récupération';

  @override
  String get backupButton => 'archivage et récupération';

  @override
  String get backupFilename => 'nom du fichier';

  @override
  String get backupSize => 'taille';

  @override
  String get backupArchiving => 'archivage';

  @override
  String get backupRecovery => 'récupération';

  @override
  String get backupRestarting => 'Redémarrage';

  @override
  String get backupRestartingBody =>
      'Veuillez cliquer ici pour rouvrir l\'application.';

  @override
  String get walletsTitle => 'Mes portefeuilles';

  @override
  String get walletsButton => 'mes portefeuilles';

  @override
  String get transactionsTitle => 'Transactions';

  @override
  String get error => 'Erreur';

  @override
  String get success => 'Succès';

  @override
  String get backupSavedSuccess => 'Sauvegarde réussie';

  @override
  String get backupRestoredSuccess => 'Données restaurées avec succès';

  @override
  String get backupDeletedSuccess => 'Sauvegarde supprimée avec succès';

  @override
  String get driveErrorRead => 'Erreur de lecture des fichiers Drive';

  @override
  String get driveErrorDelete => 'Erreur de suppression du fichier Drive';

  @override
  String get driveErrorDownload => 'Erreur de téléchargement depuis Drive';

  @override
  String get backupErrorMsg =>
      'Le fichier sélectionné n\'est pas au format \"db\"';

  @override
  String get labelSubcategory => 'sous-catégorie';

  @override
  String get signOutWithGoogle => 'Se déconnecter de Google';

  @override
  String get signInWithGoogle => 'Se connecter avec Google';

  @override
  String get backupCloudDialogDelete => 'Confirmer la suppression';

  @override
  String get backupCloudDialogDeleteContent =>
      'Êtes-vous sûr de vouloir supprimer ce fichier ?';

  @override
  String get backupCloudDialogRecovery => 'Confirmer la récupération';

  @override
  String get backupCloudDialogRecoveryContent =>
      'Êtes-vous sûr de vouloir récupérer ce fichier ?';

  @override
  String get backupCreateCloudRecovery =>
      'Créer une récupération dans le cloud';

  @override
  String get backupCloudEmpty => 'Le cloud est vide';

  @override
  String get startupErrorTitle => 'Échec du démarrage de l\'application';

  @override
  String get startupErrorRetry => 'Réessayer';

  @override
  String get dataLoadError => 'Échec du chargement des données';

  @override
  String get routeErrorTitle => 'Page introuvable';

  @override
  String get routeErrorHome => 'Accueil';
}
