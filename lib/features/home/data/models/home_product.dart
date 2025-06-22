import 'package:intl/intl.dart';
import 'package:one_point/features/product_detail/data/models/product_category.dart';

class Product {
  final String id;
  final String name;
  final int price;
  final String imageUrl;
  final ProductCategory productCategory;
  final String inhaleType;
  final String flavor;
  final String capacity;
  final int totalViews;
  final int totalFavorites;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.productCategory,
    required this.inhaleType,
    required this.flavor,
    required this.capacity,
    required this.totalViews,
    required this.totalFavorites,
  });

  // 💸 가격 포맷 getter
  String get formattedPrice => '${NumberFormat('#,###').format(price)}원';
}
