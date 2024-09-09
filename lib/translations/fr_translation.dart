import 'dart:ui';
import 'package:countries_flag/countries_flag.dart';
import 'package:pecunia/translations/app_translation.dart';

class FrTranslation extends AppTranslation {
  @override
  String get name => "Français";

  @override
  String get flag => Flags.france;

  @override
  Locale get locale => const Locale('fr', 'FR');

  @override
  Map<String, String> get keys => {
        "yes": "oui",
        "no": "non",
        "light": "clair",
        "dark": "sombre",
        "home_button_amount": "montant",
        "home_button_category": "catégorie",
        "home_button_income": "revenu",
        "home_button_expense": "dépense",
        "profile_title": "Paramètres du profil",
        "profile_my_wallets": "mes portefeuilles",
        "profile_theme": "thème",
        "profile_main_currency": "devise principale",
        "profile_support": "support",
        "profile_edit": "modifier",
        "setting_wallet_title_add": "Créer un portefeuille",
        "setting_wallet_title_update": "Paramètres du portefeuille actuel",
        "setting_wallet_name": "nom*",
        "setting_wallet_description": "note",
        "setting_wallet_currency": "devise*",
        "setting_wallet_show_balance": "afficher le solde sur l'écran principal",
        "setting_wallet_is_round_up": "arrondir les montants",
        "setting_wallet_button_add": "ajouter un portefeuille",
        "setting_wallet_button_save": "Enregistrer",
        "setting_wallet_error_name": "Entrez un nom",
        "setting_wallet_error_currency": "Entrez une note",
        "wallet_item_name": "nom",
        "wallet_item_description": "note",
        "current_wallet_title": "portefeuille actuel",
        "current_wallet_bottom_title": "vos portefeuilles",
        "tran_item_today": "aujourd'hui",
        "tran_item_yesterday": "hier",
        "tran_item_income": "revenus de",
        "tran_item_expense": "dépenses pour",
        "tran_item_error_amount": "Entrez le montant",
        "tran_item_error_category": "Entrez la catégorie",
        "tran_dialog_delete_title": "Confirmer",
        "tran_dialog_delete_content": "Êtes-vous sûr de vouloir supprimer cet élément ?",
        "tran_dialog_delete_delete": "Supprimer",
        "tran_dialog_delete_cancel": "Annuler",
        "analytics_title": "Analyse",
        "analytics_category_item_count": "transactions",
        "analytics_category_period": "pour la période de l'année %1\$",
        "analytics_category_empty": "aucune analyse pour la période de l'année %1\$",
        "analytics_income": "revenus",
        "analytics_expenses": "dépenses",
        "analytics_total": "total",
        "analytics_total_period": "total cumulé",
        "tran_dialog_edit_title": "Édition",
        "tran_dialog_edit_save": "Enregistrer",
        "tran_dialog_edit_cancel": "Annuler",
        "tran_dialog_edit_income": "revenu",
        "tran_dialog_edit_expenses": "dépense",
        "tran_dialog_edit_amount": "montant",
        "tran_dialog_edit_category": "catégorie",
        "tran_dialog_edit_description": "note",
        "wallet_field_empty": "choisissez un portefeuille",
        "transfer_title": "transfert entre portefeuilles",
        "transfer_amount": "montant",
        "transfer_exchange_rate": "taux de change",
        "transfer_total": "total",
        "transfer_done": "terminé",
        "transfer_error_wallet": "Sélectionnez des portefeuilles différents",
        "transfer_description": "transfert de %1\$ à %2\$, taux de change %3\$",
        "from": "de",
        "to": "à"
      };
}
