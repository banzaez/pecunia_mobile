import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/widgets/dialogs/dialog_choose_wallet.dart';
import 'package:pecunia/widgets/wallet_item.dart';

class WalletField extends StatelessWidget {
  const WalletField({super.key, required this.onChanged, this.initValue});

  final ValueChanged<Wallet?> onChanged;
  final Wallet? initValue;

  @override
  Widget build(BuildContext context) => DialogChooseWallet(
    onChanged: onChanged,
    child: initValue == null
        ? Card(
          color: AppColors.backgroundContent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text("wallet_field_empty".tr)),
              const Icon(Icons.arrow_drop_up),
            ],
          ).paddingSymmetric(horizontal: 16, vertical: 16),
        )
        : WalletItem(wallet: initValue!, isEditing: false),
  );
}
