import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/analytics.dart';
import 'package:pecunia/screen/analytics/analytics_controller.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/util/category_icon_helper.dart';
import 'package:pecunia/util/ext_double.dart';

class AnalyticsCategoryItem extends ConsumerWidget {
  const AnalyticsCategoryItem({
    super.key,
    this.onTap,
    required this.analytics,
    required this.index,
    this.totalSum,
    this.categoryColor,
    this.matchingSubcategories = const [],
  });

  final VoidCallback? onTap;
  final Analytics analytics;
  final int index;
  final double? totalSum;
  final Color? categoryColor;
  final List<Analytics> matchingSubcategories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isIncome = analytics.total > 0;
    final accentColor = isIncome ? const Color(0xFF2E7D32) : const Color(0xFFC62828);

    final selectedIndex = ref.watch(selectedCategoryIndexProvider);
    final isSelected = selectedIndex == index;

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
                            CategoryIconHelper.getIcon(analytics.category?.name),
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
                                  CategoryIconHelper.getIcon(subcat.category?.name),
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
