import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_assets.dart';
import '../../app/router.dart';
import '../../core/utils/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 700;

    return Container(
      color: AppColors.dark,
      padding: EdgeInsets.symmetric(horizontal: isNarrow ? 20 : 40,
        vertical: 32,
      ),
      child: Column(
        children: [
          isNarrow ? _NarrowFooterTop() : _WideFooterTop(),
          const SizedBox(height: 32),
          const Divider(color: Colors.white24),
          const SizedBox(height: 14),
          Text(
            AppStrings.footerCopyright,
            style: const TextStyle(fontSize: 12, color: Colors.white54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: UrlLauncherUtil.openMatric,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: const Text(
                'Developed by Matric Services',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white54,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white54,
                ),
                textAlign: TextAlign.center,
              ),
            ),
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
        // Brand
        Expanded(flex: 2, child: _BrandColumn()),
        const SizedBox(width: 40),

        // Quick Links
        Expanded(
          child: _FooterLinksColumn(
            title: 'Quick Links',
            children: [
              _FooterNavLink('Home', AppRouter.home),
              _FooterNavLink('Catalog', AppRouter.catalog),
              _FooterNavLink('About Us', AppRouter.about),
              _FooterNavLink('Contact', AppRouter.contact),
            ],
          ),
        ),

        // Customer Service
        Expanded(
          child: _FooterLinksColumn(
            title: 'Customer Service',
            children: [
              _FooterFaqLink(),
              _FooterTextItem('Delivery Information'),
              _FooterTextItem('Return Policy'),
              _FooterTextItem('Terms & Conditions'),
              _FooterTextItem('Privacy Policy'),
            ],
          ),
        ),

        // Download App
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _FooterLinksColumn(
                title: 'Quick Links',
                children: [
                  _FooterNavLink('Home', AppRouter.home),
                  _FooterNavLink('About Us', AppRouter.about),
                  _FooterNavLink('Contact', AppRouter.contact),
                  _FooterFaqLink(),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(child: _DownloadColumn()),
          ],
        ),
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
        // Logo
        Row(
          children: [
            Image.asset('assets/logos/bs_logo.png', height: 44,
              errorBuilder: (_, __, ___) => Row(
                  children: [
                    Container( 
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text('BS',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 18)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('BALARAMAYYA',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 12,
                                letterSpacing: 1)),
                        Text('SUPER MARKET',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 2)),
                      ],
                    ),
                  ],
                )),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'Your trusted supermarket\nfor everyday needs.',
          style: TextStyle(fontSize: 12, color: Colors.white60, height: 1.6),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _SocialIcon(FontAwesomeIcons.instagram, UrlLauncherUtil.openInstagram),
            const SizedBox(width: 10),
            // _SocialIcon(FontAwesomeIcons.whatsapp, UrlLauncherUtil.openWhatsApp),
            _AssetSocialIcon(
              'assets/icons/whatsapp.png',
              UrlLauncherUtil.openWhatsApp,
            ),
          ],
        ),
      ],
    );
  }
}

// Generic column with title + children
class _FooterLinksColumn extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _FooterLinksColumn({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
        const SizedBox(height: 14),
        ...children.map((c) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: c,
            )),
      ],
    );
  }
}

class _FooterNavLink extends StatelessWidget {
  final String label;
  final String route;
  final bool redirectToApp;
  const _FooterNavLink(this.label, this.route, {this.redirectToApp = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => redirectToApp
          ? UrlLauncherUtil.openPlayStore()
          : Navigator.pushNamed(context, route),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.white60)),
      ),
    );
  }
}

class _FooterTextItem extends StatelessWidget {
  final String label;
  const _FooterTextItem(this.label);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: UrlLauncherUtil.openPlayStore,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.white60)),
      ),
    );
  }
}

class _FooterFaqLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showFaqDialog(context),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: const Text('FAQs',
            style: TextStyle(fontSize: 12, color: Colors.white60)),
      ),
    );
  }

  void _showFaqDialog(BuildContext context) {
    const faqs = [
      ('Do you deliver?',
          'Yes! We deliver within Kukatpally and nearby areas. Download our app to place a delivery order.'),
      ('What are your store hours?',
          'We are open Monday to Saturday 8:00 AM – 9:00 PM, and Sunday 9:00 AM – 6:00 PM.'),
      ('How do I place an order?',
          'You can visit us in-store, call us, WhatsApp us, or download our app to place orders easily.'),
      ('Do you accept returns?',
          'Yes, we accept returns within 24 hours for fresh produce and within 3 days for packaged goods with a valid receipt.'),
      ('Is there a loyalty program?',
          'Yes! Download our app to earn reward points on every purchase and redeem them for discounts.'),
      ('What payment methods do you accept?',
          'We accept cash, UPI, credit/debit cards, and all major digital wallets.'),
      ('Do you offer bulk or wholesale orders?',
          'Yes! Contact us via WhatsApp or call us directly for bulk order inquiries and special pricing.'),
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
              Container(width: 40, height: 3, color: AppColors.primary),
              const SizedBox(height: 20),
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
                                        margin: const EdgeInsets.only(top: 5),
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
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textDark)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 17),
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
                  // icon: const Icon(Icons.chat, size: 16),
                  icon: Image.asset('assets/icons/whatsapp.png', width: 22, height: 22),
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
        const Text('Download App',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
        const SizedBox(height: 14),
        GestureDetector(
          onTap: UrlLauncherUtil.openPlayStore,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Image.asset(AppAssets.googlePlay,
                height: 32,
                width: 120,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => _StoreBtn('Google Play')),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: UrlLauncherUtil.openAppStore,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Image.asset(AppAssets.appStore,
                height: 32,
                width: 120,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => _StoreBtn('App Store')),
          ),
        ),
      ],
    );
  }
}

class _StoreBtn extends StatelessWidget {
  final String label;
  const _StoreBtn(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white30),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(label,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600)),
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
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

class _AssetSocialIcon extends StatelessWidget {
  final String assetPath;
  final VoidCallback onTap;

  const _AssetSocialIcon(this.assetPath, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Image.asset(
              assetPath,
              width: 36,
              height: 36,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}