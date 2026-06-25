import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_assets.dart';
import '../../core/responsive/breakpoints.dart';
import '../../app/router.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';
import '../../core/utils/url_launcher.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 420),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF0F4E8), Color(0xFFEFF6D9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Green arc top-right
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 320,
              height: 320,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(320),
                ),
              ),
            ),
          ),

          // Orange arc mid-right
          Positioned(
            top: 200,
            right: 0,
            child: Container(
              width: 180,
              height: 180,
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(180),
                  bottomLeft: Radius.circular(180),
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 60,
              vertical: 48,
            ),
            child: isMobile
                ? _MobileLayout()
                : _DesktopLayout(),
          ),
        ],
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 5, child: _HeroText()),
        Expanded(
          flex: 4,
          child: Image.asset(
            AppAssets.heroBasket,
            fit: BoxFit.contain,
            height: 360,
            errorBuilder: (_, __, ___) => const SizedBox(height: 360),
          ),
        ),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          AppAssets.heroBasket,
          fit: BoxFit.contain,
          height: 220,
          errorBuilder: (_, __, ___) => const SizedBox(height: 100),
        ),
        const SizedBox(height: 16),
        _HeroText(),
      ],
    );
  }
}

class _HeroText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Main headline
        Text(
          AppStrings.heroHeadline1,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColors.textDark,
                fontSize: Breakpoints.isMobile(context) ? 30 : 44,
              ),
        ),
        Text(
          AppStrings.heroHeadline2,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColors.secondary,
                fontSize: Breakpoints.isMobile(context) ? 30 : 44,
              ),
        ),

        const SizedBox(height: 16),

        // Subtitle
        Text(
          AppStrings.heroSubtitle,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: AppColors.textGrey),
        ),

        const SizedBox(height: 28),

        // Action Buttons
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            PrimaryButton(
              label: AppStrings.heroBtnCatalog,
              onPressed: () =>
                  Navigator.pushNamed(context, AppRouter.catalog),
              icon: Icons.shopping_cart_outlined,
            ),
            SecondaryButton(
              label: AppStrings.heroBtnDownload,
              onPressed: UrlLauncherUtil.openPlayStore,
              icon: Icons.phone_android,
            ),
          ],
        ),
      ],
    );
  }
}
