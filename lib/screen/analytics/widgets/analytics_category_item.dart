import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/analytics.dart';
import 'package:pecunia/screen/analytics/analytics_controller.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/util/ext_double.dart';

class AnalyticsCategoryItem extends ConsumerWidget {
  const AnalyticsCategoryItem({
    super.key,
    this.onTap,
    required this.analytics,
    required this.index,
    this.totalSum,
    this.categoryColor,
  });

  final VoidCallback? onTap;
  final Analytics analytics;
  final int index;
  final double? totalSum;
  final Color? categoryColor;

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

  int? _getParentCategoryId(int subcategoryId) {
    if (subcategoryId >= 100 && subcategoryId <= 999) {
      return subcategoryId ~/ 10;
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isIncome = analytics.total > 0;
    final accentColor = isIncome ? const Color(0xFF2E7D32) : const Color(0xFFC62828); // generic green/red
    
    // Check if this item is selected
    final selectedIndex = ref.watch(selectedCategoryIndexProvider);
    final isSelected = selectedIndex == index;
    
    // Watch detailed subcategories from notifier
    final subcategories = ref.watch(analyticsNotifierProvider.select((s) => s.subcategory));
    
    // Filter subcategories that belong to this category
    final parentId = analytics.category?.id;
    final matchingSubcategories = parentId == null 
        ? <Analytics>[]
        : subcategories.where((subcat) => 
            subcat.category?.id != null && _getParentCategoryId(subcat.category!.id) == parentId
          ).toList();

    // Use categoryColor from chart if available, otherwise fallback to accentColor
    final displayColor = categoryColor ?? accentColor;
    
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Calculate percentage of this category compared to total
    double percentage = 0.0;
    if (totalSum != null && totalSum! > 0) {
      percentage = (analytics.total.abs() / totalSum!) * 100;
    }
    
    // Sleek card background (slightly highlighted if selected)
    final cardBgColor = isSelected
        ? (isDark ? displayColor.withValues(alpha: 0.1) : displayColor.withValues(alpha: 0.04))
        : (isDark ? Colors.white.withValues(alpha: 0.03) : Colors.white);

    final borderColor = isSelected
        ? displayColor.withValues(alpha: 0.5)
        : (isDark ? Colors.white.withValues(alpha: 0.06) : Colors.black.withValues(alpha: 0.05));

    final borderWidth = isSelected ? 1.5 : 1.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: isDark ? null : [
          BoxShadow(
            color: isSelected 
                ? displayColor.withValues(alpha: 0.08) 
                : Colors.black.withValues(alpha: 0.015),
            blurRadius: isSelected ? 10 : 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              final current = ref.read(selectedCategoryIndexProvider);
              ref.read(selectedCategoryIndexProvider.notifier).setIndex(
                  current == index ? null : index);
            },
            splashColor: displayColor.withValues(alpha: 0.08),
            highlightColor: displayColor.withValues(alpha: 0.04),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      // Double ring icon style
                      Container(
                        padding: const EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: displayColor.withValues(alpha: 0.25),
                            width: 1,
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: displayColor.withValues(alpha: 0.08),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _getCategoryIcon(analytics.category?.name),
                            color: displayColor,
                            size: 16,
                          ),
                        ),
                      ),
                      AppSpaces.h12,
                      // Category details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              analytics.category?.localizedName(l10n) ?? "",
                              style: AppTextStyle.text14w600(
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 1),
                            Text(
                              "${analytics.count} ${l10n.analyticsCategoryItemCount.toLowerCase()}",
                              style: AppTextStyle.text12w400(
                                color: isDark ? Colors.white60 : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppSpaces.h12,
                      // Amount & Percentage text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            (isIncome ? "+" : "") + analytics.total.formatSum,
                            style: AppTextStyle.text15w600(
                              color: accentColor,
                            ),
                          ),
                          if (percentage > 0) ...[
                            const SizedBox(height: 1),
                            Text(
                              "${percentage.toStringAsFixed(1)}%",
                              style: AppTextStyle.text12w600(
                                color: isDark ? Colors.white60 : Colors.black54,
                              ),
                            ),
                          ],
                        ],
                      ),
                      // Dedicated Navigate Button
                      if (onTap != null) ...[
                        AppSpaces.h12,
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                          ),
                          color: isDark ? Colors.white38 : Colors.black38,
                          onPressed: onTap,
                        ),
                      ],
                    ],
                  ),
                  if (percentage > 0) ...[
                    const SizedBox(height: 8),
                    // Custom linear progress indicator
                    Stack(
                      children: [
                        Container(
                          height: 3,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isDark 
                                ? Colors.white.withValues(alpha: 0.06) 
                                : Colors.black.withValues(alpha: 0.04),
                            borderRadius: BorderRadius.circular(1.5),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: percentage / 100,
                          child: Container(
                            height: 3,
                            decoration: BoxDecoration(
                              color: displayColor,
                              borderRadius: BorderRadius.circular(1.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  // Subcategories breakdown when expanded
                  if (isSelected && matchingSubcategories.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    const Divider(height: 1, thickness: 0.5),
                    const SizedBox(height: 8),
                    ...matchingSubcategories.map((subcat) {
                      final subcatPercentage = analytics.total.abs() > 0 
                          ? (subcat.total.abs() / analytics.total.abs()) * 100 
                          : 0.0;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 4),
                                Icon(
                                  _getCategoryIcon(subcat.category?.name),
                                  color: displayColor.withValues(alpha: 0.7),
                                  size: 13,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    subcat.category?.localizedName(l10n) ?? "",
                                    style: AppTextStyle.text12w400(
                                      color: isDark ? Colors.white70 : Colors.black87,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  subcat.total.formatSum,
                                  style: AppTextStyle.text12w600(
                                    color: displayColor,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "${subcatPercentage.toStringAsFixed(0)}%",
                                  style: AppTextStyle.text10w600(
                                    color: isDark ? Colors.white38 : Colors.black38,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 2,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: isDark 
                                          ? Colors.white.withValues(alpha: 0.04) 
                                          : Colors.black.withValues(alpha: 0.03),
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                  ),
                                  FractionallySizedBox(
                                    widthFactor: subcatPercentage / 100,
                                    child: Container(
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: displayColor.withValues(alpha: 0.7),
                                        borderRadius: BorderRadius.circular(1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
