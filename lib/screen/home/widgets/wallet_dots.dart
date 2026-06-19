import 'package:flutter/material.dart';

class WalletDots extends StatelessWidget {
  const WalletDots({
    super.key,
    required this.walletCount,
    required this.currentIndex,
    required this.onSwipe,
  });

  final int walletCount;
  final int currentIndex;
  final ValueChanged<int> onSwipe;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onPanEnd: (details) {
          final dx = details.velocity.pixelsPerSecond.dx;
          onSwipe(dx.sign.toInt());
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: List.generate(
              walletCount,
              (index) => Icon(
                currentIndex == index
                    ? Icons.fiber_manual_record
                    : Icons.fiber_manual_record_outlined,
                size: 18,
              ),
            ),
          ),
        ),
      );
}
