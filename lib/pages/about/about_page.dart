import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_assets.dart';
import '../../core/responsive/breakpoints.dart';
import '../../widgets/common/navbar.dart';
import '../../widgets/common/footer.dart';
import '../../widgets/sections/reviews_section.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Scaffold(
      appBar: const Navbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Banner
            Container(
              width: double.infinity,
              color: AppColors.dark,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('About Us',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white)),
                  const SizedBox(height: 6),
                  Text('Your trusted neighborhood supermarket',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.7))),
                ],
              ),
            ),

            // About Body
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : 80, vertical: 48),
              child: isMobile
                  ? _AboutContent(isMobile: true)
                  : _AboutContent(isMobile: false),
            ),

            // Values Section
            _ValuesSection(),

            // Reviews
            const ReviewsSection(),

            const Footer(),
          ],
        ),
      ),
    );
  }
}

class _AboutContent extends StatelessWidget {
  final bool isMobile;
  const _AboutContent({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final logoWidget = Image.asset(AppAssets.logo, height: 140,
        errorBuilder: (_, __, ___) => const Icon(
              Icons.shopping_cart,
              color: AppColors.primary,
              size: 80,
            ));

    final textWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Who We Are',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppColors.primary)),
        const SizedBox(height: 12),
        Text(AppStrings.aboutBody,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(height: 1.8)),
        const SizedBox(height: 20),
        Text(
          'At Balaramayya Super Market, we believe every family deserves access to fresh, quality produce at prices that make sense. Founded with a passion for community, we\'ve been serving the families of Kukatpally with fresh products, everyday savings, and smiles.',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(height: 1.8),
        ),
      ],
    );

    return isMobile
        ? Column(children: [logoWidget, const SizedBox(height: 24), textWidget])
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              logoWidget,
              const SizedBox(width: 48),
              Expanded(child: textWidget),
            ],
          );
  }
}

class _ValuesSection extends StatelessWidget {
  static const _values = [
    (Icons.eco_outlined, 'Fresh & Natural',
        'We source directly from local farms to ensure peak freshness every day.'),
    (Icons.people_outline, 'Community First',
        'We are part of the community. Your trust drives everything we do.'),
    (Icons.savings_outlined, 'Affordable Prices',
        'Quality shouldn\'t cost a fortune. We work hard to keep prices low.'),
    (Icons.support_agent_outlined, 'Great Service',
        'Our friendly staff is always here to help you find what you need.'),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Container(
      color: const Color(0xFFF5F5F5),
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 80, vertical: 48),
      child: Column(
        children: [
          Text('Our Values',
              style: Theme.of(context).textTheme.titleLarge),
          Container(
            margin: const EdgeInsets.only(top: 6, bottom: 32),
            width: 40,
            height: 3,
            color: AppColors.secondary,
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 1 : 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: isMobile ? 3.5 : 3,
            children: _values
                .map((v) => _ValueCard(icon: v.$1, title: v.$2, body: v.$3))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ValueCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _ValueCard(
      {required this.icon, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark)),
                const SizedBox(height: 4),
                Text(body,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textGrey, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
