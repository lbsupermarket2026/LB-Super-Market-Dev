import 'package:flutter/material.dart';
import '../pages/home/home_page.dart';
import '../pages/products/products_page.dart';
import '../pages/categories/categories_page.dart';
import '../pages/about/about_page.dart';
import '../pages/contact/contact_page.dart';

class AppRouter {
  static const String home = '/';
  static const String catalog = '/catalog';
  static const String offers = '/offers';
  static const String about = '/about';
  static const String contact = '/contact';

  static Map<String, WidgetBuilder> get routes => {
        home: (_) => const HomePage(),
        catalog: (_) => const ProductsPage(),
        offers: (_) => const CategoriesPage(),
        about: (_) => const AboutPage(),
        contact: (_) => const ContactPage(),
      };

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => const HomePage());
  }
}
