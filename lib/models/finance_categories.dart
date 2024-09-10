import 'package:get/get.dart';
import 'package:pecunia/models/finance_category.dart';

class FinanceCategories extends GetxController {
  // Статические категории доходов
  static const FinanceCategory salary = FinanceCategory(
    id: 1,
    name: "finance_category_salary",
    subcategories: [],
  );

  static const FinanceCategory bonuses = FinanceCategory(
    id: 2,
    name: "finance_category_bonuses",
    subcategories: [],
  );

  static const FinanceCategory gifts = FinanceCategory(
    id: 3,
    name: "finance_category_gifts",
    subcategories: [],
  );

  static const FinanceCategory sales = FinanceCategory(
    id: 4,
    name: "finance_category_sales",
    subcategories: [],
  );

  static const FinanceCategory investments = FinanceCategory(
    id: 5,
    name: "finance_category_investments",
    subcategories: [],
  );

  static const FinanceCategory rent = FinanceCategory(
    id: 6,
    name: "finance_category_rent",
    subcategories: [],
  );

  static const FinanceCategory freelance = FinanceCategory(
    id: 7,
    name: "finance_category_freelance",
    subcategories: [],
  );

  static const FinanceCategory dividends = FinanceCategory(
    id: 8,
    name: "finance_category_dividends",
    subcategories: [],
  );

  static const FinanceCategory taxRefunds = FinanceCategory(
    id: 9,
    name: "finance_category_tax_refunds",
    subcategories: [],
  );

  static const FinanceCategory cashback = FinanceCategory(
    id: 10,
    name: "finance_category_cashback",
    subcategories: [],
  );

  static const FinanceCategory otherIncome = FinanceCategory(
    id: 11,
    name: "finance_category_other_income",
    subcategories: [],
  );

  // Статические категории расходов
  static const FinanceCategory foodAndDrinks = FinanceCategory(
    id: 12,
    name: "finance_category_food_and_drinks",
    subcategories: [
      FinanceCategory(id: 121, name: "finance_category_groceries", subcategories: []),
      FinanceCategory(id: 122, name: "finance_category_restaurants_and_cafes", subcategories: []),
    ],
  );

  static const FinanceCategory transport = FinanceCategory(
    id: 13,
    name: "finance_category_transport",
    subcategories: [
      FinanceCategory(id: 131, name: "finance_category_public_transport", subcategories: []),
      FinanceCategory(id: 132, name: "finance_category_private_transport", subcategories: []),
      FinanceCategory(id: 133, name: "finance_category_fuel", subcategories: []),
      FinanceCategory(id: 134, name: "finance_category_parking", subcategories: []),
    ],
  );

  static const FinanceCategory housing = FinanceCategory(
    id: 14,
    name: "finance_category_housing",
    subcategories: [
      FinanceCategory(id: 141, name: "finance_category_rent_expenses", subcategories: []),
      FinanceCategory(id: 142, name: "finance_category_mortgage", subcategories: []),
      FinanceCategory(id: 143, name: "finance_category_utilities", subcategories: []),
      FinanceCategory(id: 144, name: "finance_category_repairs_and_maintenance", subcategories: []),
    ],
  );

  static const FinanceCategory clothingAndFootwear = FinanceCategory(
    id: 15,
    name: "finance_category_clothing_and_footwear",
    subcategories: [],
  );

  static const FinanceCategory health = FinanceCategory(
    id: 16,
    name: "finance_category_health",
    subcategories: [
      FinanceCategory(id: 161, name: "finance_category_medicine", subcategories: []),
      FinanceCategory(id: 162, name: "finance_category_insurance", subcategories: []),
      FinanceCategory(id: 163, name: "finance_category_doctor_visits", subcategories: []),
    ],
  );

  static const FinanceCategory entertainment = FinanceCategory(
    id: 17,
    name: "finance_category_entertainment",
    subcategories: [
      FinanceCategory(id: 171, name: "finance_category_movies_and_theater", subcategories: []),
      FinanceCategory(id: 172, name: "finance_category_travel_and_vacations", subcategories: []),
      FinanceCategory(id: 173, name: "finance_category_hobbies", subcategories: []),
    ],
  );

  static const FinanceCategory sportsAndFitness = FinanceCategory(
    id: 18,
    name: "finance_category_sports_and_fitness",
    subcategories: [
      FinanceCategory(id: 181, name: "finance_category_gym_memberships", subcategories: []),
      FinanceCategory(id: 182, name: "finance_category_sports_events", subcategories: []),
    ],
  );

  static const FinanceCategory education = FinanceCategory(
    id: 19,
    name: "finance_category_education",
    subcategories: [
      FinanceCategory(id: 191, name: "finance_category_courses_and_training", subcategories: []),
      FinanceCategory(id: 192, name: "finance_category_learning_materials", subcategories: []),
    ],
  );

  static const FinanceCategory loansAndDebts = FinanceCategory(
    id: 20,
    name: "finance_category_loans_and_debts",
    subcategories: [
      FinanceCategory(id: 201, name: "finance_category_loan_payments", subcategories: []),
      FinanceCategory(id: 202, name: "finance_category_loan_interest", subcategories: []),
    ],
  );

  static const FinanceCategory pets = FinanceCategory(
    id: 21,
    name: "finance_category_pets",
    subcategories: [
      FinanceCategory(id: 211, name: "finance_category_food_and_care", subcategories: []),
      FinanceCategory(id: 212, name: "finance_category_veterinary", subcategories: []),
    ],
  );

  static const FinanceCategory giftsAndCharity = FinanceCategory(
    id: 22,
    name: "finance_category_gifts_and_charity",
    subcategories: [],
  );

  static const FinanceCategory internetAndCommunication = FinanceCategory(
    id: 23,
    name: "finance_category_internet_and_communication",
    subcategories: [],
  );

  static const FinanceCategory personalExpenses = FinanceCategory(
    id: 24,
    name: "finance_category_personal_expenses",
    subcategories: [],
  );

  static const FinanceCategory investmentsExpenses = FinanceCategory(
    id: 25,
    name: "finance_category_investments_expenses",
    subcategories: [],
  );

  static const FinanceCategory otherExpenses = FinanceCategory(
    id: 26,
    name: "finance_category_other_expenses",
    subcategories: [],
  );

  // Получение всех категорий в одном списке
  static const List<FinanceCategory> allCategories = [
    // доходы
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
    otherIncome,
    // расходы
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
    otherExpenses,
  ];

  // категории доходов
  static const List<FinanceCategory> incomeCategories = [
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
    otherIncome,
  ];

  // категории доходов
  static const List<FinanceCategory> expenseCategories = [
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
    otherExpenses,
  ];

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
