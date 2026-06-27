import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_assets.dart';
import '../../app/router.dart';
import '../../core/utils/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 700;

    return Container(
      color: AppColors.dark,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        children: [
          isNarrow ? _NarrowFooterTop() : _WideFooterTop(),
          const SizedBox(height: 32),
          const Divider(color: Colors.white24),
          const SizedBox(height: 16),
          Text(
            AppStrings.footerCopyright,
            style: const TextStyle(fontSize: 12, color: Colors.white54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _WideFooterTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _BrandColumn()),
        const SizedBox(width: 40),
        Expanded(child: _QuickLinksColumn()),
        Expanded(child: _DownloadColumn()),
      ],
    );
  }
}

class _NarrowFooterTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BrandColumn(),
        const SizedBox(height: 24),
        _QuickLinksColumn(),
        const SizedBox(height: 24),
        _DownloadColumn(),
      ],
    );
  }
}

class _BrandColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text('BS',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        letterSpacing: 0.5)),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('BALARAMAYYA',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                        letterSpacing: 1)),
                Text('SUPER MARKET',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 9,
                        letterSpacing: 2)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          AppStrings.footerTagline,
          style: TextStyle(fontSize: 12, color: Colors.white60, height: 1.6),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _SocialIcon(Icons.facebook, () {}),
            const SizedBox(width: 12),
            _SocialIcon(Icons.camera_alt, () {}),
            const SizedBox(width: 12),
            _SocialIcon(Icons.chat, UrlLauncherUtil.openWhatsApp),
          ],
        ),
      ],
    );
  }
}

class _QuickLinksColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navLinks = [
      (AppStrings.navHome, AppRouter.home),
      (AppStrings.navAbout, AppRouter.about),
      (AppStrings.navContact, AppRouter.contact),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FooterHeading(AppStrings.quickLinks),
        const SizedBox(height: 12),
        ...navLinks.map((l) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, l.$2),
                child: Text(l.$1,
                    style: const TextStyle(fontSize: 12, color: Colors.white60)),
              ),
            )),
        GestureDetector(
          onTap: () => _showFaqDialog(context),
          child: const Text('FAQs',
              style: TextStyle(fontSize: 12, color: Colors.white60)),
        ),
      ],
    );
  }

  void _showFaqDialog(BuildContext context) {
    const faqs = [
      (
        'Do you deliver?',
        'Yes! We deliver within Kukatpally and nearby areas. Download our app to place a delivery order.'
      ),
      (
        'What are your store hours?',
        'We are open Monday to Saturday 8:00 AM – 9:00 PM, and Sunday 9:00 AM – 6:00 PM.'
      ),
      (
        'How do I place an order?',
        'You can visit us in-store, call us, WhatsApp us, or download our app to place orders easily.'
      ),
      (
        'Do you accept returns?',
        'Yes, we accept returns within 24 hours for fresh produce and within 3 days for packaged goods with a valid receipt.'
      ),
      (
        'Is there a loyalty program?',
        'Yes! Download our app to earn reward points on every purchase and redeem them for discounts.'
      ),
      (
        'What payment methods do you accept?',
        'We accept cash, UPI, credit/debit cards, and all major digital wallets.'
      ),
      (
        'Do you offer bulk or wholesale orders?',
        'Yes! Contact us via WhatsApp or call us directly for bulk order inquiries and special pricing.'
      ),
    ];

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 520,
          constraints: const BoxConstraints(maxHeight: 600),
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Frequently Asked Questions',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Container(width: 40, height: 3, color: AppColors.primary),
              const SizedBox(height: 20),

              // FAQ list scrollable
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: faqs
                        .map((f) => Padding(
                              padding: const EdgeInsets.only(bottom: 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(top: 5),
                                        width: 7,
                                        height: 7,
                                        decoration: const BoxDecoration(
                                          color: AppColors.primary,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(f.$1,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight:
                                                    FontWeight.w700,
                                                color: AppColors.textDark)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 17),
                                    child: Text(f.$2,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.textGrey,
                                            height: 1.6)),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 14),
                                    child: Divider(height: 1),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),

              // Bottom CTA
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    UrlLauncherUtil.openWhatsApp();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.chat, size: 16),
                  label: const Text('Still have questions? WhatsApp us',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DownloadColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FooterHeading(AppStrings.downloadApp),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: UrlLauncherUtil.openPlayStore,
          child: Image.asset(AppAssets.googlePlay, height: 36,
              errorBuilder: (_, __, ___) => _StoreButton('Google Play')),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: UrlLauncherUtil.openAppStore,
          child: Image.asset(AppAssets.appStore, height: 36,
              errorBuilder: (_, __, ___) => _StoreButton('App Store')),
        ),
      ],
    );
  }
}

class _StoreButton extends StatelessWidget {
  final String label;
  const _StoreButton(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white30),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label,
          style: const TextStyle(color: AppColors.white, fontSize: 12)),
    );
  }
}

class _FooterHeading extends StatelessWidget {
  final String text;
  const _FooterHeading(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _SocialIcon(this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, color: AppColors.white, size: 16),
      ),
    );
  }
}