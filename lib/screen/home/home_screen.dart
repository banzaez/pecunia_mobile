import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/screen/home/home_controller.dart';
import 'package:pecunia/screen/home/widget/current_wallet.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/widgets/setting_transaction/setting_transaction.dart';
import 'package:pecunia/widgets/setting_wallet/setting_wallet.dart';
import 'package:pecunia/widgets/total_header.dart';
import 'package:pecunia/widgets/transaction_item.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Obx(() => controller.isInitializing
      ? const Material(
          child: Center(child: CircularProgressIndicator()),
        )
      : Scaffold(
        appBar: _appBar(),
        body: _body(),
      ));

  // --------------------------------------------------------------------------------------------

  PreferredSize _analytics() {
    final bool showBalance = controller.currentWallet.showBalance;
    return PreferredSize(
      preferredSize: Size.fromHeight(showBalance ? 108.0 : 48.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showBalance) TotalHeader(total: controller.total),
          TextButton.icon(
            onPressed: controller.goToAnalytics,
            icon: const Icon(Icons.query_stats),
            label: Text("analytics_title".tr, style: AppTextStyle.text16w400()),
          ),
        ],
      ),
    );
  }

  Widget _profile() => IconButton(
        onPressed: controller.goToProfile,
        icon: const Icon(Icons.account_box),
      );

  AppBar _appBar() => AppBar(
        leading: SettingWallet(update: controller.currentWallet),
        title: const CurrentWallet(),
        centerTitle: true,
        actions: [
          _profile(),
        ],
        bottom: _analytics(),
      );

  // --------------------------------------------------------------------------------------------

  Widget _body() => Column(
        children: [
          _list(),
          const SettingTransaction().paddingSymmetric(horizontal: 16),
        ],
      );

  // --------------------------------------------------------------------------------------------

  Widget _list() => Expanded(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView.builder(
              itemCount: controller.transactions.length,
              itemBuilder: (_, index) =>
                  TransactionItem(transaction: controller.transactions[index]),
            ),
            _dots(),
          ],
        ),
      );

  Widget _dots() => GestureDetector(
        onPanEnd: (details) {
          final dx = details.velocity.pixelsPerSecond.dx;
          controller.swipeWallet(dx.sign.toInt());
        },
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: List.generate(
                controller.wallets.length,
                (index) => Icon(
                    controller.currentIndex == index
                        ? Icons.fiber_manual_record
                        : Icons.fiber_manual_record_outlined,
                    size: 18)),
          ),
        ),
      );
}
