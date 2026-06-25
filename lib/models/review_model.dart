class ReviewModel {
  final String id;
  final String customerName;
  final String reviewText;
  final double rating;

  const ReviewModel({
    required this.id,
    required this.customerName,
    required this.reviewText,
    required this.rating,
  });
}
