import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/screen/home/home_controller.dart';
import 'package:pecunia/screen/home/widget/app_add_transaction/app_add_transaction.dart';
import 'package:pecunia/screen/home/widget/current_wallet.dart';
import 'package:pecunia/widgets/setting_wallet/setting_wallet.dart';
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

  Widget _leading() => Obx(() => SettingWallet(
        onChange: (value) => controller.refreshWallet(),
        update: controller.currentWallet,
      ));

  Widget _profile() => IconButton(
        onPressed: controller.goToProfile,
        icon: const Icon(Icons.account_box),
      );

  AppBar _appBar() => AppBar(
        leading: _leading(),
        title: const CurrentWallet(),
        centerTitle: true,
        actions: [
          _profile(),
        ],
      );

  // --------------------------------------------------------------------------------------------

  Widget _body() => Column(
        children: [
          _list(),
          _bottom(),
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

  Widget _bottom() => const AppAddTransaction();

}
