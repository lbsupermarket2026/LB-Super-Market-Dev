import 'package:flutter/material.dart';
import '../../widgets/common/navbar.dart';
import '../../widgets/common/footer.dart';
import '../../widgets/sections/hero_section.dart';
import '../../widgets/sections/features_bar.dart';
import '../../widgets/sections/category_section.dart';
import '../../widgets/sections/app_promo_section.dart';
import '../../widgets/sections/about_section.dart';
import '../../widgets/sections/reviews_section.dart';
import '../../widgets/sections/contact_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HeroSection(),
            FeaturesBar(),
            CategorySection(),
            AppPromoSection(),
            AboutSection(),
            ReviewsSection(),
            ContactSection(),
            Footer(),
          ],
        ),
      ),
    );
  }
}
