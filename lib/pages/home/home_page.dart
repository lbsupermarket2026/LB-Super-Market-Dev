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
import '../../core/utils/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(),
      floatingActionButton: _WhatsAppFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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

class _WhatsAppFab extends StatefulWidget {
  @override
  State<_WhatsAppFab> createState() => _WhatsAppFabState();
}

class _WhatsAppFabState extends State<_WhatsAppFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnim,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTapDown: (_) => _controller.forward(),
          onTapUp: (_) {
            _controller.reverse();
            UrlLauncherUtil.openWhatsApp();
          },
          onTapCancel: () => _controller.reverse(),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF25D366),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF25D366).withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                'assets/icons/whatsapp.svg',
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
            ),
          ),
        ),
      );
  }
}