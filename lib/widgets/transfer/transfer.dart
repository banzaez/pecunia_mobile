import 'package:flutter/material.dart';
import 'package:pecunia/widgets/app_bottom_sheet.dart';
import 'package:pecunia/widgets/transfer/transfer_sheet.dart';

class Transfer extends StatelessWidget {
  const Transfer({super.key});

  @override
  Widget build(BuildContext context) => IconButton.filled(
        onPressed: () => appBottomSheet(context, const TransferSheet()),
        icon: const Icon(Icons.compare_arrows),
      );
}
