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
        vertical: 32,
      ),
      child: Column(
        children: [
          Text(AppStrings.aboutTitle,
              style: Theme.of(context).textTheme.titleLarge),
          Container(
            margin: const EdgeInsets.only(top: 6, bottom: 20),
            width: 80,
            height: 3,
            color: AppColors.secondary,
          ),
          isMobile
              ? Column(
                  children: [
                    Image.asset(AppAssets.logo,
                        height: 100,
                        errorBuilder: (_, __, ___) => const Icon(
                            Icons.shopping_cart,
                            color: AppColors.primary,
                            size: 80)),
                    const SizedBox(height: 16),
                    Text(AppStrings.aboutBody,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(height: 1.8),
                        textAlign: TextAlign.center),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.logo,
                        height: 160,
                        errorBuilder: (_, __, ___) => const Icon(
                            Icons.shopping_cart,
                            color: AppColors.primary,
                            size: 100)),
                    const SizedBox(width: 48),
                    Expanded(
                      child: Text(AppStrings.aboutBody,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(height: 1.8, fontSize: 16)),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}