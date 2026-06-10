import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/analytics_filter.dart';
import 'package:pecunia/router/app_router.dart';
import 'package:pecunia/screen/analytics/analytics_controller.dart';
import 'package:pecunia/screen/analytics/widgets/analytics_category_item.dart';
import 'package:pecunia/screen/analytics/widgets/analytics_graph.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/util/ext_double.dart';
import 'package:pecunia/widgets/custom_app_bar.dart';
import 'package:pecunia/widgets/fields/app_switch.dart';
import 'package:pecunia/widgets/fields/pick_date/pick_date.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBar(title: l10n.analyticsTitle),
      body: _body(context, ref, l10n),
    );
  }

  // --------------------------------------------------------------------------------------------

  Widget _body(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    final state = ref.watch(analyticsNotifierProvider);
    final periodStr = state.periodStr('');

    return Column(
      children: [
        state.category.isEmpty
            ? Expanded(
                child: Center(child: Text(l10n.analyticsCategoryEmpty(periodStr))),
              )
            : Expanded(
                child: Column(
                  children: [
                    Text(l10n.analyticsCategoryPeriod(periodStr)),
                    AppSpaces.v16,
                    Flexible(
                      flex: 3,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          AnalyticsGraph(
                            data: state.category,
                            isTotal: state.filter == AnalyticsFilter.total,
                          ),
                          Positioned(
                            right: 38,
                            child: _amount(state, l10n),
                          ),
                        ],
                      ),
                    ),
                    AppSpaces.v16,
                    Expanded(flex: 4, child: _category(context, ref, state, l10n)),
                    AppSpaces.v16,
                  ],
                ),
              ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              AppSwitch(
                onChange: (value) =>
                    ref.read(analyticsNotifierProvider.notifier).setFilter(value),
                values: List.generate(
                  AnalyticsFilter.values.length,
                  (i) => AppSwitchValue(
                      label: AnalyticsFilter.values[i].label(l10n),
                      value: AnalyticsFilter.values[i],
                      color: i == 0
                          ? Colors.green
                          : i == 1
                              ? Colors.red
                              : null),
                ),
                value: state.filter,
              ),
              AppSpaces.v16,
              PickDate(
                onChanged: (value, type) =>
                    ref.read(analyticsNotifierProvider.notifier).setDate(value!, type),
                initDate: state.date,
                enableTime: false,
                isYearSelected: state.period == DateType.year,
                isMonthSelected: state.period == DateType.month,
                isDaySelected: state.period == DateType.day,
                valuesYear: state.valuesYear,
                valuesMonth: state.valuesMonth,
                valuesDay: state.valuesDay,
              ),
            ],
          ),
        ),
        AppSpaces.v64,
      ],
    );
  }

  // --------------------------------------------------------------------------------------------

  Widget _amount(AnalyticsState state, AppLocalizations l10n) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("${l10n.analyticsTotalPeriod} ", style: AppTextStyle.text12w400()),
          Text(state.total.formatSum, style: AppTextStyle.text18w400()),
        ],
      );

  Widget _category(
    BuildContext context,
    WidgetRef ref,
    AnalyticsState state,
    AppLocalizations l10n,
  ) =>
      ListView.builder(
        shrinkWrap: true,
        itemCount: state.category.length,
        itemBuilder: (_, index) {
          final analytics = state.category[index];
          return AnalyticsCategoryItem(
            onTap: () {
              final args = ref
                  .read(analyticsNotifierProvider.notifier)
                  .buildDetailsArgs(analytics.category?.id ?? 0);
              context.push(AppRoute.transactions.path, extra: args);
            },
            analytics: analytics,
            index: index,
          );
        },
      );
}
