import 'package:flutter/material.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/styles/app_border_style.dart';

class BottomSheetActionRow extends StatelessWidget {
  const BottomSheetActionRow({
    super.key,
    required this.action,
    this.onClose,
  });

  static const double buttonHeight = 48;

  final Widget action;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final l10n = AppLocalizations.of(context);
    final actionButtonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(0, buttonHeight),
      maximumSize: const Size(double.infinity, buttonHeight),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(borderRadius: AppBorderStyle.borderRadius),
    );

    return SizedBox(
      height: buttonHeight,
      child: Row(
        children: [
          SizedBox(
            width: buttonHeight,
            height: buttonHeight,
            child: Tooltip(
              message: l10n.bottomSheetClose,
              child: ElevatedButton(
                onPressed: onClose ?? () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppBorderStyle.fillColor(brightness),
                  foregroundColor:
                      Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size(buttonHeight, buttonHeight),
                  maximumSize: const Size(buttonHeight, buttonHeight),
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderStyle.borderRadius,
                    side: BorderSide(color: AppBorderStyle.borderColor(brightness)),
                  ),
                ),
                child: const Icon(Icons.keyboard_arrow_down_rounded),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: Theme.of(context).elevatedButtonTheme.style?.merge(actionButtonStyle),
                ),
              ),
              child: action,
            ),
          ),
        ],
      ),
    );
  }
}
