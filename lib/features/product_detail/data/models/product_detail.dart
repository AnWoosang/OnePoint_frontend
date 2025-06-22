import 'package:one_point/features/product_detail/data/models/average_review_info.dart';
import 'package:one_point/features/product_detail/data/models/product_category.dart';
import 'package:one_point/features/product_detail/data/models/review.dart';
import 'package:one_point/features/product_detail/data/models/seller_info.dart';
import 'package:one_point/features/product_detail/data/models/lowest_price_history.dart';

class ProductDetail {
  final String id;
  final String name;
  final String inhaleType;
  final String flavor;
  final String capacity;
  final String thumbnailUrl;
  final ProductCategory productCategory;
  final int totalViews;
  final int totalFavorites;

  final AverageReviewInfo averageReviewInfo;
  final List<SellerInfo> sellers;
  final List<Review> reviews; // ✅ 리뷰 리스트 추가
  final List<LowestPriceHistory> lowestPriceHistory;

  ProductDetail({
    required this.id,
    required this.name,
    required this.inhaleType,
    required this.flavor,
    required this.capacity,
    required this.thumbnailUrl,
    required this.productCategory,
    required this.sellers,
    required this.totalViews,
    required this.totalFavorites,
    required this.averageReviewInfo,
    required this.lowestPriceHistory,
    required this.reviews,
  });
}
