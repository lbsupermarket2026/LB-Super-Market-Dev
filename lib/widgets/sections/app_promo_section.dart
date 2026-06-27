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
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 28),
      child: Row(
        children: [
          // Phone icon left
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.phone_android, color: AppColors.primary, size: 40),
          ),
          const SizedBox(width: 24),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppStrings.promoHeadline1,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.white)),
                Text(AppStrings.promoHeadline2,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.secondary)),
                const SizedBox(height: 8),
                Text(AppStrings.promoSubtitle,
                    style: TextStyle(
                        fontSize: 13, color: Colors.white.withOpacity(0.65), height: 1.5)),
              ],
            ),
          ),

          const SizedBox(width: 24),

          // Right: QR then badges stacked
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Scan to Download',
                  style: TextStyle(fontSize: 11, color: Colors.white60)),
              const SizedBox(height: 8),
              Container(
                width: 80,
                height: 80,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(8)),
                child: Image.asset(AppAssets.qrCode,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.qr_code_2, size: 55, color: AppColors.dark)),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: UrlLauncherUtil.openPlayStore,
                child: Image.asset(AppAssets.googlePlay, height: 30,
                    errorBuilder: (_, __, ___) => _Badge('Google Play')),
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: UrlLauncherUtil.openAppStore,
                child: Image.asset(AppAssets.appStore, height: 30,
                    errorBuilder: (_, __, ___) => _Badge('App Store')),
              ),
            ],
          ),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Scan to Download',
            style: TextStyle(fontSize: 11, color: Colors.white60)),
        const SizedBox(height: 8),
        Container(
          width: 120,
          height: 120,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(AppAssets.qrCode,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.qr_code_2, size: 90, color: AppColors.dark)),
        ),
        const SizedBox(height: 14),
        GestureDetector(
          onTap: UrlLauncherUtil.openPlayStore,
          child: Image.asset(AppAssets.googlePlay, width: 130, height: 38,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => _Badge('Google Play')),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: UrlLauncherUtil.openAppStore,
          child: Image.asset(AppAssets.appStore, width: 130, height: 38,
              fit: BoxFit.contain,
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
