import 'package:get/get.dart';
import 'package:pecunia/models/finance_category.dart';

class FinanceCategories extends GetxController {
  // Статические категории доходов
  // --------------------------------------------------------------------------------------------
  static const FinanceCategory salary = FinanceCategory(1, "rfc_salary", []);

  static const FinanceCategory bonuses = FinanceCategory(2, "rfc_bonuses", []);

  static const FinanceCategory gifts = FinanceCategory(3, "rfc_gifts", []);

  static const FinanceCategory sales = FinanceCategory(4, "rfc_sales", []);

  static const FinanceCategory investments = FinanceCategory(5, "rfc_investments", []);

  static const FinanceCategory rent = FinanceCategory(6, "rfc_rent", []);

  static const FinanceCategory freelance = FinanceCategory(7, "rfc_freelance", []);

  static const FinanceCategory dividends = FinanceCategory(8, "rfc_dividends", []);

  static const FinanceCategory taxRefunds = FinanceCategory(9, "rfc_tax_refunds", []);

  static const FinanceCategory cashback = FinanceCategory(10, "rfc_cashback", []);

  static const FinanceCategory otherIncome = FinanceCategory(11, "rfc_other_income", []);

  // Статические категории расходов
  static const FinanceCategory foodAndDrinks = FinanceCategory(
    12,
    "rfc_food_and_drinks",
    [
      FinanceCategory(121, "rfc_groceries", []),
      FinanceCategory(122, "rfc_restaurants_and_cafes", []),
    ],
  );

  static const FinanceCategory transport = FinanceCategory(
    13,
    "rfc_transport",
    [
      FinanceCategory(131, "rfc_public_transport", []),
      FinanceCategory(132, "rfc_private_transport", []),
      FinanceCategory(133, "rfc_fuel", []),
      FinanceCategory(134, "rfc_parking", []),
    ],
  );

  static const FinanceCategory housing = FinanceCategory(
    14,
    "rfc_housing",
    [
      FinanceCategory(141, "rfc_rent_expenses", []),
      FinanceCategory(142, "rfc_mortgage", []),
      FinanceCategory(143, "rfc_utilities", []),
      FinanceCategory(144, "rfc_repairs_and_maintenance", []),
    ],
  );

  static const FinanceCategory clothingAndFootwear =
      FinanceCategory(15, "rfc_clothing_and_footwear", []);

  static const FinanceCategory health = FinanceCategory(
    16,
    "rfc_health",
    [
      FinanceCategory(161, "rfc_medicine", []),
      FinanceCategory(162, "rfc_insurance", []),
      FinanceCategory(163, "rfc_doctor_visits", []),
    ],
  );

  static const FinanceCategory entertainment = FinanceCategory(
    17,
    "rfc_entertainment",
    [
      FinanceCategory(171, "rfc_movies_and_theater", []),
      FinanceCategory(172, "rfc_travel_and_vacations", []),
      FinanceCategory(173, "rfc_hobbies", []),
    ],
  );

  static const FinanceCategory sportsAndFitness = FinanceCategory(
    18,
    "rfc_sports_and_fitness",
    [
      FinanceCategory(181, "rfc_gym_memberships", []),
      FinanceCategory(182, "rfc_sports_events", []),
    ],
  );

  static const FinanceCategory education = FinanceCategory(
    19,
    "rfc_education",
    [
      FinanceCategory(191, "rfc_courses_and_training", []),
      FinanceCategory(192, "rfc_learning_materials", []),
    ],
  );

  static const FinanceCategory loansAndDebts = FinanceCategory(
    20,
    "rfc_loans_and_debts",
    [
      FinanceCategory(201, "rfc_loan_payments", []),
      FinanceCategory(202, "rfc_loan_interest", []),
    ],
  );

  static const FinanceCategory pets = FinanceCategory(
    21,
    "rfc_pets",
    [
      FinanceCategory(211, "rfc_food_and_care", []),
      FinanceCategory(212, "rfc_veterinary", []),
    ],
  );

  static const FinanceCategory giftsAndCharity = FinanceCategory(22, "rfc_gifts_and_charity", []);

  static const FinanceCategory internetAndCommunication =
      FinanceCategory(23, "rfc_internet_and_communication", []);

  static const FinanceCategory personalExpenses = FinanceCategory(24, "rfc_personal_expenses", []);

  static const FinanceCategory investmentsExpenses =
      FinanceCategory(25, "rfc_investments_expenses", []);

  static const FinanceCategory otherExpenses = FinanceCategory(26, "rfc_other_expenses", []);

  // Основная категория "Авто" с id 28
  static const FinanceCategory auto = FinanceCategory(28, 'rfc_auto', [
    FinanceCategory(281, 'rfc_auto_fuel', []), // Топливо
    FinanceCategory(282, 'rfc_auto_maintenance', []), // Техобслуживание
    FinanceCategory(283, 'rfc_auto_insurance', []), // Страхование
    FinanceCategory(284, 'rfc_auto_repairs', []), // Ремонт
    FinanceCategory(285, 'rfc_auto_parking', []), // Парковка
    FinanceCategory(286, 'rfc_auto_car_tolls', []), // Платные дороги
    FinanceCategory(287, 'rfc_auto_car_wash', []), // Мойка машины
    FinanceCategory(288, 'rfc_auto_tires', []), // Шины
    FinanceCategory(289, 'rfc_auto_registration', []), // Регистрация
  ]);

  // Статические категория остальные
  // --------------------------------------------------------------------------------------------
  static const FinanceCategory transfer = FinanceCategory(27, "rfc_transfer", []);

  // Получение всех категорий в одном списке
  // --------------------------------------------------------------------------------------------
  static List<FinanceCategory> allCategories = [
    ...incomeCategories,
    ...expenseCategories,
  ];

  // категории доходов
  // --------------------------------------------------------------------------------------------
  static List<FinanceCategory> get incomeCategories {
    final list = [
      salary,
      bonuses,
      gifts,
      sales,
      investments,
      rent,
      freelance,
      dividends,
      taxRefunds,
      cashback,
      transfer,
    ];

    //list.sort((a, b) => a.name[0].compareTo(b.name));
    list.add(otherIncome);

    return list;
  }

  // категории доходов
  // --------------------------------------------------------------------------------------------
  static List<FinanceCategory> get expenseCategories {
    final list = [
      auto,
      foodAndDrinks,
      transport,
      housing,
      clothingAndFootwear,
      health,
      entertainment,
      sportsAndFitness,
      education,
      loansAndDebts,
      pets,
      giftsAndCharity,
      internetAndCommunication,
      personalExpenses,
      investmentsExpenses,
      transfer,
    ];

    //list.sort((a, b) => a.name.compareTo(b.name));
    list.add(otherExpenses);

    return list;
  }

  // Функция для поиска категории по id
  static FinanceCategory? getCategoryById(int id) {
    // Рекурсивная функция для поиска по подкатегориям
    FinanceCategory? searchCategory(FinanceCategory category) {
      if (category.id == id) return category;

      for (var subcategory in category.subcategories) {
        var result = searchCategory(subcategory);
        if (result != null) return result;
      }
      return null;
    }

    // Перебор всех категорий
    for (var category in allCategories) {
      var result = searchCategory(category);
      if (result != null) return result;
    }
    // Если категория не найдена
    return null;
  }
}
