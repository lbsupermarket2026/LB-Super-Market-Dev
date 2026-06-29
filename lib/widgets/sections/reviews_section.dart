import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/breakpoints.dart';
import '../../data/review_data.dart';
import '../cards/review_card.dart';

class ReviewsSection extends StatefulWidget {
  const ReviewsSection({super.key});

  @override
  State<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  // Duplicate reviews for infinite loop effect
  List get _items => [
        ...ReviewData.reviews,
        ...ReviewData.reviews,
        ...ReviewData.reviews,
      ];

  int get _initialPage => ReviewData.reviews.length;

  @override
  void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    setState(() {
      _pageController = PageController(
        initialPage: _initialPage,
        viewportFraction: isMobile ? 0.88 : 0.28,
      );
      _currentPage = _initialPage;
    });
    _startTimer();
  });
}

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
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

    // Seamlessly jump without animation when hitting edges
    final len = ReviewData.reviews.length;
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

  int get _dotIndex => (_currentPage - ReviewData.reviews.length) %
      ReviewData.reviews.length;

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
      color: const Color(0xFFF5F5F5),
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
            width: 120,
            height: 3,
            color: AppColors.secondary,
          ),

          // Carousel with arrows
          Row(
            children: [
              _ArrowBtn(icon: Icons.chevron_left, onTap: _prev),

              Expanded(
                  child: SizedBox(
                    height: 220,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _items.length,
                      onPageChanged: _onPageChanged,
                      itemBuilder: (_, i) => Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width < 600 ? 4 : 8,
                        ),
                        child: ReviewCard(review: _items[i]),
                      ),
                    ),
                  ),
                ),

              _ArrowBtn(icon: Icons.chevron_right, onTap: _next),
            ],
          ),


          const SizedBox(height: 20),

          // Dot indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              ReviewData.reviews.length,
              (i) => GestureDetector(
                onTap: () {
                  _timer.cancel();
                  final target = ReviewData.reviews.length + i;
                  _pageController.animateToPage(
                    target,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                  _startTimer();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _dotIndex == i ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _dotIndex == i
                        ? AppColors.secondary
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
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