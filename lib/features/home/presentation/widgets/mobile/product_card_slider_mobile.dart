import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/features/home/data/models/home_product.dart';

class ProductCardSliderMobile extends StatelessWidget {
  final Product product;
  final double width;

  const ProductCardSliderMobile({super.key, required this.product, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📸 이미지
          AspectRatio(
            aspectRatio: 1,
            child: Container(
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

          // 📝 상품명
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.productNameStyleMobile,
          ),

          SizedBox(height: 4.h),

          // 💸 가격
          Text(
            product.formattedPrice,
            style: AppTextStyles.productPriceStyleMobile,
          ),

          // 💸 용량
          Text(
            '30ml',
            style: AppTextStyles.productNameStyleMobile,
          ),
        ],
      ),
    );
  }
}