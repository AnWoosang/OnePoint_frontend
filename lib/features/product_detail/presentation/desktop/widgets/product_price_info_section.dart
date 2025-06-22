import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/core/utils/format.dart';
import 'package:one_point/features/product_detail/data/models/seller_info.dart';

class ProductPriceInfoSection extends StatelessWidget {
  final SellerInfo seller;
  final bool includeShipping;

  const ProductPriceInfoSection({
    super.key,
    required this.seller,
    required this.includeShipping,
  });

  @override
  Widget build(BuildContext context) {
    final totalPrice = seller.price + seller.shippingFee;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (includeShipping) // ✅ 조건부 렌더링
          Text(
            '배송비 포함',
            style: TextStyle(
              fontSize: 3.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.red,
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '최저 ${includeShipping ? formatPrice(totalPrice) : formatPrice(seller.price)}원',
              style: TextStyle(
                fontSize: 6.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.red,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // launchUrl(Uri.parse(seller.url));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: const Text('최저가 사러 가기'),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            Icon(Icons.local_shipping, size: 4.w, color: AppColors.gray),
            SizedBox(width: 1.w),
            Text(
              seller.shippingFee == 0 ? '무료' : '${formatPrice(seller.shippingFee)}원',
              style: AppTextStyles.productPriceInfoTextStyleDesktop,
            ),
            SizedBox(width: 1.w),
            Text('|', style: AppTextStyles.productPriceInfoTextStyleDesktop),
            SizedBox(width: 1.w),
            Text(seller.name, style: AppTextStyles.productPriceInfoTextStyleDesktop),
          ],
        ),
      ],
    );
  }
}
