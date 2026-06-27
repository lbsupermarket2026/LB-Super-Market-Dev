import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/breakpoints.dart';
import '../../data/review_data.dart';
import '../cards/review_card.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Container(
      color: const Color(0xFFF5F5F5),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 48,
        vertical: 48,
      ),
      child: Column(
        children: [
          // Title
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppStrings.reviewTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextSpan(
                  text: AppStrings.reviewTitleAccent,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: AppColors.secondary),
                ),
                TextSpan(
                  text: AppStrings.reviewTitleEnd,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 6, bottom: 32),
            width: 40,
            height: 3,
            color: AppColors.secondary,
          ),

          // Review Cards Carousel
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 700) {
                return Row(
                  children: ReviewData.reviews.map((r) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ReviewCard(review: r),
                    ),
                  )).toList(),
                );
              }
              return SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: ReviewData.reviews.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, i) => ReviewCard(review: ReviewData.reviews[i]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
