import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/router/app_router.dart';
import 'package:pecunia/models/analytics.dart';
import 'package:pecunia/screen/analytics/analytics_controller.dart';
import 'package:pecunia/screen/analytics/analytics_palette.dart';
import 'package:pecunia/screen/analytics/widgets/analytics_category_item.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/widgets/empty_state_view.dart';

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
    final category = ref.watch(analyticsNotifierProvider.select((s) => s.category));
    final subcategory = ref.watch(analyticsNotifierProvider.select((s) => s.subcategory));
    final filter = ref.watch(analyticsNotifierProvider.select((s) => s.filter));
    final locale = Localizations.localeOf(context).toString();
    final periodStr = ref.watch(
      analyticsNotifierProvider.select((s) => s.periodStr(locale)),
    );

    if (category.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
        child: EmptyStateView(
          icon: Icons.analytics_outlined,
          title: l10n.analyticsCategoryEmpty(periodStr),
          subtitle: l10n.analyticsCategoryEmptyDesc,
          accentColor: AppColors.accentIndigo,
        ),
      );
    }

    final totals = category.map((item) => item.total).toList();
    final totalSum = totals.fold<double>(0, (sum, value) => sum + value.abs());
    final palette = AnalyticsPalette.forFilter(filter, totals);
    final subcategoryByParent = _groupSubcategories(subcategory);

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
          matchingSubcategories: subcategoryByParent[analytics.category?.id] ?? const [],
        );
      },
    );
  }

  static Map<int, List<Analytics>> _groupSubcategories(List<Analytics> subcategories) {
    final map = <int, List<Analytics>>{};
    for (final subcat in subcategories) {
      final id = subcat.category?.id;
      if (id == null) continue;
      final parentId = _parentCategoryId(id);
      if (parentId == null) continue;
      map.putIfAbsent(parentId, () => []).add(subcat);
    }
    return map;
  }

  static int? _parentCategoryId(int subcategoryId) {
    if (subcategoryId >= 100 && subcategoryId <= 999) {
      return subcategoryId ~/ 10;
    }
    return null;
  }
}
