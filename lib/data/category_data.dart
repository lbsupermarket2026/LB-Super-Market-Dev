import '../models/category_model.dart';
import '../core/constants/app_assets.dart';

class CategoryData {
  static const List<CategoryModel> categories = [
    CategoryModel(
      id: 'fruits_veg',
      name: 'Fruits &\nVegetables',
      imagePath: AppAssets.catFruitsVeg,
      route: '/catalog?category=fruits_veg',
    ),
    CategoryModel(
      id: 'dairy_eggs',
      name: 'Dairy &\nEggs',
      imagePath: AppAssets.catDairy,
      route: '/catalog?category=dairy_eggs',
    ),
    CategoryModel(
      id: 'bakery',
      name: 'Bakery',
      imagePath: AppAssets.catBakery,
      route: '/catalog?category=bakery',
    ),
    CategoryModel(
      id: 'beverages',
      name: 'Beverages',
      imagePath: AppAssets.catBeverages,
      route: '/catalog?category=beverages',
    ),
    CategoryModel(
      id: 'snacks',
      name: 'Snacks &\nMunchies',
      imagePath: AppAssets.catSnacks,
      route: '/catalog?category=snacks',
    ),
    CategoryModel(
      id: 'essentials',
      name: 'Daily\nEssentials',
      imagePath: AppAssets.catEssentials,
      route: '/catalog?category=essentials',
    ),
  ];
}
