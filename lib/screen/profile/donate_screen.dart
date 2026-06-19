import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_constants.dart';
import 'package:pecunia/widgets/custom_app_bar.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  static const usdtAddress = 'TNiAXq6Jj8uRcgZmkQUCpDQvdmmSZzoGTi';
  static const ethAddress = '0x6df5fc17f75075c0c65d418678af584c797cba98';
  static const btcAddress = '15U6vrF2TM1xzC1N9JSda5FeRFBXZBh3op';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBgColor = isDark
        ? Colors.white.withValues(alpha: 0.015)
        : Colors.white.withValues(alpha: 0.7);

    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.black.withValues(alpha: 0.04);

    return Scaffold(
      appBar: CustomAppBar(title: l10n.donateTitle),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.accentIndigo.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: AppColors.accentIndigo,
                  size: 64,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.donateThanks,
                style: AppTextStyle.text18w700(
                  color: isDark ? Colors.white : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.donateDescription,
                style: AppTextStyle.text14w400(
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              
              // Почта
              _buildSectionTitle(context, l10n.donateContactAuthor),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: cardBgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => _launchMail(context),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.email_outlined, color: AppColors.accentIndigo),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: AppTextStyle.text10w600(
                                    color: isDark ? Colors.white38 : Colors.black38,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  AppConstants.supportEmail,
                                  style: AppTextStyle.text14w600(
                                    color: isDark ? Colors.white70 : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: isDark ? Colors.white38 : Colors.black38,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Реквизиты
              _buildSectionTitle(context, l10n.donateCrypto),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: cardBgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  children: [
                    _buildCryptoItem(
                      context: context,
                      name: 'BTC',
                      address: btcAddress,
                      leading: _buildCryptoBadge(
                        symbol: '₿',
                        color: const Color(0xFFF7931A),
                        icon: Icons.currency_bitcoin_rounded,
                      ),
                      isDark: isDark,
                      l10n: l10n,
                    ),
                    _buildDivider(isDark),
                    _buildCryptoItem(
                      context: context,
                      name: 'ETH (ERC-20)',
                      address: ethAddress,
                      leading: _buildCryptoBadge(
                        symbol: 'Ξ',
                        color: const Color(0xFF627EEA),
                      ),
                      isDark: isDark,
                      l10n: l10n,
                    ),
                    _buildDivider(isDark),
                    _buildCryptoItem(
                      context: context,
                      name: 'USDT (TRC-20)',
                      address: usdtAddress,
                      leading: _buildCryptoBadge(
                        symbol: '₮',
                        color: const Color(0xFF26A17B),
                      ),
                      isDark: isDark,
                      l10n: l10n,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title.toUpperCase(),
        style: AppTextStyle.text10w600(
          color: isDark ? Colors.white38 : Colors.black38,
        ),
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 0.5,
      color: isDark
          ? Colors.white.withValues(alpha: 0.08)
          : Colors.black.withValues(alpha: 0.06),
    );
  }

  Widget _buildCryptoBadge({
    required String symbol,
    required Color color,
    IconData? icon,
  }) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: icon != null
            ? Icon(
                icon,
                color: color,
                size: 20,
              )
            : Text(
                symbol,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildCryptoItem({
    required BuildContext context,
    required String name,
    required String address,
    required Widget leading,
    required bool isDark,
    required AppLocalizations l10n,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          leading,
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyle.text14w700(
                    color: isDark ? Colors.white.withValues(alpha: 0.87) : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                SelectableText(
                  address,
                  style: AppTextStyle.text12w600(
                    color: isDark ? Colors.white54 : Colors.black54,
                  ).copyWith(
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => _copyToClipboard(context, address),
            icon: const Icon(Icons.copy_rounded, size: 20),
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchMail(BuildContext context) async {
    final Uri url = Uri.parse("mailto:${AppConstants.supportEmail}");
    if (!await launchUrl(url) && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).error)),
      );
    }
  }

  void _copyToClipboard(BuildContext context, String address) {
    final l10n = AppLocalizations.of(context);
    Clipboard.setData(ClipboardData(text: address));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.donateCopied),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
