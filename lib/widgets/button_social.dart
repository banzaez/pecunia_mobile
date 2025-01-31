import 'package:flutter/material.dart';
import 'package:pecunia/util/app_spaces.dart';

class ButtonSocial extends StatelessWidget {
  const ButtonSocial({
    super.key,
    this.onPressed,
    required this.label,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final String label;
  final String icon; // path to image

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(icon, width: 24, height: 24),
            AppSpaces.h24,
            Text(label),
            AppSpaces.h12,
          ],
        ),
      );
}
