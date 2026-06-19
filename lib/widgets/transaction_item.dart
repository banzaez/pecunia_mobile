import 'package:flutter/material.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/util/category_icon_helper.dart';
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
    /// Если true, убирает горизонтальные отступы контейнера (для встроенных списков).
    this.edgeToEdge = false,
  });

  final Transaction transaction;
  final bool isRoundUp;
  final Future<bool> Function() onDelete;
  final bool edgeToEdge;


  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.amount > 0;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final amountColor = isIncome 
        ? (isDark ? const Color(0xFF30D158) : const Color(0xFF34C759)) 
        : (isDark ? Colors.white : Colors.black87);

    final iconColor = isDark ? Colors.white70 : Colors.black87;
    final iconBgColor = isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.03);
    final iconBorderColor = isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.08);

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
            splashColor: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.04),
            highlightColor: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.02),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  // Double ring category icon style (monochrome/neutral)
                  Container(
                    padding: const EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: iconBorderColor,
                        width: 1,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        CategoryIconHelper.getIcon(transaction.category?.name),
                        color: iconColor,
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
                          color: amountColor,
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

    const horizontalPadding = 16.0;

    return Dismissible(
      key: Key(transaction.id.toString()),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => _confirmDismiss(context),
      onDismissed: (_) {},
      background: const SizedBox.shrink(),
      secondaryBackground: _deleteBackground(horizontalPadding),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 4),
        child: cardContent,
      ),
    );
  }

  Widget _deleteBackground(double horizontalPadding) => Container(
        decoration: BoxDecoration(
          color: Colors.red.shade800,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 4),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      );

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Используем Flutter overflow вместо ручной обрезки строки
    return Text(
      transaction.description,
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
