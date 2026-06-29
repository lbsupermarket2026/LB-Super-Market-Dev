import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/breakpoints.dart';
import '../cards/feature_card.dart';

class FeaturesBar extends StatelessWidget {
  const FeaturesBar({super.key});

  static const _features = [
    (Icons.verified_outlined, AppStrings.feat1Title, AppStrings.feat1Sub),
    (Icons.delivery_dining, AppStrings.feat2Title, AppStrings.feat2Sub),
    (Icons.local_offer_outlined, AppStrings.feat3Title, AppStrings.feat3Sub),
    (Icons.headset_mic_outlined, AppStrings.feat4Title, AppStrings.feat4Sub),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Container(
      color: AppColors.dark,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 48,
        vertical: isMobile ? 20 : 24,
      ),
      child: isMobile
          ? GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 3.0,
              children: _features
                  .map((f) => FeatureCard(icon: f.$1, title: f.$2, subtitle: f.$3))
                  .toList(),
            )
          : Row(
              children: _features.map((f) {
                final isLast = f == _features.last;
                return Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: FeatureCard(icon: f.$1, title: f.$2, subtitle: f.$3),
                      ),
                      if (!isLast)
                        Container(
                          width: 1,
                          height: 60,
                          color: Colors.white24,
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }
}