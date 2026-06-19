import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pecunia/providers/settings_notifier.dart';
import 'package:pecunia/router/app_router.dart';
import 'package:pecunia/screen/home/home_controller.dart';
import 'package:pecunia/screen/home/widgets/current_wallet.dart';
import 'package:pecunia/screen/home/widgets/home_bottom_overlay.dart';
import 'package:pecunia/screen/home/widgets/home_error_listener.dart';
import 'package:pecunia/screen/home/widgets/home_top_overlay.dart';
import 'package:pecunia/screen/home/widgets/home_transaction_list.dart';
import 'package:pecunia/widgets/setting_wallet/setting_wallet.dart';
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
              extendBody: true,
              appBar: _appBar(context, homeState),
              body: _body(context, ref, isRoundUp, homeState),
            ),
    );
  }

  AppBar _appBar(BuildContext context, HomeState homeState) => AppBar(
        leading: SettingWallet(update: homeState.currentWallet),
        title: const CurrentWallet(),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoute.profile.path),
            icon: const Icon(Icons.account_box),
          ),
        ],
      );

  Widget _body(BuildContext context, WidgetRef ref, bool isRoundUp, HomeState homeState) {
    final bottomSafe = MediaQuery.viewPaddingOf(context).bottom;
    const actionPanelContentHeight = 64.0;
    const walletDotsHeight = 40.0;
    const topFadeHeight = 24.0;
    const bottomFadeExtension = 36.0;
    const listInsetTrim = 12.0;
    final bottomOverlayHeight =
        actionPanelContentHeight + walletDotsHeight + bottomSafe + 4;
    final bottomScrimHeight = bottomOverlayHeight + bottomFadeExtension;

    final showBalance = homeState.currentWallet?.showBalance ?? false;
    final topContentHeight = showBalance ? 148.0 : 56.0;
    final topOverlayHeight = topContentHeight + topFadeHeight * 0.5;

    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: Stack(
        children: [
          Positioned.fill(
            child: HomeTransactionList(
              isRoundUp: isRoundUp,
              topPadding: topOverlayHeight - listInsetTrim,
              bottomPadding: bottomScrimHeight - listInsetTrim,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: bottomScrimHeight,
            child: ListEdgeFade(
              height: bottomScrimHeight,
              forBottomNav: true,
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: HomeTopOverlay(fadeHeight: topFadeHeight),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: HomeBottomOverlay(bottomSafe: bottomSafe),
          ),
        ],
      ),
    );
  }
}
