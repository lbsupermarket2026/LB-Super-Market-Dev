import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 215,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Category Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                category.imagePath,
                width: 140,
                height: 110,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 140,
                  height: 110,
                  color: AppColors.background,
                  child: const Icon(Icons.image_not_supported, color: AppColors.textLight),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Category Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                  height: 1.3,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Arrow Button
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.dark,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: AppColors.white,
                size: 16,
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
