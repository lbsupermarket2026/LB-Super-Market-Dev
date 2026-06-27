import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_assets.dart';
import '../../core/responsive/breakpoints.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 48,
      ),
      child: Column(
        children: [
          // Title
          Text(AppStrings.aboutTitle,
              style: Theme.of(context).textTheme.titleLarge),
          Container(
            margin: const EdgeInsets.only(top: 6, bottom: 32),
            width: 40,
            height: 3,
            color: AppColors.secondary,
          ),

          // Logo + Text Row
          isMobile
              ? Column(
                  children: [_Logo(), const SizedBox(height: 20), _AboutText()],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _Logo(),
                    const SizedBox(width: 48),
                    Expanded(child: _AboutText()),
                  ],
                ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.logo,
      height: 160,
      errorBuilder: (_, __, ___) => Column(
        children: const [
          Icon(Icons.shopping_cart, color: AppColors.primary, size: 80),
          SizedBox(height: 8),
          Text(AppStrings.logoText,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: AppColors.textDark)),
        ],
      ),
    );
  }
}

class _AboutText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.aboutBody,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.8, fontSize: 16),
      textAlign: TextAlign.justify,
    );
  }
}
