class ProductModel {
  final String id;
  final String name;
  final String categoryId;
  final double price;
  final double? originalPrice;
  final String imagePath;
  final String unit;
  final bool isAvailable;

  const ProductModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.price,
    this.originalPrice,
    required this.imagePath,
    required this.unit,
    this.isAvailable = true,
  });

  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  double get discountPercent {
    if (!hasDiscount) return 0;
    return ((originalPrice! - price) / originalPrice! * 100).roundToDouble();
  }
}
