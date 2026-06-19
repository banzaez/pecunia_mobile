import 'package:go_router/go_router.dart';
import 'package:pecunia/screen/analytics/analytics_screen.dart';
import 'package:pecunia/screen/backup/backup_screen.dart';
import 'package:pecunia/screen/home/home_screen.dart';
import 'package:pecunia/screen/profile/profile_screen.dart';
import 'package:pecunia/screen/transactions/transactions_arguments.dart';
import 'package:pecunia/screen/transactions/transactions_screen.dart';
import 'package:pecunia/screen/wallets/wallets_screen.dart';
import 'package:pecunia/widgets/route_error_screen.dart';

enum AppRoute {
  home,
  analytics,
  backup,
  profile,
  transactions,
  wallets;

  String get path => switch (this) {
        home => '/',
        analytics => '/analytics',
        backup => '/backup',
        profile => '/profile',
        transactions => '/transactions',
        wallets => '/wallets',
      };

  String get name => switch (this) {
        home => 'home',
        analytics => 'analytics',
        backup => 'backup',
        profile => 'profile',
        transactions => 'transactions',
        wallets => 'wallets',
      };
}

final appRouter = GoRouter(
  initialLocation: AppRoute.home.path,
  errorBuilder: (context, state) => RouteErrorScreen(error: state.error),
  routes: [
    GoRoute(
      path: AppRoute.home.path,
      name: AppRoute.home.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoute.analytics.path,
      name: AppRoute.analytics.name,
      builder: (context, state) => const AnalyticsScreen(),
    ),
    GoRoute(
      path: AppRoute.backup.path,
      name: AppRoute.backup.name,
      builder: (context, state) => const BackupScreen(),
    ),
    GoRoute(
      path: AppRoute.profile.path,
      name: AppRoute.profile.name,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: AppRoute.transactions.path,
      name: AppRoute.transactions.name,
      builder: (context, state) {
        final args = state.extra;
        if (args is! TransactionsArguments) {
          return const RouteErrorScreen();
        }
        return TransactionsScreen(args: args);
      },
    ),
    GoRoute(
      path: AppRoute.wallets.path,
      name: AppRoute.wallets.name,
      builder: (context, state) => const WalletsScreen(),
    ),
  ],
);
