import 'dart:ui';
import 'package:countries_flag/countries_flag.dart';
import 'package:pecunia/translations/app_translation.dart';

class EnTranslation extends AppTranslation {
  @override
  String get name => "English";

  @override
  String get flag => Flags.unitedKingdom;

  @override
  Locale get locale => const Locale('en', 'US');

  @override
  Map<String, String> get keys => {
        "yes": "yes",
        "no": "no",
        "light": "light",
        "dark": "dark",
        "home_button_amount": "amount",
        "home_button_category": "category",
        "home_button_income": "income",
        "home_button_expense": "expense",
        "profile_title": "Profile settings",
        "profile_my_wallets": "my wallets",
        "profile_theme": "theme",
        "profile_main_currency": "main currency",
        "profile_support": "support",
        "profile_edit": "edit",
        "setting_wallet_title_add": "Create a wallet",
        "setting_wallet_title_update": "Current wallet settings",
        "setting_wallet_name": "name*",
        "setting_wallet_description": "description",
        "setting_wallet_currency": "currency*",
        "setting_wallet_show_balance": "show balance on main",
        "setting_wallet_is_round_up": "round amounts to whole numbers",
        "setting_wallet_button_add": "add wallet",
        "setting_wallet_button_save": "Save",
        "setting_wallet_error_name": "Enter the name",
        "setting_wallet_error_currency": "Enter the description",
        "wallet_item_name": "name",
        "wallet_item_description": "description",
        "current_wallet_title": "current wallet",
        "current_wallet_bottom_title": "your wallets",
        "tran_item_today": "today",
        "tran_item_yesterday": "yesterday",
        "tran_item_income": "income from",
        "tran_item_expense": "expenses on",
        "tran_item_error_amount": "Enter the amount",
        "tran_item_error_category": "Enter the category",
        "tran_dialog_delete_title": "Confirm",
        "tran_dialog_delete_content": "Are you sure you wish to delete this item?",
        "tran_dialog_delete_delete": "Delete",
        "tran_dialog_delete_cancel": "Cancel",
        "analytics_title": "Analytics",
        "analytics_category_item_count": "transactions",
        "analytics_category_period": "for the period %1\$ year",
        "analytics_category_empty": "there are no analytics for the period %1\$ year",
        "analytics_income": "income",
        "analytics_expenses": "expenses",
        "analytics_total": "total",
        "analytics_total_period": "total",
        "tran_dialog_edit_title": "Edit",
        "tran_dialog_edit_save": "Save",
        "tran_dialog_edit_cancel": "Cancel",
        "tran_dialog_edit_income": "income",
        "tran_dialog_edit_expenses": "expenses",
        "tran_dialog_edit_amount": "amount",
        "tran_dialog_edit_category": "category",
        "tran_dialog_edit_description": "description",
      };
}
