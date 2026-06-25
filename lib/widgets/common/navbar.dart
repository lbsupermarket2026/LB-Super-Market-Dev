import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_assets.dart';
import '../../app/router.dart';
import '../buttons/secondary_button.dart';
import '../../core/utils/url_launcher.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 700;

    return Container(
      height: 70,
      color: AppColors.dark,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          // Logo
          _Logo(),

          const Spacer(),

          if (!isNarrow) ...[
            // Nav Links
            _NavLink(AppStrings.navHome, AppRouter.home),
            _NavLink(AppStrings.navCatalog, AppRouter.catalog),
            _NavLink(AppStrings.navOffers, AppRouter.offers),
            _NavLink(AppStrings.navAbout, AppRouter.about),
            _NavLink(AppStrings.navContact, AppRouter.contact),
            const SizedBox(width: 16),

            // Phone
            GestureDetector(
              onTap: UrlLauncherUtil.callPhone,
              child: Row(
                children: [
                  const Icon(Icons.phone, color: AppColors.white, size: 16),
                  const SizedBox(width: 6),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.navCallUs,
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white.withOpacity(0.7)),
                      ),
                      const Text(
                        AppStrings.phone,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),

            // Download App Button
            SecondaryButton(
              label: AppStrings.navDownloadApp,
              onPressed: UrlLauncherUtil.openPlayStore,
              icon: Icons.phone_android,
            ),
          ] else
            // Hamburger on narrow screens
            IconButton(
              icon: const Icon(Icons.menu, color: AppColors.white),
              onPressed: () => _showMobileMenu(context),
            ),
        ],
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.dark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const _MobileMenu(),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRouter.home),
      child: Row(
        children: [
          Image.asset(AppAssets.logo, height: 44,
              errorBuilder: (_, __, ___) => const Icon(
                    Icons.shopping_cart,
                    color: AppColors.primary,
                    size: 36,
                  )),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final String route;

  const _NavLink(this.label, this.route);

  @override
  Widget build(BuildContext context) {
    final current = ModalRoute.of(context)?.settings.name;
    final isActive = current == route;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? AppColors.primary : AppColors.white,
              ),
            ),
            if (isActive)
              Container(
                margin: const EdgeInsets.only(top: 3),
                height: 2,
                width: 20,
                color: AppColors.primary,
              ),
          ],
        ),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  const _MobileMenu();

  @override
  Widget build(BuildContext context) {
    final links = [
      (AppStrings.navHome, AppRouter.home),
      (AppStrings.navCatalog, AppRouter.catalog),
      (AppStrings.navOffers, AppRouter.offers),
      (AppStrings.navAbout, AppRouter.about),
      (AppStrings.navContact, AppRouter.contact),
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...links.map((l) => ListTile(
                title: Text(l.$1,
                    style: const TextStyle(color: AppColors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, l.$2);
                },
              )),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: UrlLauncherUtil.openPlayStore,
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary),
              icon: const Icon(Icons.phone_android),
              label: const Text(AppStrings.navDownloadApp),
            ),
          ),
        ],
      ),
    );
  }
}
