import 'package:flutter/material.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/core/theme/dimens.dart';

class ProductSearchCard extends StatelessWidget {
  final String title;
  final String price;
  final int imageFlex;
  final int textFlex;
  final double height;
  final double width;

  const ProductSearchCard({
    super.key,
    required this.title,
    required this.price,
    this.imageFlex = 5,
    this.textFlex = 6,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final imageRatio = imageFlex / (imageFlex + textFlex);
    final textRatio = textFlex / (imageFlex + textFlex);

    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.zero,
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔼 이미지 영역
          SizedBox(
            height: height * imageRatio,
            width: width,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.gray,
              ),
              child: Center(
                child: Icon(
                  Icons.image,
                  size: Dimens.overlayCardImageIconSize,
                  color: AppColors.white,
                ),
              ),
            ),
          ),

          // 🔽 텍스트 영역
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: Dimens.overlayCardTextLeftPadding,
                right: 8,
                top: Dimens.overlayCardInnerElementGap,
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.productNameStyleDesktop,
                    ),
                  ),
                  SizedBox(height: Dimens.overlayCardPriceSpacing),
                  Text(
                    '최저가: $price',
                    style: AppTextStyles.productPriceStyleDesktop,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
