import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/router/app_router.dart';
import 'package:pecunia/styles/app_text_style.dart';

class RouteErrorScreen extends StatelessWidget {
  const RouteErrorScreen({super.key, this.error});

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning_amber_rounded, size: 64),
              const SizedBox(height: 24),
              Text(
                l10n.routeErrorTitle,
                style: AppTextStyle.text24w600(),
                textAlign: TextAlign.center,
              ),
              if (error != null) ...[
                const SizedBox(height: 16),
                Text(
                  error.toString(),
                  style: AppTextStyle.text14w400(),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => context.go(AppRoute.home.path),
                child: Text(l10n.routeErrorHome),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
