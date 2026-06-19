import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/finance_categories.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/providers/transaction_notifier.dart';
import 'package:pecunia/styles/app_border_style.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/util/ext_double.dart';
import 'package:pecunia/widgets/app_bottom_sheet.dart';
import 'package:pecunia/widgets/fields/number_field.dart';
import 'package:pecunia/widgets/fields/wallet_field.dart';
import 'package:pecunia/widgets/text_error.dart';
import 'package:pecunia/widgets/transfer/transfer_controller.dart';

class Transfer extends StatelessWidget {
  const Transfer({super.key});

  @override
  Widget build(BuildContext context) => IconButton.filled(
    onPressed: () => _bottomSheet(context),
    icon: const Icon(Icons.compare_arrows),
  );

  // --------------------------------------------------------------------------------------------

  Future<void> _bottomSheet(BuildContext context) async =>
      await appBottomSheet(context, const _TransferSheet());
}

// ---------------------------------------------------------------------------
// Internal sheet widget
// ---------------------------------------------------------------------------

class _TransferSheet extends ConsumerStatefulWidget {
  const _TransferSheet();

  @override
  ConsumerState<_TransferSheet> createState() => _TransferSheetState();
}

class _TransferSheetState extends ConsumerState<_TransferSheet> {
  late TransferController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TransferController();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListenableBuilder(
      listenable: _ctrl,
      builder: (_, _) {
        // Resolve error message from l10n
        final walletError = _ctrl.errorWallet != null
            ? l10n.transferErrorWallet
            : null;

        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.transferTitle,
                style: AppTextStyle.text16w400(),
                textAlign: TextAlign.center,
              ),
              AppSpaces.v16,
              Text(l10n.from),
              WalletField(
                onChanged: (value) => _ctrl.from = value,
                initValue: _ctrl.from,
              ),
              Text(l10n.to),
              WalletField(
                onChanged: (value) => _ctrl.to = value,
                initValue: _ctrl.to,
              ),
              TextError(text: walletError),
              AppSpaces.v16,
              if (_ctrl.differentCurrencies)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: NumberField(
                          controller: _ctrl.amount,
                          labelText: _ctrl.from?.currency?.name,
                        ),
                      ),
                      AppSpaces.h16,
                      _exchangeRate(context, l10n),
                    ],
                  ),
                ),
              AppSpaces.v16,
              Row(
                children: [
                  Expanded(
                    child: NumberField(
                      controller: _ctrl.total,
                      labelText: _ctrl.to?.currency?.name,
                    ),
                  ),
                  AppSpaces.h16,
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _ctrl.enableDone
                          ? () => _onDone(context, l10n)
                          : null,
                      child: Text(l10n.transferDone),
                    ),
                  ),
                ],
              ),
              AppSpaces.v32,
            ],
          ),
        );
      },
    );
  }

  Widget _exchangeRate(BuildContext context, AppLocalizations l10n) => Expanded(
    child: Row(
      children: [
        GestureDetector(
          onTap: _ctrl.toggleDivisionSign,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundContent(context),
              border: AppBorderStyle.borderSideBox,
              borderRadius: AppBorderStyle.borderRadius,
            ),
            width: 48,
            height: 48,
            child: Center(
              child: Text(
                _ctrl.divisionSign ? "/" : "*",
                style: AppTextStyle.text18w400(),
              ),
            ),
          ),
        ),
        AppSpaces.h8,
        Flexible(
          child: NumberField(
            controller: _ctrl.exchangeRate,
            decimal: 5,
            enabled: _ctrl.differentCurrencies,
            labelText: l10n.transferExchangeRate,
          ),
        ),
      ],
    ),
  );

  void _onDone(BuildContext context, AppLocalizations l10n) {
    if (!_ctrl.isOk()) return;
    _executeTransfer(context, l10n);
  }

  Future<void> _executeTransfer(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    final from = _ctrl.from;
    final to = _ctrl.to;
    if (from == null || to == null) return;

    final description = l10n.transferDescription(
      from.name,
      to.name,
      _ctrl.exchangeRate.number.toDouble().formatDouble,
    );

    final fromTransaction = Transaction.empty();
    fromTransaction.walletId = from.id;
    fromTransaction.category = FinanceCategories.transfer;
    fromTransaction.description = description;
    fromTransaction.amount = -_ctrl.amount.number.toDouble();

    final toTransaction = Transaction.empty();
    toTransaction.walletId = to.id;
    toTransaction.category = FinanceCategories.transfer;
    toTransaction.description = description;
    toTransaction.amount = _ctrl.total.number.toDouble();

    await ref
        .read(transactionNotifierProvider.notifier)
        .addTransferSQL(fromTransaction, toTransaction);

    if (ref.read(transactionNotifierProvider).error != null) return;
    if (!context.mounted) return;
    Navigator.of(context).pop(true);
  }
}
