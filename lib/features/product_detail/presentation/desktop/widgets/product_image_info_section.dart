import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/core/theme/dimens.dart';
import 'package:one_point/features/product_detail/data/models/product_detail.dart';

class ProductImageInfoSection extends StatefulWidget {
  final ProductDetail product;

  const ProductImageInfoSection({super.key, required this.product});

  @override
  State<ProductImageInfoSection> createState() => _ProductImageInfoSectionState();
}

class _ProductImageInfoSectionState extends State<ProductImageInfoSection> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final imageSize = 65.w;
    final product = widget.product;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Dimens.elementVerticalGap),

        // 🔹 상품 이미지
        ClipRRect(
          borderRadius: BorderRadius.circular(6.r),
          child: Image.network(
            product.thumbnailUrl,
            width: imageSize,
            height: imageSize,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: imageSize,
              height: imageSize,
              color: AppColors.grayLighter,
              alignment: Alignment.center,
              child: Icon(Icons.image_not_supported, size: imageSize, color: AppColors.gray),
            ),
          ),
        ),
        SizedBox(height: 20.h),

        Text(product.name, style: AppTextStyles.productImageInfoTitleStyleDesktop),
        SizedBox(height: 8.h),

        _buildSpecRow('호흡', product.inhaleType),
        _buildSpecRow('맛', product.flavor),
        _buildSpecRow('용량', product.capacity),
        _buildSpecRow('조회', '${product.totalViews}회'),
        _buildSpecRow('찜', '${product.totalFavorites}회'),

        SizedBox(height: 16.h),

        // 🔹 찜 수 + 버튼
        // 🔹 찜 수 + 버튼
        Row(
          mainAxisAlignment: MainAxisAlignment.end, // 👉 오른쪽 정렬
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.divider),
                borderRadius: BorderRadius.zero,
                color: AppColors.white,
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? AppColors.primary : AppColors.gray,
                  size: 5.w,
                ),
              ),
            ),
          ],
        ),

      ],
    );
  }

  Widget _buildSpecRow(String label, String value) {
    final isInhale = label == '호흡';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Flexible(
            flex: 5,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: AppTextStyles.productImageInfoTextStyleDesktop.copyWith(color: AppColors.gray),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: Align(
              alignment: Alignment.centerRight,
              child: isInhale
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: 4.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: value == '입호흡' ? Colors.blue : Colors.green,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          value,
                          style: AppTextStyles.productImageInfoTextStyleDesktop.copyWith(
                            color: Colors.white,
                            fontSize: 3.sp,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  )
                : Text(value, style: AppTextStyles.productImageInfoTextStyleDesktop),
            ),
          ),
        ],
      ),
    );
  }

}
