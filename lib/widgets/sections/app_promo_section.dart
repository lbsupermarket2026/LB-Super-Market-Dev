import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_assets.dart';
import '../../core/responsive/breakpoints.dart';
import '../../core/utils/url_launcher.dart';

class AppPromoSection extends StatelessWidget {
  const AppPromoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 48,
        vertical: 32,
      ),
      decoration: BoxDecoration(
        color: AppColors.darkBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: isMobile ? _MobilePromo() : _DesktopPromo(),
    );
  }
}

class _DesktopPromo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Row(
        children: [
          // Phone mockup
          Image.asset(AppAssets.appPromoPhone, height: 180,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.phone_android, color: AppColors.primary, size: 80)),
          const SizedBox(width: 32),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.promoHeadline1,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  AppStrings.promoHeadline2,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  AppStrings.promoSubtitle,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                      height: 1.5),
                ),
              ],
            ),
          ),

          const SizedBox(width: 32),

          // QR + Badges
          _AppDownloadWidget(),
        ],
      ),
    );
  }
}

class _MobilePromo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.promoHeadline1,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.white),
          ),
          Text(
            AppStrings.promoHeadline2,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.secondary),
          ),
          const SizedBox(height: 10),
          Text(
            AppStrings.promoSubtitle,
            style: TextStyle(
                fontSize: 13, color: Colors.white.withOpacity(0.7), height: 1.5),
          ),
          const SizedBox(height: 20),
          _AppDownloadWidget(),
        ],
      ),
    );
  }
}

class _AppDownloadWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          AppStrings.promoScanText,
          style: TextStyle(fontSize: 12, color: Colors.white70),
        ),
        const SizedBox(height: 8),
        // QR Code
        Container(
          width: 90,
          height: 90,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(AppAssets.qrCode,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.qr_code_2, size: 60, color: AppColors.dark)),
        ),
        const SizedBox(height: 12),
        // Google Play
        GestureDetector(
          onTap: UrlLauncherUtil.openPlayStore,
          child: Image.asset(AppAssets.googlePlay, height: 32,
              errorBuilder: (_, __, ___) => _Badge('Google Play')),
        ),
        const SizedBox(height: 8),
        // App Store
        GestureDetector(
          onTap: UrlLauncherUtil.openAppStore,
          child: Image.asset(AppAssets.appStore, height: 32,
              errorBuilder: (_, __, ___) => _Badge('App Store')),
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  const _Badge(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label,
          style: const TextStyle(color: AppColors.white, fontSize: 11)),
    );
  }
}
