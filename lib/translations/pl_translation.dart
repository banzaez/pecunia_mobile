// pl_PL
// Polski
import 'dart:ui';
import 'package:countries_flag/countries_flag.dart';
import 'package:pecunia/translations/app_translation.dart';

class PlTranslation extends AppTranslation {
  @override
  String get name => "Polski";

  @override
  String get flag => Flags.poland;

  @override
  Locale get locale => const Locale('pl', 'PL');

  @override
  Map<String, String> get keys => {
        "yes": "tak",
        "no": "nie",
        "light": "jasny",
        "dark": "ciemny",
        "home_button_amount": "kwota",
        "home_button_category": "kategoria",
        "home_button_income": "dochód",
        "home_button_expense": "wydatek",
        "profile_title": "Ustawienia profilu",
        "profile_my_wallets": "moje portfele",
        "profile_theme": "motyw",
        "profile_main_currency": "główna waluta",
        "profile_support": "wsparcie",
        "profile_edit": "edytuj",
        "setting_wallet_title_add": "Utwórz portfel",
        "setting_wallet_title_update": "Ustawienia bieżącego portfela",
        "setting_wallet_name": "nazwa*",
        "setting_wallet_description": "uwaga",
        "setting_wallet_currency": "waluta*",
        "setting_wallet_show_balance": "pokazuj saldo na stronie głównej",
        "setting_wallet_is_round_up": "zaokrąglaj kwoty do całych",
        "setting_wallet_button_add": "dodaj portfel",
        "setting_wallet_button_save": "Zapisz",
        "setting_wallet_error_name": "Wprowadź nazwę",
        "setting_wallet_error_currency": "Wprowadź uwagę",
        "wallet_item_name": "nazwa",
        "wallet_item_description": "uwaga",
        "current_wallet_title": "bieżący portfel",
        "current_wallet_bottom_title": "twoje portfele",
        "tran_item_today": "dzisiaj",
        "tran_item_yesterday": "wczoraj",
        "tran_item_income": "dochody z",
        "tran_item_expense": "wydatki na",
        "tran_item_error_amount": "Wprowadź kwotę",
        "tran_item_error_category": "Wprowadź kategorię",
        "tran_dialog_delete_title": "Potwierdź",
        "tran_dialog_delete_content": "Czy na pewno chcesz usunąć ten element?",
        "tran_dialog_delete_delete": "Usuń",
        "tran_dialog_delete_cancel": "Anuluj",
        "analytics_title": "Analityka",
        "analytics_category_item_count": "transakcji",
        "analytics_category_period": "za okres %1\$ roku",
        "analytics_category_empty": "brak analizy za okres %1\$ roku",
        "analytics_income": "dochody",
        "analytics_expenses": "wydatki",
        "analytics_total": "razem",
        "analytics_total_period": "łącznie",
        "tran_dialog_edit_title": "Edycja",
        "tran_dialog_edit_save": "Zapisz",
        "tran_dialog_edit_cancel": "Anuluj",
        "tran_dialog_edit_income": "dochód",
        "tran_dialog_edit_expenses": "wydatek",
        "tran_dialog_edit_amount": "kwota",
        "tran_dialog_edit_category": "kategoria",
        "tran_dialog_edit_description": "uwaga"
      };
}
