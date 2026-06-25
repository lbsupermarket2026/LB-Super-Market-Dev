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
          // Top row
          isNarrow ? _NarrowFooterTop() : _WideFooterTop(),

          const SizedBox(height: 32),
          const Divider(color: Colors.white24),
          const SizedBox(height: 16),

          // Copyright
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
        // Brand Column
        Expanded(flex: 2, child: _BrandColumn()),
        const SizedBox(width: 40),

        // Quick Links
        Expanded(child: _LinksColumn(
          title: AppStrings.quickLinks,
          links: [
            (AppStrings.navHome, AppRouter.home),
            (AppStrings.navCatalog, AppRouter.catalog),
            (AppStrings.navOffers, AppRouter.offers),
            (AppStrings.navAbout, AppRouter.about),
            (AppStrings.navContact, AppRouter.contact),
          ],
        )),

        // Customer Service
        Expanded(child: _TextColumn(
          title: AppStrings.customerService,
          items: [
            AppStrings.footerFaq,
            AppStrings.footerDelivery,
            AppStrings.footerReturn,
            AppStrings.footerTerms,
            AppStrings.footerPrivacy,
          ],
        )),

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
        Image.asset(AppAssets.logo, height: 44,
            errorBuilder: (_, __, ___) => const Icon(
                  Icons.shopping_cart,
                  color: AppColors.primary,
                  size: 36,
                )),
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

class _LinksColumn extends StatelessWidget {
  final String title;
  final List<(String, String)> links;

  const _LinksColumn({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FooterHeading(title),
        const SizedBox(height: 12),
        ...links.map((l) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, l.$2),
                child: Text(l.$1,
                    style: const TextStyle(
                        fontSize: 12, color: Colors.white60)),
              ),
            )),
      ],
    );
  }
}

class _TextColumn extends StatelessWidget {
  final String title;
  final List<String> items;

  const _TextColumn({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FooterHeading(title),
        const SizedBox(height: 12),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(item,
                  style:
                      const TextStyle(fontSize: 12, color: Colors.white60)),
            )),
      ],
    );
  }
}

class _DownloadColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FooterHeading(AppStrings.downloadApp),
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
