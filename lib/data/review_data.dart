import '../models/review_model.dart';

class ReviewData {
  static const List<ReviewModel> reviews = [
    ReviewModel(
      id: 'r001',
      customerName: 'Ramesh K.',
      reviewText:
          'Fresh products and great quality. Balaramayya Super Market is now my go-to store!',
      rating: 5,
    ),
    ReviewModel(
      id: 'r002',
      customerName: 'Anitha P.',
      reviewText:
          'Best supermarket in the area. Very friendly staff and reasonable prices.',
      rating: 5,
    ),
    ReviewModel(
      id: 'r003',
      customerName: 'Suresh V.',
      reviewText:
          'I love the app! Super easy to use and saves so much time.',
      rating: 4,
    ),
    ReviewModel(
      id: 'r004',
      customerName: 'Kavya M.',
      reviewText:
          'Wide variety and always fresh. Highly recommend!',
      rating: 5,
    ),
    ReviewModel(
      id: 'r005',
      customerName: 'Nagarjun T.',
      reviewText:
          'Great offers and fast delivery. Keep it up!',
      rating: 4,
    ),
  ];
}
