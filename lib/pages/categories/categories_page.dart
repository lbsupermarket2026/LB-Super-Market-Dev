import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/responsive/breakpoints.dart';
import '../../data/category_data.dart';
import '../../core/utils/url_launcher.dart';
import '../../widgets/common/navbar.dart';
import '../../widgets/common/footer.dart';
import '../../widgets/cards/category_card.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  void _showQrDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Download Our App',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('Scan the QR code to download\nBalaramayya Super Market app',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey)),
            const SizedBox(height: 20),
            Container(
              width: 160,
              height: 160,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.qr_code_2, size: 130, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      UrlLauncherUtil.openPlayStore();
                    },
                    child: const Text('Google Play'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      UrlLauncherUtil.openAppStore();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Text('App Store'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Scaffold(
      appBar: const Navbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              color: AppColors.dark,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Shop by Category',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white)),
                  const SizedBox(height: 6),
                  Text('Browse all product categories',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.7))),
                ],
              ),
            ),

            // Categories Grid
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 48, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'All ',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        TextSpan(
                          text: 'Categories',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: AppColors.secondary),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 6, bottom: 28),
                    width: 40,
                    height: 3,
                    color: AppColors.primary,
                  ),

                  // Grid — all 18 categories, no scroll
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile ? 2 : 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: CategoryData.categories.length,
                    itemBuilder: (_, i) {
                      final cat = CategoryData.categories[i];
                      return CategoryCard(
                        category: cat,
                        onTap: () => Navigator.pushNamed(context, '/catalog'),
                      );
                    },
                  ),
                ],
              ),
            ),

            const Footer(),
          ],
        ),
      ),
    );
  }
}