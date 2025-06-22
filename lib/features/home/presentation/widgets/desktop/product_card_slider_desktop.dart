import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart'; // 👈 라우팅 추가
import 'package:one_point/core/theme/dimens.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/core/router/route_names.dart';
import 'package:one_point/features/home/data/models/home_product.dart';

class ProductCardSlider extends StatelessWidget {
  final Product product;
  final double width;
  final double height;

  const ProductCardSlider({
    super.key,
    required this.product,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(RoutePaths.productDetail(product.id));
      },
      child: SizedBox(
        width: width,
        height: height,
        child: Card(
          elevation: 1,
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(color: AppColors.grayLighter),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 📸 이미지 (상단 55%)
              Expanded(
                flex: 55,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.grayLighter,
                    borderRadius: BorderRadius.circular(8.r),
                    image: DecorationImage(
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              // 📄 텍스트 영역 (하단 45%)
              Expanded(
                flex: 45,
                child: Padding(
                  padding: EdgeInsets.only(left: Dimens.sliderCardTextLeftPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: AppTextStyles.productNameStyleDesktop,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text('최저가: ', style: AppTextStyles.productPriceStyleDesktop),
                          Text(
                            product.formattedPrice,
                            style: AppTextStyles.productPriceStyleDesktop.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
