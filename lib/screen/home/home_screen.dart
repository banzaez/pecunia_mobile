import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/providers/settings_notifier.dart';
import 'package:pecunia/router/app_router.dart';
import 'package:pecunia/screen/home/home_controller.dart';
import 'package:pecunia/screen/home/widgets/current_wallet.dart';
import 'package:pecunia/screen/home/widgets/home_bottom_overlay.dart';
import 'package:pecunia/screen/home/widgets/home_error_listener.dart';
import 'package:pecunia/screen/home/widgets/home_top_overlay.dart';
import 'package:pecunia/screen/home/widgets/home_transaction_list.dart';
import 'package:pecunia/widgets/setting_wallet/setting_wallet.dart';
import 'package:pecunia/screen/home/widgets/home_header_button.dart';
import 'package:pecunia/widgets/list_edge_fade.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeNotifierProvider);
    final isRoundUp = ref.watch(settingsNotifierProvider.select((s) => s.isRoundUp));

    return HomeErrorListener(
      child: homeState.isInitializing
          ? const Material(child: Center(child: CircularProgressIndicator()))
          : Scaffold(
              appBar: _appBar(context, homeState),
              body: HomeScreenBody(isRoundUp: isRoundUp, homeState: homeState),
            ),
    );
  }

  AppBar _appBar(BuildContext context, HomeState homeState) {
    final l10n = AppLocalizations.of(context);

    return AppBar(
      toolbarHeight: 64,
      leadingWidth: 56,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Center(
          child: SettingWallet(update: homeState.currentWallet),
        ),
      ),
      title: const CurrentWallet(),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Center(
            child: HomeHeaderButton(
              icon: Icons.person_outline_rounded,
              tooltip: l10n.profileTitle,
              onPressed: () => context.push(AppRoute.profile.path),
            ),
          ),
        ),
      ],
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    super.key,
    required this.isRoundUp,
    required this.homeState,
  });

  final bool isRoundUp;
  final HomeState homeState;

  @override
  Widget build(BuildContext context) {
    const topFadeHeight = 24.0;
    const listInsetTrim = 12.0;

    final showBalance = homeState.currentWallet?.showBalance ?? false;
    final topContentHeight = showBalance ? 148.0 : 56.0;
    final topOverlayHeight = topContentHeight + topFadeHeight * 0.5;

    final systemBottom = MediaQuery.viewPaddingOf(context).bottom;
    final bottomPadding = 188.0 + systemBottom;
    const bottomFadeHeight = 200.0;

    return Stack(
      children: [
        Positioned.fill(
          child: HomeTransactionList(
            isRoundUp: isRoundUp,
            topPadding: topOverlayHeight - listInsetTrim,
            bottomPadding: bottomPadding,
          ),
        ),
        const Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: bottomFadeHeight,
          child: ListEdgeFade(
            height: bottomFadeHeight,
            forBottomNav: true,
          ),
        ),
        const Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: HomeBottomOverlay(),
        ),
        const Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: HomeTopOverlay(fadeHeight: topFadeHeight),
        ),
      ],
    );
  }
}
