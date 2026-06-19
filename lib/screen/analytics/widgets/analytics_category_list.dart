import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pecunia/l10n/app_localizations.dart';
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

    return ListView.builder(
      padding: EdgeInsets.only(
        top: topPadding,
        bottom: bottomPadding,
      ),
      clipBehavior: Clip.none,
      itemCount: state.category.length,
      itemBuilder: (_, index) {
        final analytics = state.category[index];
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
        );
      },
    );
  }
}
