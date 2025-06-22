import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'dart:async';

import 'package:one_point/features/home/data/models/home_product.dart';
import 'package:one_point/core/widgets/layout/page_scaffold.dart';
import 'package:one_point/core/utils/responsive.dart';
import 'package:one_point/core/theme/dimens.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/features/home/presentation/widgets/slider_widget.dart';
import 'package:one_point/features/home/presentation/widgets/keyword_trend_widget.dart';
import 'package:one_point/features/home/presentation/widgets/brand_section_widget.dart';
import 'package:one_point/features/home/presentation/widgets/ad_banner_widget.dart';
import 'package:one_point/features/product_detail/data/mock/product_detail_mock.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Product> allProducts = mockProductDetails.map((detail) {
    return Product(
      id: detail.id,
      name: detail.name,
      price: detail.sellers.isNotEmpty ? detail.sellers.first.price : 0,
      imageUrl: detail.thumbnailUrl,
      productCategory: detail.productCategory,
      inhaleType: detail.inhaleType,
      flavor: detail.flavor,
      capacity: detail.capacity,
      totalViews: detail.totalViews,
      totalFavorites: detail.totalFavorites,
    );
  }).toList();


  final List<Product> bestSellerList = List.from([]);

  final List<String> popularKeywords = [
    '갈아먹구싶오', '군침싹 수박바', '멘솔', '연초맛', '피오부아', '디바이스 베이프',
  ]; //api 사용

  final List<String> popularBrands = [
    '월드베이프', '닥터베이프', '피오부아', '999', 'OM.G', '매드클라우드', '레드베어'
  ]; //api 사용

  String selectedCategory = '전체';
  late InfiniteScrollController recentPopularController;
  late InfiniteScrollController bestSellerController;
  Timer? _autoPlayTimer;
  Timer? _bestSellerTimer;

  @override
  void initState() {
    super.initState();
    recentPopularController = InfiniteScrollController();
    bestSellerController = InfiniteScrollController();

    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (recentPopularController.hasClients) {
        recentPopularController.nextItem();
      }
    });

    _bestSellerTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (bestSellerController.hasClients) {
        bestSellerController.nextItem();
      }
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _bestSellerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.getResponsiveHorizontalPadding(context);

    return PageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ 공통 패딩 적용된 콘텐츠 구역
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimens.elementVerticalGap),
                SliderWidget(
                  title: '🔥 꾸준히 사랑받는 베스트 셀러에요',
                  products: bestSellerList.isEmpty ? allProducts : bestSellerList,
                  controller: bestSellerController,
                  horizontalPadding: padding,
                  showNavigationButtons: true,
                ),
                SizedBox(height: Dimens.elementVerticalGap),
                SliderWidget(
                  title: '🔥 최근 인기있는 상품들을 모아봤어요',
                  products: allProducts,
                  controller: recentPopularController,
                  horizontalPadding: padding,
                  showNavigationButtons: true,
                ),
                SizedBox(height: Dimens.elementVerticalGap),
                KeywordTrendWidget(popularKeywords: popularKeywords),
                SizedBox(height: Dimens.elementVerticalGap),
                BrandSectionWidget(brands: popularBrands),
                SizedBox(height: Dimens.elementVerticalGap),
              ],
            ),
          ),
        Divider(
          color: AppColors.divider,
          thickness: Dimens.dividerThickness,
          height: Dimens.dividerHeight,
        ),
        Row(
          children: [
            Expanded(
              child: AdBannerWidget(
                size: AdBannerSize.leaderboard,
                imageUrl: 'https://via.placeholder.com/364x90.png?text=광고1',
              ),
            ),
            SizedBox(width: Dimens.adBannerSpacing),
            Expanded(
              child: AdBannerWidget(
                size: AdBannerSize.leaderboard,
                imageUrl: 'https://via.placeholder.com/364x90.png?text=광고2',
              ),
            ),
          ],
        ),
        ],
      ),
    );
  }
}
