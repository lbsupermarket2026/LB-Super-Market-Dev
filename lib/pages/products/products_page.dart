import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/responsive/breakpoints.dart';
import '../../data/product_data.dart';
import '../../widgets/common/navbar.dart';
import '../../widgets/common/footer.dart';
import '../../widgets/cards/product_card.dart';
import '../../data/category_data.dart';
import '../../core/utils/url_launcher.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String _selectedCategory = 'all';
  String _searchQuery = '';
  final TextEditingController _searchCtrl = TextEditingController();

  List get _filteredProducts {
    var products = _selectedCategory == 'all'
        ? ProductData.products
        : ProductData.byCategory(_selectedCategory);

    if (_searchQuery.isNotEmpty) {
      products = products
          .where((p) =>
              p.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
    return products;
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Scaffold(
      appBar: const Navbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Header
            _PageHeader(),

            // Search + Filter
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 80,
                vertical: 60,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: CategoryData.categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 2 : 4,
                  crossAxisSpacing: 28,
                  mainAxisSpacing: 28,
                  childAspectRatio: .95,
                ),
                itemBuilder: (_, index) {
                  final cat = CategoryData.categories[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      UrlLauncherUtil.openPlayStore();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 16,
                            color: Colors.black.withOpacity(.06),
                            offset: const Offset(0, 6),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 120,
                              child: Image.asset(
                                cat.imagePath,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 22),
                            Text(
                              cat.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const Footer(),
          ],
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 50 : 70,
      ),
      color: const Color(0xffF8F9FB),
      child: Column(
        children: [
          Text(
            "Our Categories",
            style: TextStyle(
              fontSize: isMobile ? 30 : 42,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: 80,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Browse all our grocery categories",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.divider),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected ? AppColors.white : AppColors.textGrey,
          ),
        ),
      ),
    );
  }
}
