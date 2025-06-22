// 상품 상세페이지 상위
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/theme/dimens.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/utils/responsive.dart';
import 'package:one_point/core/widgets/layout/page_scaffold.dart';
import 'package:one_point/features/product_detail/data/models/product_detail.dart';
import 'package:one_point/features/product_detail/data/models/seller_info.dart';

import 'widgets/product_image_info_section.dart';
import 'widgets/product_price_graph_section.dart';
import 'widgets/product_price_info_section.dart';
import 'widgets/seller_table_section.dart';
import 'widgets/review_analysis_section.dart';
import 'widgets/review_list_section.dart';
import 'widgets/review_write_section.dart';

class ProductDetailPageDesktop extends StatefulWidget {
  final ProductDetail product;

  const ProductDetailPageDesktop({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailPageDesktop> createState() => _ProductDetailPageDesktopState();
}

class _ProductDetailPageDesktopState extends State<ProductDetailPageDesktop> {
  bool includeShipping = true;

  List<SellerInfo> getSortedSellers() {
    final List<SellerInfo> sortedSellers = [...widget.product.sellers];
    if (includeShipping) {
      sortedSellers.sort((a, b) => (a.price + a.shippingFee).compareTo(b.price + b.shippingFee));
    } else {
      sortedSellers.sort((a, b) => a.price.compareTo(b.price));
    }
    return sortedSellers;
  }

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.getResponsiveHorizontalPadding(context);
    final product = widget.product;
    final sortedSellers = getSortedSellers();
    final lowestSeller = sortedSellers.first;

    return PageScaffold(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: Dimens.elementVerticalGap,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단 Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 좌측 3
                  Flexible(
                    flex: 3,
                    child: ProductImageInfoSection(product: product),
                  ),
                  // 👉 세로 Divider
                  Container(
                    width: 0.3.w,
                    height: 750.h,
                    color: AppColors.grayLighter,
                    margin: EdgeInsets.symmetric(horizontal: 7.w),
                  ),

                  /// 우측 7
                  Flexible(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimens.elementVerticalGap),
                        const ProductPriceGraphSection(),
                        SizedBox(height: 24.h),
                        ProductPriceInfoSection(
                          seller: lowestSeller,
                          includeShipping: includeShipping,
                        ),
                        SizedBox(height: 24.h),
                        SellerTableSection(
                          sellers: sortedSellers,
                          includeShipping: includeShipping,
                          onToggleIncludeShipping: (value) {
                            setState(() {
                              includeShipping = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // 리뷰 영역
              SizedBox(height: 100.h),
              ReviewAnalysisSection(
                average: product.averageReviewInfo
              ),
              SizedBox(height: 50.h),
              ReviewListSection(
                reviews: product.reviews,
              ),
              SizedBox(height: 24.h),
              const ReviewWriteSection(),
            ],
          ),
        ),
      ),
    );
  }
}
