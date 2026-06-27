import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../app/router.dart';
import '../../core/utils/url_launcher.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isNarrow = w < 900;

    return Container(
      height: 68,
      decoration: BoxDecoration(
        color: AppColors.dark,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8)],
      ),
      padding: EdgeInsets.symmetric(horizontal: w > 1200 ? 60 : 24),
      child: Row(
        children: [
          // Logo
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRouter.home),
            child: Row(
              children: [
                Image.asset('assets/logos/bs_logo.png', height: 132,
                    errorBuilder: (_, __, ___) => Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text('BS',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('BALARAMAYYA',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                    letterSpacing: 1)),
                            Text('SUPER MARKET',
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 9,
                                    letterSpacing: 2)),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),

          const Spacer(),

          if (!isNarrow) ...[
            _NavLink('Home', AppRouter.home),
            _NavLink('Catalog', AppRouter.catalog),
            _NavLink('Offers', AppRouter.offers),
            _NavLink('About Us', AppRouter.about),
            _NavLink('Contact', AppRouter.contact),
            const SizedBox(width: 20),

            // Phone
            GestureDetector(
              onTap: UrlLauncherUtil.callPhone,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Row(
                  children: [
                    const Icon(Icons.phone_outlined, color: AppColors.primary, size: 16),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Call Us',
                            style: TextStyle(
                                fontSize: 9,
                                color: Colors.white.withOpacity(0.6),
                                letterSpacing: 0.5)),
                        const Text(AppStrings.phone,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),

            // CTA
            TextButton(
              onPressed: UrlLauncherUtil.openPlayStore,
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.phone_android, size: 15),
                  SizedBox(width: 6),
                  Text('Download App',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                ],
              ),
            ),
          ] else
            IconButton(
              icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 26),
              onPressed: () => _showMenu(context),
            ),
        ],
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.dark,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _MobileMenu(),
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
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, route),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isActive
                          ? AppColors.primary
                          : Colors.white.withOpacity(0.85))),
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: isActive ? 20 : 0,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final links = [
      ('Home', AppRouter.home),
      ('Catalog', AppRouter.catalog),
      ('Offers', AppRouter.offers),
      ('About Us', AppRouter.about),
      ('Contact', AppRouter.contact),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 16),
          ...links.map((l) => ListTile(
                dense: true,
                title: Text(l.$1,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
                trailing: const Icon(Icons.arrow_forward_ios,
                    color: Colors.white30, size: 14),
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
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              icon: const Icon(Icons.phone_android),
              label: const Text('Download App',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}