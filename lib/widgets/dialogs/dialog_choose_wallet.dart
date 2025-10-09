import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/wallet_controller.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/app_bottom_sheet.dart';
import 'package:pecunia/widgets/flex_builder.dart';
import 'package:pecunia/widgets/wallet_item.dart';

class DialogChooseWallet extends StatelessWidget {
  const DialogChooseWallet({super.key, required this.onChanged, required this.child});

  final ValueChanged<Wallet?> onChanged;
  final Widget child;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => _onTap().then((wallet) {
          if(wallet == null) return;
          onChanged(wallet);
        }),
        child: child,
      );

  // --------------------------------------------------------------------------------------------

  Widget _item(Wallet wallet) => GestureDetector(
        onTap: () => Get.backLegacy(result: wallet),
        child: WalletItem(wallet: wallet, isEditing: false),
      );

  Future<Wallet?> _onTap() async {
    final controller = Get.find<WalletController>();
    return await appBottomSheet(
      SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("current_wallet_bottom_title".tr),
            AppSpaces.v16,
            FlexBuilder(
              mainAxisSize: MainAxisSize.min,
              itemCount: controller.wallets.length,
              itemBuilder: (_, index) => _item(controller.wallets[index]),
            ),
            AppSpaces.v32,
          ],
        ),
      ),
    );
  }
}
