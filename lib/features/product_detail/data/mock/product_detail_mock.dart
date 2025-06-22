import 'package:one_point/features/product_detail/data/models/product_detail.dart';
import 'package:one_point/features/product_detail/data/models/product_category.dart';
import 'package:one_point/features/product_detail/data/models/seller_info.dart';
import 'package:one_point/features/product_detail/data/models/average_review_info.dart';
import 'package:one_point/features/product_detail/data/models/review.dart';
import 'package:one_point/features/product_detail/data/models/lowest_price_history.dart';

final mockProductDetails = <ProductDetail>[
  ProductDetail(
    id: 'p001',
    name: '[브랜드명] 군침싹 수박바 30ml',
    inhaleType: '입호흡',
    flavor: '수박',
    capacity: '30ml',
    thumbnailUrl: 'https://via.placeholder.com/300x300.png?text=수박바',
    productCategory: ProductCategory.liquid,
    totalViews: 324,
    totalFavorites: 87,
    averageReviewInfo: AverageReviewInfo(
      rating: 4.3,
      sweetness: 4.6,
      menthol: 3.2,
      throatHit: 2.1,
      body: 3.5,
      freshness: 4.0,
      totalReviewCount: 12,
    ),
    sellers: [
      SellerInfo(name: '베이프월드', price: 2900, shippingFee: 2500, url: 'https://vapeworld.com/001'),
      SellerInfo(name: '베이프월드', price: 1, shippingFee: 50000, url: 'https://vapeworld.com/001'),
      SellerInfo(name: '전자담배샵', price: 3100, shippingFee: 3000, url: 'https://ecigshop.com/001'),
      SellerInfo(name: '1', price: 2900, shippingFee: 2500, url: 'https://vapeworld.com/001'),
      SellerInfo(name: '2', price: 3100, shippingFee: 3000, url: 'https://ecigshop.com/001'),
      SellerInfo(name: '3', price: 2900, shippingFee: 2500, url: 'https://vapeworld.com/001'),
      SellerInfo(name: '4', price: 3100, shippingFee: 3000, url: 'https://ecigshop.com/001'),
      SellerInfo(name: '5', price: 2900, shippingFee: 2500, url: 'https://vapeworld.com/001'),
      SellerInfo(name: '6', price: 3100, shippingFee: 3000, url: 'https://ecigshop.com/001'),
      SellerInfo(name: '7', price: 2900, shippingFee: 2500, url: 'https://vapeworld.com/001'),
      SellerInfo(name: '8', price: 3100, shippingFee: 3000, url: 'https://ecigshop.com/001'),
    ],
    reviews: [
      Review(
        nickname: 'vape_lover',
        createdAt: DateTime.parse('2025-04-10T09:52:31.718505'),
        content: '달달하고 시원해요!',
        sweetness: 5,
        menthol: 4,
        throatHit: 2,
        body: 3,
        freshness: 4,
        imageUrls: [
          'https://via.placeholder.com/150x150.png?text=Review1',
          'https://via.placeholder.com/150x150.png?text=Review2',
        ],
      ),
      Review(
        nickname: 'mint_master',
        createdAt: DateTime.parse('2025-04-06T09:52:31.718513'),
        content: '멘솔 강해서 너무 좋아요',
        sweetness: 2,
        menthol: 5,
        throatHit: 3,
        body: 2,
        freshness: 5,
        imageUrls: [
          'https://via.placeholder.com/150x150.png?text=Review3',
        ],
      ),
    ],
    lowestPriceHistory: [
      LowestPriceHistory(
        date: DateTime.parse('2025-04-10T09:52:31.718584'),
        price: 3100,
      ),
      LowestPriceHistory(
        date: DateTime.parse('2025-04-11T09:52:31.718587'),
        price: 3000,
      ),
      LowestPriceHistory(
        date: DateTime.parse('2025-04-12T09:52:31.718588'),
        price: 2900,
      ),
    ],
  ),

  ProductDetail(
    id: 'p002',
    name: '시원한 민트 블라스트',
    inhaleType: '폐호흡',
    flavor: '민트',
    capacity: '60ml',
    thumbnailUrl: 'https://via.placeholder.com/300x300.png?text=민트블라스트',
    productCategory: ProductCategory.liquid,
    totalViews: 212,
    totalFavorites: 53,
    averageReviewInfo: AverageReviewInfo(
      rating: 4.8,
      sweetness: 3.5,
      menthol: 5.0,
      throatHit: 3.0,
      body: 2.5,
      freshness: 5.0,
      totalReviewCount: 9,
    ),
    sellers: [
      SellerInfo(name: '쿨베이퍼', price: 4200, shippingFee: 2000, url: 'https://coolvape.com/002'),
    ],
    reviews: [],
    lowestPriceHistory: [],
  ),

  ProductDetail(
    id: 'p003',
    name: '달콤한 딸기쉐이크',
    inhaleType: '입호흡',
    flavor: '딸기',
    capacity: '30ml',
    thumbnailUrl: 'https://via.placeholder.com/300x300.png?text=딸기쉐이크',
    productCategory: ProductCategory.liquid,
    totalViews: 150,
    totalFavorites: 65,
    averageReviewInfo: AverageReviewInfo(
      rating: 4.0,
      sweetness: 5.0,
      menthol: 2.0,
      throatHit: 1.5,
      body: 2.0,
      freshness: 3.5,
      totalReviewCount: 7,
    ),
    sellers: [
      SellerInfo(name: '베이프마켓', price: 3100, shippingFee: 2500, url: 'https://vapemarket.com/003'),
    ],
    reviews: [],
    lowestPriceHistory: [],
  ),

  ProductDetail(
    id: 'p004',
    name: '레몬 아이스팟',
    inhaleType: '폐호흡',
    flavor: '레몬',
    capacity: '30ml',
    thumbnailUrl: 'https://via.placeholder.com/300x300.png?text=레몬아이스',
    productCategory: ProductCategory.liquid,
    totalViews: 98,
    totalFavorites: 22,
    averageReviewInfo: AverageReviewInfo(
      rating: 3.8,
      sweetness: 3.0,
      menthol: 3.8,
      throatHit: 2.5,
      body: 2.2,
      freshness: 4.3,
      totalReviewCount: 3,
    ),
    sellers: [
      SellerInfo(name: '익스트림베이프', price: 2800, shippingFee: 2200, url: 'https://extremevape.com/004'),
    ],
    reviews: [],
    lowestPriceHistory: [],
  ),

  ProductDetail(
    id: 'p005',
    name: '클래식 담배맛',
    inhaleType: '입호흡',
    flavor: '담배',
    capacity: '30ml',
    thumbnailUrl: 'https://via.placeholder.com/300x300.png?text=클래식담배',
    productCategory: ProductCategory.liquid,
    totalViews: 410,
    totalFavorites: 102,
    averageReviewInfo: AverageReviewInfo(
      rating: 4.6,
      sweetness: 2.0,
      menthol: 1.0,
      throatHit: 4.5,
      body: 4.0,
      freshness: 1.2,
      totalReviewCount: 20,
    ),
    sellers: [
      SellerInfo(name: '담배베이퍼', price: 3300, shippingFee: 3000, url: 'https://tobaccovape.com/005'),
    ],
    reviews: [],
    lowestPriceHistory: [],
  ),
];

