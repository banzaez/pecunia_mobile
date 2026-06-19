import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/util/ext_double.dart';
import 'package:pecunia/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:pecunia/widgets/setting_transaction/setting_transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
    required this.isRoundUp,
    required this.onDelete,
    this.edgeToEdge = false,
  });

  final Transaction transaction;
  final bool isRoundUp;
  final Future<bool> Function() onDelete;
  final bool edgeToEdge;

  IconData _getCategoryIcon(String? name) {
    if (name == null) return Icons.category_rounded;
    final lower = name.toLowerCase();
    
    if (lower.contains('salary')) return Icons.payments_rounded;
    if (lower.contains('bonus')) return Icons.card_giftcard_rounded;
    if (lower.contains('gift')) return Icons.card_giftcard_rounded;
    if (lower.contains('invest')) return Icons.trending_up_rounded;
    if (lower.contains('rent')) return Icons.home_work_rounded;
    if (lower.contains('freelance')) return Icons.laptop_mac_rounded;
    if (lower.contains('dividend')) return Icons.account_balance_wallet_rounded;
    if (lower.contains('cashback')) return Icons.monetization_on_rounded;
    if (lower.contains('income')) return Icons.arrow_downward_rounded;
    
    if (lower.contains('food') || lower.contains('restaurant') || lower.contains('cafe')) return Icons.restaurant_rounded;
    if (lower.contains('grocer')) return Icons.local_grocery_store_rounded;
    if (lower.contains('publictransport') || lower.contains('bus') || lower.contains('metro')) return Icons.directions_bus_rounded;
    if (lower.contains('fuel')) return Icons.local_gas_station_rounded;
    if (lower.contains('parking')) return Icons.local_parking_rounded;
    if (lower.contains('transport') || lower.contains('auto') || lower.contains('car')) return Icons.directions_car_rounded;
    if (lower.contains('utilities') || lower.contains('utility')) return Icons.water_drop_rounded;
    if (lower.contains('repair') || lower.contains('maintenance')) return Icons.build_rounded;
    if (lower.contains('housing') || lower.contains('mortgage')) return Icons.home_rounded;
    if (lower.contains('clothing') || lower.contains('footwear') || lower.contains('shop')) return Icons.checkroom_rounded;
    if (lower.contains('medicine') || lower.contains('doctor') || lower.contains('health')) return Icons.medical_services_rounded;
    if (lower.contains('insurance')) return Icons.security_rounded;
    if (lower.contains('movie') || lower.contains('theater') || lower.contains('entertainment') || lower.contains('hobby')) return Icons.sports_esports_rounded;
    if (lower.contains('travel') || lower.contains('vacation')) return Icons.flight_takeoff_rounded;
    if (lower.contains('sport') || lower.contains('fitness') || lower.contains('gym')) return Icons.fitness_center_rounded;
    if (lower.contains('education') || lower.contains('course') || lower.contains('learn')) return Icons.school_rounded;
    if (lower.contains('loan') || lower.contains('debt')) return Icons.money_off_rounded;
    if (lower.contains('pet') || lower.contains('vet')) return Icons.pets_rounded;
    if (lower.contains('charity')) return Icons.favorite_rounded;
    if (lower.contains('internet') || lower.contains('communication') || lower.contains('phone')) return Icons.wifi_rounded;
    if (lower.contains('transfer')) return Icons.swap_horiz_rounded;
    
    return Icons.category_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.amount > 0;
    final accentColor = isIncome ? const Color(0xFF2E7D32) : const Color(0xFFC62828); // generic green/red
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardBgColor = isDark 
        ? Colors.white.withValues(alpha: 0.03) 
        : Colors.white;

    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : Colors.black.withValues(alpha: 0.05);

    final cardContent = Container(
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
        boxShadow: isDark ? null : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.015),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => SettingTransaction.setting(context, transaction.type, transaction),
            splashColor: accentColor.withValues(alpha: 0.08),
            highlightColor: accentColor.withValues(alpha: 0.04),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  // Vertical accent direction bar
                  Container(
                    width: 3.5,
                    height: 32,
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(1.75),
                    ),
                  ),
                  AppSpaces.h12,
                  // Double ring category icon style
                  Container(
                    padding: const EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: accentColor.withValues(alpha: 0.25),
                        width: 1,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getCategoryIcon(transaction.category?.name),
                        color: accentColor,
                        size: 16,
                      ),
                    ),
                  ),
                  AppSpaces.h12,
                  // Title, Category & Description
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _label(context),
                        if (transaction.description.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          _description(context),
                        ],
                      ],
                    ),
                  ),
                  AppSpaces.h12,
                  // Price & Date
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        (isIncome ? "+" : "") + transaction.amount.formatSumCustom(roundUp: isRoundUp),
                        style: AppTextStyle.text15w600(
                          color: accentColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      _date(context),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return Dismissible(
      key: Key(transaction.id.toString()),
      confirmDismiss: (_) => _confirmDismiss(context),
      onDismissed: (_) {},
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red.shade800,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: cardContent,
      ),
    );
  }

  Widget _label(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final categoryName = transaction.category?.localizedName(l10n) ?? "";
    final subcategoryName = transaction.subcategory?.localizedName(l10n);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (categoryName.isEmpty) {
      return Text(
        transaction.amount > 0 ? l10n.tranItemIncome : l10n.tranItemExpense,
        style: AppTextStyle.text14w600(
          color: isDark ? Colors.white : Colors.black87,
        ),
      );
    }

    return Text(
      "$categoryName${subcategoryName != null ? " ($subcategoryName)" : ""}",
      style: AppTextStyle.text14w600(
        color: isDark ? Colors.white : Colors.black87,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _description(BuildContext context) {
    if (transaction.description.isEmpty) return const SizedBox.shrink();
    var chars = transaction.description.substring(0, min(transaction.description.length, 25));
    chars = chars + (chars.length < transaction.description.length ? "..." : "");
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      chars,
      style: AppTextStyle.text12w400(
        color: isDark ? Colors.white60 : Colors.black54,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _date(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final style = AppTextStyle.text12w400(
      color: Theme.of(context).brightness == Brightness.dark ? Colors.white60 : Colors.black54,
    );
    if (transaction.createdAt.isToday) {
      return Text("${l10n.tranItemToday} ${transaction.createdAt.formatHourMin}", style: style);
    } else if (transaction.createdAt.isYesterday) {
      return Text("${l10n.tranItemYesterday} ${transaction.createdAt.formatHourMin}", style: style);
    } else {
      return Text(transaction.createdAt.formatDDMMSYYYY, style: style);
    }
  }

  Future<bool> _confirmDismiss(BuildContext context) async {
    final confirmed = await showConfirmDeleteDialog(context);
    if (!confirmed) return false;
    return onDelete();
  }
}
