import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/breakpoints.dart';
import '../../data/category_data.dart';
import '../cards/category_card.dart';

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
          // Section Title
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

          // Green underline accent
          Container(
            margin: const EdgeInsets.only(top: 6, bottom: 32),
            width: 40,
            height: 3,
            color: AppColors.primary,
          ),

          // Category Cards
          SizedBox(
            height: 210,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(bottom: 4),
              itemCount: CategoryData.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final cat = CategoryData.categories[index];
                return CategoryCard(
                  category: cat,
                  onTap: () => Navigator.pushNamed(context, '/catalog'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
