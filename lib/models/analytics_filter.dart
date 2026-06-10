import 'package:pecunia/l10n/app_localizations.dart';

enum AnalyticsFilter {
  income,
  expenses,
  total;

  String label(AppLocalizations l10n) => switch (this) {
        income => l10n.analyticsIncome,
        expenses => l10n.analyticsExpenses,
        total => l10n.analyticsTotal,
      };
}
