import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_assets.dart';
import '../../core/responsive/breakpoints.dart';
import '../../app/router.dart';
import '../../core/utils/url_launcher.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final arcSize = w * 0.32;
        final orangeSize = w * 0.14;

        return ClipRect(
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: isMobile ? 360 : 460),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF0F4E8), Color(0xFFEFF6D9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                // Green quarter-circle — always fits top-right
                Positioned(
                  top: -arcSize * 0.1,
                  right: -arcSize * 0.1,
                  child: Container(
                    width: arcSize,
                    height: arcSize,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(999),
                      ),
                    ),
                  ),
                ),

                // Orange circle — floats below the green arc
                Positioned(
                  top: arcSize * 0.65,
                  right: arcSize * 0.05,
                  child: Container(
                    width: orangeSize,
                    height: orangeSize,
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // Content
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : w * 0.06,
                    vertical: isMobile ? 32 : 48,
                  ),
                  child: isMobile ? _MobileLayout() : _DesktopLayout(),
                ),
              ],
            ),
          ),
        );
      },
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
        Center(
          child: Image.asset(
            AppAssets.heroBasket,
            fit: BoxFit.contain,
            height: 200,
            errorBuilder: (_, __, ___) => const SizedBox(height: 100),
          ),
        ),
        const SizedBox(height: 20),
        _HeroText(),
      ],
    );
  }
}

class _HeroText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.heroHeadline1,
          style: TextStyle(
            fontSize: isMobile ? 28 : 44,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
            height: 1.15,
          ),
        ),
        Text(
          AppStrings.heroHeadline2,
          style: TextStyle(
            fontSize: isMobile ? 28 : 44,
            fontWeight: FontWeight.w800,
            color: AppColors.secondary,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          AppStrings.heroSubtitle,
          style: TextStyle(
            fontSize: isMobile ? 13 : 15,
            color: const Color(0xFF555555),
            height: 1.7,
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _HeroBtn(
              label: AppStrings.heroBtnDownload,
              icon: Icons.phone_android_outlined,
              dark: false,
              onTap: UrlLauncherUtil.openPlayStore,
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool dark;
  final VoidCallback onTap;

  const _HeroBtn({
    required this.label,
    required this.icon,
    required this.dark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          decoration: BoxDecoration(
            color: dark ? AppColors.dark : AppColors.primary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: (dark ? AppColors.dark : AppColors.primary)
                    .withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14)),
              const SizedBox(width: 8),
              Icon(icon, color: Colors.white, size: 17),
            ],
          ),
        ),
      ),
    );
  }
}