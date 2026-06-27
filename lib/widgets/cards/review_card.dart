import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../models/review_model.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quote Icon
          const Icon(
            Icons.format_quote,
            color: AppColors.primary,
            size: 28,
          ),

          const SizedBox(height: 8),

          // Review Text
          Text(
            review.reviewText,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textGrey,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 12),

          // Stars
          Row(
            children: List.generate(5, (i) {
              return Icon(
                i < review.rating.floor() ? Icons.star : Icons.star_border,
                color: AppColors.starYellow,
                size: 16,
              );
            }),
          ),

          const SizedBox(height: 8),

          // Customer Name
          Text(
            '– ${review.customerName}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
