import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/analytics_filter.dart';
import 'package:pecunia/router/app_router.dart';
import 'package:pecunia/screen/analytics/analytics_controller.dart';
import 'package:pecunia/screen/analytics/widgets/analytics_category_item.dart';

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
    final locale = Localizations.localeOf(context).toString();
    final periodStr = state.periodStr(locale);

    if (state.category.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
        child: Center(
          child: Text(l10n.analyticsCategoryEmpty(periodStr)),
        ),
      );
    }

    final totalSum = state.category.fold<double>(0.0, (sum, item) => sum + item.total.abs());
    final isTotal = state.filter == AnalyticsFilter.total;
    final isIncome = state.category.isNotEmpty && state.category.first.total > 0;

    final palette = isTotal 
        ? [
            const Color(0xFF3F51B5), // Indigo
            const Color(0xFF673AB7), // Deep Purple
            const Color(0xFF00BCD4), // Cyan
            const Color(0xFF03A9F4), // Light Blue
            const Color(0xFFE91E63), // Pink
            const Color(0xFF9C27B0), // Purple
            const Color(0xFF2196F3), // Blue
          ]
        : isIncome 
            ? [
                const Color(0xFF2E7D32), // Emerald
                const Color(0xFF00796B), // Teal
                const Color(0xFF4CAF50), // Green
                const Color(0xFF009688), // Mint
                const Color(0xFF81C784), // Light Green
                const Color(0xFF66BB6A), 
              ]
            : [
                const Color(0xFFC62828), // Deep Red
                const Color(0xFFD84315), // Deep Orange
                const Color(0xFFE64A19), // Orange Red
                const Color(0xFFF4511E), // Coral
                const Color(0xFFE57373), // Rose
                const Color(0xFFF57C00), // Orange
              ];

    return ListView.builder(
      padding: EdgeInsets.only(
        top: topPadding,
        bottom: bottomPadding,
      ),
      clipBehavior: Clip.none,
      itemCount: state.category.length,
      itemBuilder: (_, index) {
        final analytics = state.category[index];
        final color = palette[index % palette.length];
        return AnalyticsCategoryItem(
          onTap: analytics.category?.id == null
              ? null
              : () {
                  final args = ref
                      .read(analyticsNotifierProvider.notifier)
                      .buildDetailsArgs(analytics.category!.id);
                  context.push(AppRoute.transactions.path, extra: args);
                },
          analytics: analytics,
          index: index,
          totalSum: totalSum,
          categoryColor: color,
        );
      },
    );
  }
}
