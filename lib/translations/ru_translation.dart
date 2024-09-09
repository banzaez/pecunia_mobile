import 'dart:ui';
import 'package:countries_flag/countries_flag.dart';
import 'package:pecunia/translations/app_translation.dart';

class RuTranslation extends AppTranslation {
  @override
  String get name => "Русский";

  @override
  String get flag => Flags.russia;

  @override
  Locale get locale => const Locale('ru', 'RU');

  @override
  Map<String, String> get keys => {
        "yes": "да",
        "no": "нет",
        "light": "светлая",
        "dark": "темная",
        "home_button_amount": "сумма",
        "home_button_category": "категория",
        "home_button_income": "доход",
        "home_button_expense": "расход",
        "profile_title": "Настройки профиля",
        "profile_my_wallets": "мои кошельки",
        "profile_theme": "тема",
        "profile_main_currency": "основная валюта",
        "profile_support": "поддержка",
        "profile_edit": "редактировать",
        "setting_wallet_title_add": "Создать кошелек",
        "setting_wallet_title_update": "Настройки текущего кошелька",
        "setting_wallet_name": "название*",
        "setting_wallet_description": "примечание",
        "setting_wallet_currency": "валюта*",
        "setting_wallet_show_balance": "показывать баланс на главной",
        "setting_wallet_is_round_up": "округлять суммы до целых",
        "setting_wallet_button_add": "добавить кошелек",
        "setting_wallet_button_save": "Cохранить",
        "setting_wallet_error_name": "Введите название",
        "setting_wallet_error_currency": "Введите примечание",
        "wallet_item_name": "название",
        "wallet_item_description": "примечание",
        "current_wallet_title": "текущий кошелек",
        "current_wallet_bottom_title": "ваши кошельки",
        "tran_item_today": "сегодня",
        "tran_item_yesterday": "вчера",
        "tran_item_income": "доходы от",
        "tran_item_expense": "расходы на",
        "tran_item_error_amount": "Введите сумму",
        "tran_item_error_category": "Введите категорию",
        "tran_dialog_delete_title": "Подтвердите",
        "tran_dialog_delete_content": "Вы уверены, что хотите удалить этот элемент?",
        "tran_dialog_delete_delete": "Удалить",
        "tran_dialog_delete_cancel": "Отменить",
        "analytics_title": "Аналитика",
        "analytics_category_item_count": "транзакций",
        "analytics_category_period": "за период %1\$ года",
        "analytics_category_empty": "аналитики за период %1\$ года нет",
        "analytics_income": "доходы",
        "analytics_expenses": "расходы",
        "analytics_total": "суммарно",
        "analytics_total_period": "итого",
        "tran_dialog_edit_title": "Редактирование",
        "tran_dialog_edit_save": "Сохранить",
        "tran_dialog_edit_cancel": "Отменить",
        "tran_dialog_edit_income": "доход",
        "tran_dialog_edit_expenses": "расход",
        "tran_dialog_edit_amount": "сумма",
        "tran_dialog_edit_category": "категория",
        "tran_dialog_edit_description": "примечание",
        "wallet_field_empty": "выберите кошелек",
        "transfer_title": "перевод между кошельками",
        "transfer_amount": "сумма",
        "transfer_exchange_rate": "обменный курс",
        "transfer_total": "итого",
        "transfer_done": "готово",
        "transfer_error_wallet": "Выберите разные кошельки",
        "transfer_description": "перевод с %1\$ на %2\$, обменный курс %3\$",
        "from": "с",
        "to": "на"
      };
}
