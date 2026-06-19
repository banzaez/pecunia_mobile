// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get yes => 'sí';

  @override
  String get no => 'no';

  @override
  String get light => 'claro';

  @override
  String get dark => 'oscuro';

  @override
  String get labelCategory => 'categoría';

  @override
  String get homeButtonIncome => 'ingreso';

  @override
  String get homeButtonExpense => 'gasto';

  @override
  String get profileTitle => 'Configuración de perfil';

  @override
  String get profileMyWallets => 'mis billeteras';

  @override
  String get profileTheme => 'tema';

  @override
  String get profileMainCurrency => 'moneda principal';

  @override
  String get profileSupport => 'soporte';

  @override
  String get profileEdit => 'editar';

  @override
  String get settingWalletTitleAdd => 'Crear billetera';

  @override
  String get settingWalletTitleUpdate => 'Configuración de la billetera actual';

  @override
  String get settingWalletName => 'nombre*';

  @override
  String get settingWalletDescription => 'nota';

  @override
  String get settingWalletCurrency => 'moneda*';

  @override
  String get settingWalletShowBalance => 'mostrar saldo en la página principal';

  @override
  String get settingWalletIsRoundUp => 'redondear cantidades a enteros';

  @override
  String get settingWalletButtonAdd => 'añadir billetera';

  @override
  String get settingWalletButtonSave => 'Guardar';

  @override
  String get settingWalletErrorName => 'Introduce el nombre';

  @override
  String get settingWalletErrorCurrency => 'Introduce una nota';

  @override
  String get walletItemName => 'nombre';

  @override
  String get walletItemDescription => 'nota';

  @override
  String get currentWalletTitle => 'billetera actual';

  @override
  String get currentWalletBottomTitle => 'tus billeteras';

  @override
  String get tranItemToday => 'hoy';

  @override
  String get tranItemYesterday => 'ayer';

  @override
  String get tranItemIncome => 'ingresos de';

  @override
  String get tranItemExpense => 'gastos en';

  @override
  String get tranItemErrorAmount => 'Introduce la cantidad';

  @override
  String get tranItemErrorCategory => 'Introduce la categoría';

  @override
  String get dialogDeleteTitle => 'Confirmar';

  @override
  String get dialogDeleteContent =>
      '¿Estás seguro de que deseas eliminar este elemento?';

  @override
  String get dialogDeleteDelete => 'Eliminar';

  @override
  String get dialogDeleteCancel => 'Cancelar';

  @override
  String get analyticsTitle => 'Análisis';

  @override
  String get analyticsCategoryItemCount => 'transacciones';

  @override
  String analyticsCategoryPeriod(String period) {
    return 'por el período del año $period';
  }

  @override
  String analyticsCategoryEmpty(String period) {
    return 'no hay análisis para el período del año $period';
  }

  @override
  String get analyticsIncome => 'ingresos';

  @override
  String get analyticsExpenses => 'gastos';

  @override
  String get analyticsTotal => 'total';

  @override
  String get analyticsTotalPeriod => 'total acumulado';

  @override
  String get walletFieldEmpty => 'elige una billetera';

  @override
  String get transferTitle => 'transferencia entre billeteras';

  @override
  String get transferAmount => 'cantidad';

  @override
  String get transferExchangeRate => 'tasa de cambio';

  @override
  String get transferTotal => 'total';

  @override
  String get transferDone => 'listo';

  @override
  String get transferErrorWallet => 'Selecciona billeteras diferentes';

  @override
  String transferDescription(String from, String to, String rate) {
    return 'transferencia de $from a $to, tasa de cambio $rate';
  }

  @override
  String get from => 'de';

  @override
  String get to => 'a';

  @override
  String get rfcSalary => 'Salario';

  @override
  String get rfcBonuses => 'Bonificaciones';

  @override
  String get rfcGifts => 'Regalos';

  @override
  String get rfcSales => 'Ventas';

  @override
  String get rfcInvestments => 'Inversiones';

  @override
  String get rfcRent => 'Renta';

  @override
  String get rfcFreelance => 'Freelance';

  @override
  String get rfcDividends => 'Dividendos';

  @override
  String get rfcTaxRefunds => 'Reembolsos de impuestos';

  @override
  String get rfcCashback => 'Reembolso';

  @override
  String get rfcOtherIncome => 'Otros ingresos';

  @override
  String get rfcFoodAndDrinks => 'Comida y bebidas';

  @override
  String get rfcGroceries => 'Abarrotes';

  @override
  String get rfcRestaurantsAndCafes => 'Restaurantes y cafeterías';

  @override
  String get rfcTransport => 'Transporte';

  @override
  String get rfcPublicTransport => 'Transporte público';

  @override
  String get rfcPrivateTransport => 'Transporte privado';

  @override
  String get rfcFuel => 'Combustible';

  @override
  String get rfcParking => 'Estacionamiento';

  @override
  String get rfcHousing => 'Vivienda';

  @override
  String get rfcRentExpenses => 'Renta';

  @override
  String get rfcMortgage => 'Hipoteca';

  @override
  String get rfcUtilities => 'Servicios';

  @override
  String get rfcRepairsAndMaintenance => 'Reparaciones y mantenimiento';

  @override
  String get rfcClothingAndFootwear => 'Ropa y calzado';

  @override
  String get rfcHealth => 'Salud';

  @override
  String get rfcMedicine => 'Medicamentos';

  @override
  String get rfcInsurance => 'Seguro';

  @override
  String get rfcDoctorVisits => 'Visitas al médico';

  @override
  String get rfcEntertainment => 'Entretenimiento';

  @override
  String get rfcMoviesAndTheater => 'Películas y teatro';

  @override
  String get rfcTravelAndVacations => 'Viajes y vacaciones';

  @override
  String get rfcHobbies => 'Hobbies';

  @override
  String get rfcSportsAndFitness => 'Deportes y fitness';

  @override
  String get rfcGymMemberships => 'Membresías de gimnasio';

  @override
  String get rfcSportsEvents => 'Eventos deportivos';

  @override
  String get rfcEducation => 'Educación';

  @override
  String get rfcCoursesAndTraining => 'Cursos y capacitación';

  @override
  String get rfcLearningMaterials => 'Materiales educativos';

  @override
  String get rfcLoansAndDebts => 'Préstamos y deudas';

  @override
  String get rfcLoanPayments => 'Pagos de préstamos';

  @override
  String get rfcLoanInterest => 'Intereses de préstamos';

  @override
  String get rfcPets => 'Mascotas';

  @override
  String get rfcFoodAndCare => 'Comida y cuidado';

  @override
  String get rfcVeterinary => 'Veterinario';

  @override
  String get rfcGiftsAndCharity => 'Regalos y caridad';

  @override
  String get rfcInternetAndCommunication => 'Internet y comunicación';

  @override
  String get rfcPersonalExpenses => 'Gastos personales';

  @override
  String get rfcInvestmentsExpenses => 'Inversiones';

  @override
  String get rfcOtherExpenses => 'Otros gastos';

  @override
  String get rfcTransfer => 'Transferencia';

  @override
  String get rfcAuto => 'Auto';

  @override
  String get rfcAutoFuel => 'Combustible';

  @override
  String get rfcAutoMaintenance => 'Mantenimiento';

  @override
  String get rfcAutoInsurance => 'Seguro';

  @override
  String get rfcAutoRepairs => 'Reparaciones';

  @override
  String get rfcAutoParking => 'Estacionamiento';

  @override
  String get rfcAutoCarTolls => 'Peajes';

  @override
  String get rfcAutoCarWash => 'Lavado de autos';

  @override
  String get rfcAutoTires => 'Neumáticos';

  @override
  String get rfcAutoRegistration => 'Registro';

  @override
  String get settingTranTitle => 'Edición';

  @override
  String get settingTranSave => 'Guardar';

  @override
  String get settingTranIncome => 'ingreso';

  @override
  String get settingTranExpenses => 'gasto';

  @override
  String get settingTranAmount => 'cantidad';

  @override
  String get settingTranCategory => 'categoría';

  @override
  String get settingTranDescription => 'nota';

  @override
  String get totalSum => 'Saldo';

  @override
  String get incomesSum => 'Ingresos';

  @override
  String get expensesSum => 'Gastos';

  @override
  String totalHint(String period) {
    return 'para $period';
  }

  @override
  String get backupTitle => 'Archivado y Recuperación';

  @override
  String get backupButton => 'archivado y recuperación';

  @override
  String get backupFilename => 'nombre del archivo';

  @override
  String get backupSize => 'tamaño';

  @override
  String get backupArchiving => 'archivado';

  @override
  String get backupRecovery => 'recuperación';

  @override
  String get backupRestarting => 'Reiniciando';

  @override
  String get backupRestartingBody =>
      'Por favor, toca aquí para abrir la aplicación de nuevo.';

  @override
  String get walletsTitle => 'Mis billeteras';

  @override
  String get walletsButton => 'mis billeteras';

  @override
  String get transactionsTitle => 'Transacciones';

  @override
  String get error => 'Error';

  @override
  String get success => 'Éxito';

  @override
  String get backupSavedSuccess => 'Copia de seguridad guardada con éxito';

  @override
  String get backupRestoredSuccess => 'Datos restaurados con éxito';

  @override
  String get backupDeletedSuccess => 'Copia de seguridad eliminada con éxito';

  @override
  String get driveErrorRead => 'Error al leer archivos de Drive';

  @override
  String get driveErrorDelete => 'Error al eliminar archivo de Drive';

  @override
  String get driveErrorDownload => 'Error al descargar de Drive';

  @override
  String get backupErrorMsg =>
      'El archivo seleccionado no está en formato \"db\"';

  @override
  String get labelSubcategory => 'subcategoría';

  @override
  String get signOutWithGoogle => 'Cerrar sesión con Google';

  @override
  String get signInWithGoogle => 'Iniciar sesión con Google';

  @override
  String get backupCloudDialogDelete => 'Confirmar eliminación';

  @override
  String get backupCloudDialogDeleteContent =>
      '¿Estás seguro de que deseas eliminar este archivo?';

  @override
  String get backupCloudDialogRecovery => 'Confirmar recuperación';

  @override
  String get backupCloudDialogRecoveryContent =>
      '¿Estás seguro de que deseas recuperar este archivo?';

  @override
  String get backupCreateCloudRecovery => 'Crear recuperación en la nube';

  @override
  String get backupCloudEmpty => 'La nube está vacía';

  @override
  String get startupErrorTitle => 'No se pudo iniciar la aplicación';

  @override
  String get startupErrorRetry => 'Reintentar';

  @override
  String get dataLoadError => 'No se pudieron cargar los datos';

  @override
  String get routeErrorTitle => 'Página no encontrada';

  @override
  String get routeErrorHome => 'Ir al inicio';

  @override
  String get walletDeleteLastError =>
      'No se puede eliminar la última billetera';

  @override
  String get driveScopeError =>
      'No se concedió acceso a Google Drive. Cierra sesión e inicia sesión de nuevo.';
}
