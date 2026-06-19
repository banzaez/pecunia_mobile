import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/router/app_router.dart';
import 'package:pecunia/screen/analytics/analytics_controller.dart';
import 'package:pecunia/screen/analytics/analytics_palette.dart';
import 'package:pecunia/screen/analytics/widgets/analytics_category_item.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';

class AnalyticsCategoryList extends ConsumerWidget {
  const AnalyticsCategoryList({
    super.key,
    required this.topPadding,
    required this.bottomPadding,
  });

  final double topPadding;
  final double bottomPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(analyticsNotifierProvider);
    final category = state.category;
    final filter = state.filter;
    final locale = Localizations.localeOf(context).toString();
    final periodStr = state.periodStr(locale);

    if (state.category.isEmpty) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      final accentColor = const Color(0xFF3F51B5); // Sleek Indigo
      
      return Padding(
        padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Glowing Illustration Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          accentColor.withValues(alpha: 0.15),
                          accentColor.withValues(alpha: 0.05),
                        ],
                      ),
                      border: Border.all(
                        color: accentColor.withValues(alpha: 0.25),
                        width: 1.5,
                      ),
                      boxShadow: isDark ? null : [
                        BoxShadow(
                          color: accentColor.withValues(alpha: 0.04),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        )
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.analytics_outlined,
                        color: isDark ? Colors.white70 : accentColor,
                        size: 32,
                      ),
                    ),
                  ),
                  AppSpaces.v24,
                  // Main message
                  Text(
                    l10n.analyticsCategoryEmpty(periodStr),
                    style: AppTextStyle.text15w600(
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  AppSpaces.v8,
                  // Helpful subtitle
                  Text(
                    "Добавьте транзакции или выберите другой период для построения детальных графиков аналитики.",
                    style: AppTextStyle.text12w400(
                      color: isDark ? Colors.white38 : Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final totals = category.map((item) => item.total).toList();
    final totalSum = totals.fold<double>(0, (sum, value) => sum + value.abs());
    final palette = AnalyticsPalette.forFilter(filter, totals);

    return ListView.builder(
      padding: EdgeInsets.only(
        top: topPadding,
        bottom: bottomPadding,
      ),
      clipBehavior: Clip.none,
      itemCount: category.length,
      itemBuilder: (_, index) {
        final analytics = category[index];
        return AnalyticsCategoryItem(
          onTap: analytics.category?.id == null
              ? null
              : () {
                  final args = ref
                      .read(analyticsNotifierProvider.notifier)
                      .buildDetailsArgs(analytics.category!.id);
                  if (args == null) return;
                  context.push(AppRoute.transactions.path, extra: args);
                },
          analytics: analytics,
          index: index,
          totalSum: totalSum,
          categoryColor: AnalyticsPalette.colorAt(palette, index),
        );
      },
    );
  }
}
