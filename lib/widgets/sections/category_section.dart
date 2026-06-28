import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/breakpoints.dart';
import '../../data/category_data.dart';
import '../../core/utils/url_launcher.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  List get _items => [
        ...CategoryData.categories,
        ...CategoryData.categories,
        ...CategoryData.categories,
      ];

  int get _initialPage => CategoryData.categories.length;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _initialPage,
      viewportFraction: 0.21,
    );
    _currentPage = _initialPage;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted) return;
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  void _prev() {
    _timer.cancel();
    _pageController.animateToPage(
      _currentPage - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    _startTimer();
  }

  void _next() {
    _timer.cancel();
    _pageController.animateToPage(
      _currentPage + 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    _startTimer();
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
    final len = CategoryData.categories.length;
    if (index == 0) {
      Future.delayed(const Duration(milliseconds: 10), () {
        if (mounted) {
          _pageController.jumpToPage(len);
          setState(() => _currentPage = len);
        }
      });
    } else if (index == _items.length - 1) {
      Future.delayed(const Duration(milliseconds: 10), () {
        if (mounted) {
          _pageController.jumpToPage(len - 1);
          setState(() => _currentPage = len - 1);
        }
      });
    }
  }

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
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 48,
        vertical: 48,
      ),
      child: Column(
        children: [
          // Title
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
          Container(
            margin: const EdgeInsets.only(top: 6, bottom: 32),
            width: 100,
            height: 3,
            color: AppColors.primary,
          ),

          // Carousel with arrows
          Row(
            children: [
              _ArrowBtn(icon: Icons.chevron_left, onTap: _prev),

              Expanded(
                child: SizedBox(
                  height: 260,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _items.length,
                    onPageChanged: _onPageChanged,
                    itemBuilder: (_, i) {
                      final cat = _items[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: GestureDetector(
                          onTap: () => Breakpoints.isDesktop(context)
                              ? _showQrDialog(context)
                              : UrlLauncherUtil.openPlayStore(),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                    child: Image.asset(
                                      cat.imagePath,
                                      width: double.infinity,
                                      height: 140,
                                      fit: BoxFit.contain,
                                      errorBuilder: (_, __, ___) => Container(
                                        height: 140,
                                        color: AppColors.background,
                                        child: const Icon(
                                            Icons.shopping_basket_outlined,
                                            color: AppColors.primary,
                                            size: 40),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    child: Text(
                                      cat.name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textDark,
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                      color: AppColors.dark,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.arrow_forward,
                                        color: AppColors.white, size: 15),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              _ArrowBtn(icon: Icons.chevron_right, onTap: _next),
            ],
          ),
        ],
      ),
    );
  }
}

class _ArrowBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ArrowBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: AppColors.textDark, size: 22),
        ),
      ),
    );
  }
}