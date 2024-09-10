import 'dart:ui';
import 'package:countries_flag/countries_flag.dart';
import 'package:pecunia/translations/app_translation.dart';

class UaTranslation extends AppTranslation {
  @override
  String get name => "Українська";

  @override
  String get flag => Flags.ukraine;

  @override
  Locale get locale => const Locale('uk', 'UA');

  @override
  Map<String, String> get keys => {
        "yes": "так",
        "no": "ні",
        "light": "світла",
        "dark": "темна",
        "label_category": "категорія",
        "home_button_income": "дохід",
        "home_button_expense": "витрата",
        "profile_title": "Налаштування профілю",
        "profile_my_wallets": "мої гаманці",
        "profile_theme": "тема",
        "profile_main_currency": "основна валюта",
        "profile_support": "підтримка",
        "profile_edit": "редагувати",
        "setting_wallet_title_add": "Створити гаманець",
        "setting_wallet_title_update": "Налаштування поточного гаманця",
        "setting_wallet_name": "назва*",
        "setting_wallet_description": "примітка",
        "setting_wallet_currency": "валюта*",
        "setting_wallet_show_balance": "показувати баланс на головній",
        "setting_wallet_is_round_up": "округляти суми до цілих",
        "setting_wallet_button_add": "додати гаманець",
        "setting_wallet_button_save": "Зберегти",
        "setting_wallet_error_name": "Введіть назву",
        "setting_wallet_error_currency": "Введіть примітку",
        "wallet_item_name": "назва",
        "wallet_item_description": "примітка",
        "current_wallet_title": "поточний гаманець",
        "current_wallet_bottom_title": "ваші гаманці",
        "tran_item_today": "сьогодні",
        "tran_item_yesterday": "вчора",
        "tran_item_income": "доходи від",
        "tran_item_expense": "витрати на",
        "tran_item_error_amount": "Введіть суму",
        "tran_item_error_category": "Введіть категорію",
        "tran_dialog_delete_title": "Підтвердіть",
        "tran_dialog_delete_content": "Ви впевнені, що хочете видалити цей елемент?",
        "tran_dialog_delete_delete": "Видалити",
        "tran_dialog_delete_cancel": "Скасувати",
        "analytics_title": "Аналітика",
        "analytics_category_item_count": "транзакцій",
        "analytics_category_period": "за період %1\$ року",
        "analytics_category_empty": "аналітики за період %1\$ року немає",
        "analytics_income": "доходи",
        "analytics_expenses": "витрати",
        "analytics_total": "загалом",
        "analytics_total_period": "разом",
        "setting_tran_title": "Редагування",
        "setting_tran_save": "Зберегти",
        "setting_tran_income": "дохід",
        "setting_tran_expenses": "витрата",
        "setting_tran_amount": "сума",
        "setting_tran_category": "категорія",
        "setting_tran_description": "примітка",
        "wallet_field_empty": "виберіть гаманець",
        "transfer_title": "переказ між гаманцями",
        "transfer_amount": "сума",
        "transfer_exchange_rate": "обмінний курс",
        "transfer_total": "всього",
        "transfer_done": "готово",
        "transfer_error_wallet": "Виберіть різні гаманці",
        "transfer_description": "переказ з %1\$ до %2\$, обмінний курс %3\$",
        "from": "з",
        "to": "до",
      };
}
