import 'dart:ui';
import 'package:countries_flag/countries_flag.dart';
import 'package:pecunia/translations/app_translation.dart';

class EsTranslation extends AppTranslation {
  @override
  String get name => "Español";

  @override
  String get flag => Flags.spain;

  @override
  Locale get locale => const Locale('es', 'ES');

  @override
  Map<String, String> get keys => {
        "yes": "sí",
        "no": "no",
        "light": "claro",
        "dark": "oscuro",
        "home_button_amount": "cantidad",
        "home_button_category": "categoría",
        "home_button_income": "ingreso",
        "home_button_expense": "gasto",
        "profile_title": "Configuración de perfil",
        "profile_my_wallets": "mis billeteras",
        "profile_theme": "tema",
        "profile_main_currency": "moneda principal",
        "profile_support": "soporte",
        "profile_edit": "editar",
        "setting_wallet_title_add": "Crear billetera",
        "setting_wallet_title_update": "Configuración de la billetera actual",
        "setting_wallet_name": "nombre*",
        "setting_wallet_description": "nota",
        "setting_wallet_currency": "moneda*",
        "setting_wallet_show_balance": "mostrar saldo en la página principal",
        "setting_wallet_is_round_up": "redondear cantidades a enteros",
        "setting_wallet_button_add": "añadir billetera",
        "setting_wallet_button_save": "Guardar",
        "setting_wallet_error_name": "Introduce el nombre",
        "setting_wallet_error_currency": "Introduce una nota",
        "wallet_item_name": "nombre",
        "wallet_item_description": "nota",
        "current_wallet_title": "billetera actual",
        "current_wallet_bottom_title": "tus billeteras",
        "tran_item_today": "hoy",
        "tran_item_yesterday": "ayer",
        "tran_item_income": "ingresos de",
        "tran_item_expense": "gastos en",
        "tran_item_error_amount": "Introduce la cantidad",
        "tran_item_error_category": "Introduce la categoría",
        "tran_dialog_delete_title": "Confirmar",
        "tran_dialog_delete_content": "¿Estás seguro de que deseas eliminar este elemento?",
        "tran_dialog_delete_delete": "Eliminar",
        "tran_dialog_delete_cancel": "Cancelar",
        "analytics_title": "Análisis",
        "analytics_category_item_count": "transacciones",
        "analytics_category_period": "por el período del año %1\$",
        "analytics_category_empty": "no hay análisis para el período del año %1\$",
        "analytics_income": "ingresos",
        "analytics_expenses": "gastos",
        "analytics_total": "total",
        "analytics_total_period": "total acumulado",
        "tran_dialog_edit_title": "Edición",
        "tran_dialog_edit_save": "Guardar",
        "tran_dialog_edit_cancel": "Cancelar",
        "tran_dialog_edit_income": "ingreso",
        "tran_dialog_edit_expenses": "gasto",
        "tran_dialog_edit_amount": "cantidad",
        "tran_dialog_edit_category": "categoría",
        "tran_dialog_edit_description": "nota"
      };
}
