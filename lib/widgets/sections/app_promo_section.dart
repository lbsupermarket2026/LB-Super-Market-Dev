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
        vertical: 20,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 28,
        vertical: isMobile ? 18 : 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.darkBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: isMobile ? const _MobilePromo() : const _DesktopPromo(),
    );
  }
}

class _DesktopPromo extends StatelessWidget {
  const _DesktopPromo();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Phone icon
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.phone_android, color: AppColors.primary, size: 30),
        ),
        const SizedBox(width: 18),

        // Text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppStrings.promoHeadline1,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.white)),
              Text(AppStrings.promoHeadline2,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.secondary)),
              const SizedBox(height: 4),
              Text(AppStrings.promoSubtitle,
                  style: TextStyle(
                      fontSize: 12, color: Colors.white.withOpacity(0.60), height: 1.4)),
            ],
          ),
        ),

        const SizedBox(width: 24),

        // Inline download row: QR + store badges
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // QR code
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(AppAssets.qrCode,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.qr_code_2, size: 60, color: AppColors.dark)),
                ),
                const SizedBox(height: 5),
                Text('Scan to download',
                    style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.45))),
              ],
            ),

            const SizedBox(width: 14),

            // Store badges
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: UrlLauncherUtil.openPlayStore,
                  child: Image.asset(AppAssets.googlePlay,
                      width: 130, height: 40, fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const _Badge('Google Play')),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: UrlLauncherUtil.openAppStore,
                  child: Image.asset(AppAssets.appStore,
                      width: 130, height: 40, fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const _Badge('App Store')),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _MobilePromo extends StatelessWidget {
  const _MobilePromo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header row: icon + text
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.phone_android, color: AppColors.primary, size: 26),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.promoHeadline1,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.white)),
                  Text(AppStrings.promoHeadline2,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.secondary)),
                  const SizedBox(height: 3),
                  Text(AppStrings.promoSubtitle,
                      style: TextStyle(
                          fontSize: 11, color: Colors.white.withOpacity(0.60), height: 1.4)),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Inline download row: QR + badges, no box
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 68,
                  height: 68,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(AppAssets.qrCode,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.qr_code_2, size: 56, color: AppColors.dark)),
                ),
                const SizedBox(height: 4),
                Text('Scan to download',
                    style: TextStyle(fontSize: 9, color: Colors.white.withOpacity(0.45))),
              ],
            ),

            const SizedBox(width: 14),

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: UrlLauncherUtil.openPlayStore,
                  child: Image.asset(AppAssets.googlePlay,
                      width: 130, height: 38, fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const _Badge('Google Play')),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: UrlLauncherUtil.openAppStore,
                  child: Image.asset(AppAssets.appStore,
                      width: 130, height: 38, fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const _Badge('App Store')),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;

  const _Badge(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}