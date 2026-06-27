import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/breakpoints.dart';
import '../../data/category_data.dart';
import '../cards/category_card.dart';
import '../../core/utils/url_launcher.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 48,
        vertical: 48,
      ),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppStrings.categoryTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextSpan(
                  text: AppStrings.categoryTitleAccent,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: AppColors.secondary),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 6, bottom: 32),
            width: 40,
            height: 3,
            color: AppColors.primary,
          ),

          // Use Row with Expanded so cards spread across full width
          isMobile
              ? SizedBox(
                  height: 225,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: CategoryData.categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, i) => CategoryCard(
                      category: CategoryData.categories[i],
                      onTap: () => UrlLauncherUtil.openPlayStore(),
                    ),
                  ),
                )
              : Row(
                  children: CategoryData.categories.map((cat) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: CategoryCard(
                          category: cat,
                          onTap: () => Navigator.pushNamed(context, '/catalog'),
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}