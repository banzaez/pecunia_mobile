import 'package:flutter/material.dart';
import 'package:pecunia/models/transaction_type.dart';
import 'package:pecunia/styles/app_colors.dart';

class TransactionTypeIcon extends StatelessWidget {
  const TransactionTypeIcon({
    super.key,
    required this.type,
    this.size = 32,
    this.compact = false,
  });

  final TransactionType type;
  final double size;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final isIncome = type == TransactionType.income;
    final color = isIncome ? AppColors.income : AppColors.expense;
    final iconSize = size * (compact ? 0.5 : 0.45);

    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: compact ? 0.12 : 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          isIncome ? Icons.add_rounded : Icons.remove_rounded,
          size: iconSize,
          color: color,
        ),
      ),
    );
  }
}
