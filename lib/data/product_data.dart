import '../models/product_model.dart';
import '../core/constants/app_assets.dart';

class ProductData {
  static const List<ProductModel> products = [
    // Fruits & Vegetables
    ProductModel(
      id: 'p001',
      name: 'Fresh Tomatoes',
      categoryId: 'fruits_veg',
      price: 40,
      originalPrice: 60,
      imagePath: AppAssets.catFruitsVeg,
      unit: '1 kg',
    ),
    ProductModel(
      id: 'p002',
      name: 'Bananas',
      categoryId: 'fruits_veg',
      price: 35,
      imagePath: AppAssets.catFruitsVeg,
      unit: '1 dozen',
    ),
    ProductModel(
      id: 'p003',
      name: 'Bell Peppers',
      categoryId: 'fruits_veg',
      price: 80,
      originalPrice: 100,
      imagePath: AppAssets.catFruitsVeg,
      unit: '500 g',
    ),

    // Dairy & Eggs
    ProductModel(
      id: 'p004',
      name: 'Fresh Milk',
      categoryId: 'dairy_eggs',
      price: 58,
      imagePath: AppAssets.catDairy,
      unit: '1 litre',
    ),
    ProductModel(
      id: 'p005',
      name: 'Farm Eggs',
      categoryId: 'dairy_eggs',
      price: 90,
      imagePath: AppAssets.catDairy,
      unit: '12 eggs',
    ),
    ProductModel(
      id: 'p006',
      name: 'Paneer',
      categoryId: 'dairy_eggs',
      price: 120,
      originalPrice: 150,
      imagePath: AppAssets.catDairy,
      unit: '200 g',
    ),

    // Bakery
    ProductModel(
      id: 'p007',
      name: 'Whole Wheat Bread',
      categoryId: 'bakery',
      price: 45,
      imagePath: AppAssets.catBakery,
      unit: '400 g',
    ),
    ProductModel(
      id: 'p008',
      name: 'Butter Croissant',
      categoryId: 'bakery',
      price: 30,
      imagePath: AppAssets.catBakery,
      unit: '2 pieces',
    ),

    // Beverages
    ProductModel(
      id: 'p009',
      name: 'Orange Juice',
      categoryId: 'beverages',
      price: 120,
      originalPrice: 150,
      imagePath: AppAssets.catBeverages,
      unit: '1 litre',
    ),
    ProductModel(
      id: 'p010',
      name: 'Mineral Water',
      categoryId: 'beverages',
      price: 20,
      imagePath: AppAssets.catBeverages,
      unit: '1 litre',
    ),

    // Snacks
    ProductModel(
      id: 'p011',
      name: 'Mixed Nuts',
      categoryId: 'snacks',
      price: 199,
      originalPrice: 249,
      imagePath: AppAssets.catSnacks,
      unit: '250 g',
    ),
    ProductModel(
      id: 'p012',
      name: 'Peanuts',
      categoryId: 'snacks',
      price: 60,
      imagePath: AppAssets.catSnacks,
      unit: '200 g',
    ),

    // Daily Essentials
    ProductModel(
      id: 'p013',
      name: 'Dish Wash Liquid',
      categoryId: 'essentials',
      price: 85,
      imagePath: AppAssets.catEssentials,
      unit: '500 ml',
    ),
    ProductModel(
      id: 'p014',
      name: 'Floor Cleaner',
      categoryId: 'essentials',
      price: 110,
      originalPrice: 130,
      imagePath: AppAssets.catEssentials,
      unit: '1 litre',
    ),
  ];

  static List<ProductModel> byCategory(String categoryId) =>
      products.where((p) => p.categoryId == categoryId).toList();
}
