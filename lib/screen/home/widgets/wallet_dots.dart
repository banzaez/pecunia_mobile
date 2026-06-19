import 'package:flutter/material.dart';

class WalletDots extends StatelessWidget {
  const WalletDots({
    super.key,
    required this.walletCount,
    required this.currentIndex,
    required this.onStep,
  });

  final int walletCount;
  final int currentIndex;
  final ValueChanged<int> onStep;

  @override
  Widget build(BuildContext context) {
    if (walletCount <= 1) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final muted = isDark ? Colors.white54 : Colors.black45;
    final active = isDark ? Colors.white : Colors.black87;
    final capsuleColor = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : Colors.black.withValues(alpha: 0.04);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        decoration: BoxDecoration(
          color: capsuleColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            _chevron(
              context,
              icon: Icons.chevron_left_rounded,
              color: muted,
              enabled: currentIndex > 0,
              onTap: () => onStep(-1),
            ),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragEnd: (details) {
                  final velocity = details.primaryVelocity ?? 0;
                  if (velocity.abs() < 120) return;
                  onStep(-velocity.sign.toInt());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(walletCount, (index) {
                    final isActive = currentIndex == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isActive ? 18 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: isActive
                            ? active
                            : muted.withValues(alpha: 0.35),
                      ),
                    );
                  }),
                ),
              ),
            ),
            _chevron(
              context,
              icon: Icons.chevron_right_rounded,
              color: muted,
              enabled: currentIndex < walletCount - 1,
              onTap: () => onStep(1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chevron(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 22,
            color: enabled ? color : color.withValues(alpha: 0.25),
          ),
        ),
      ),
    );
  }
}
