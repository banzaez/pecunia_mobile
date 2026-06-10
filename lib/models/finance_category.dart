import 'package:json_annotation/json_annotation.dart';
import 'package:pecunia/l10n/app_localizations.dart';

class FinanceCategory {
  const FinanceCategory(this.id, this._name, this.subcategories);

  final int id;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String _name;
  final List<FinanceCategory> subcategories;

  String localizedName(AppLocalizations l10n) {
    // В базе данных и в статических полях используются snake_case имена (например, 'rfc_salary', 'rfc_food_and_drinks').
    // Нам нужно преобразовать их в camelCase (например, 'rfcSalary', 'rfcFoodAndDrinks') для сопоставления с геттерами AppLocalizations.
    final cleanName = _name.split('_').map((part) {
      if (part.isEmpty) return '';
      // Если это первая часть (например, 'rfc'), оставляем в нижнем регистре
      if (_name.startsWith(part)) return part;
      return part[0].toUpperCase() + part.substring(1);
    }).join();

    return switch (cleanName) {
      'rfcSalary' => l10n.rfcSalary,
      'rfcBonuses' => l10n.rfcBonuses,
      'rfcGifts' => l10n.rfcGifts,
      'rfcSales' => l10n.rfcSales,
      'rfcInvestments' => l10n.rfcInvestments,
      'rfcRent' => l10n.rfcRent,
      'rfcFreelance' => l10n.rfcFreelance,
      'rfcDividends' => l10n.rfcDividends,
      'rfcTaxRefunds' => l10n.rfcTaxRefunds,
      'rfcCashback' => l10n.rfcCashback,
      'rfcOtherIncome' => l10n.rfcOtherIncome,
      'rfcFoodAndDrinks' => l10n.rfcFoodAndDrinks,
      'rfcGroceries' => l10n.rfcGroceries,
      'rfcRestaurantsAndCafes' => l10n.rfcRestaurantsAndCafes,
      'rfcTransport' => l10n.rfcTransport,
      'rfcPublicTransport' => l10n.rfcPublicTransport,
      'rfcPrivateTransport' => l10n.rfcPrivateTransport,
      'rfcFuel' => l10n.rfcFuel,
      'rfcParking' => l10n.rfcParking,
      'rfcHousing' => l10n.rfcHousing,
      'rfcRentExpenses' => l10n.rfcRentExpenses,
      'rfcMortgage' => l10n.rfcMortgage,
      'rfcUtilities' => l10n.rfcUtilities,
      'rfcRepairsAndMaintenance' => l10n.rfcRepairsAndMaintenance,
      'rfcClothingAndFootwear' => l10n.rfcClothingAndFootwear,
      'rfcHealth' => l10n.rfcHealth,
      'rfcMedicine' => l10n.rfcMedicine,
      'rfcInsurance' => l10n.rfcInsurance,
      'rfcDoctorVisits' => l10n.rfcDoctorVisits,
      'rfcEntertainment' => l10n.rfcEntertainment,
      'rfcMoviesAndTheater' => l10n.rfcMoviesAndTheater,
      'rfcTravelAndVacations' => l10n.rfcTravelAndVacations,
      'rfcHobbies' => l10n.rfcHobbies,
      'rfcSportsAndFitness' => l10n.rfcSportsAndFitness,
      'rfcGymMemberships' => l10n.rfcGymMemberships,
      'rfcSportsEvents' => l10n.rfcSportsEvents,
      'rfcEducation' => l10n.rfcEducation,
      'rfcCoursesAndTraining' => l10n.rfcCoursesAndTraining,
      'rfcLearningMaterials' => l10n.rfcLearningMaterials,
      'rfcLoansAndDebts' => l10n.rfcLoansAndDebts,
      'rfcLoanPayments' => l10n.rfcLoanPayments,
      'rfcLoanInterest' => l10n.rfcLoanInterest,
      'rfcPets' => l10n.rfcPets,
      'rfcFoodAndCare' => l10n.rfcFoodAndCare,
      'rfcVeterinary' => l10n.rfcVeterinary,
      'rfcGiftsAndCharity' => l10n.rfcGiftsAndCharity,
      'rfcInternetAndCommunication' => l10n.rfcInternetAndCommunication,
      'rfcPersonalExpenses' => l10n.rfcPersonalExpenses,
      'rfcInvestmentsExpenses' => l10n.rfcInvestmentsExpenses,
      'rfcOtherExpenses' => l10n.rfcOtherExpenses,
      'rfcTransfer' => l10n.rfcTransfer,
      'rfcAuto' => l10n.rfcAuto,
      'rfcAutoFuel' => l10n.rfcAutoFuel,
      'rfcAutoMaintenance' => l10n.rfcAutoMaintenance,
      'rfcAutoInsurance' => l10n.rfcAutoInsurance,
      'rfcAutoRepairs' => l10n.rfcAutoRepairs,
      'rfcAutoParking' => l10n.rfcAutoParking,
      'rfcAutoCarTolls' => l10n.rfcAutoCarTolls,
      'rfcAutoCarWash' => l10n.rfcAutoCarWash,
      'rfcAutoTires' => l10n.rfcAutoTires,
      _ => _name,
    };
  }

  String get name => _name;

  @override
  String toString() => _name;
}
