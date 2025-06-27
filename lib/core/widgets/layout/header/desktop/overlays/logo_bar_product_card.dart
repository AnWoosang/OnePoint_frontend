import 'package:flutter/material.dart';
import 'package:fitkle/core/theme/app_colors.dart';
import 'package:fitkle/core/theme/dimens.dart';
import 'package:fitkle/core/theme/app_text_styles.dart';

class ProductCardOverlay extends StatelessWidget {
  final String title;
  final String price;
  final VoidCallback onDelete;

  /// 비율 설정
  final int imageFlex;
  final int textFlex;

  const ProductCardOverlay({
    super.key,
    required this.title,
    required this.price,
    required this.onDelete,
    this.imageFlex = 5,
    this.textFlex = 6,
  });

  @override
  Widget build(BuildContext context) {
    final cardHeight = Dimens.overlayCardHeight;

    return SizedBox(
      height: cardHeight,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              // ✅ 테두리 제거
              borderRadius: BorderRadius.zero,
              color: AppColors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ 이미지
                Expanded(
                  flex: imageFlex,
                  child: Container(
                    width: double.infinity,
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
                SizedBox(height: Dimens.overlayCardInnerElementGap),
                // ✅ 텍스트
                Expanded(
                  flex: textFlex,
                  child: Padding(
                    padding: EdgeInsets.only(left: Dimens.overlayCardTextLeftPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.productNameStyleDesktop,
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
          ),

          // ✅ 삭제 버튼
          Positioned(
            top: 4,
            right: 4,
            child: MouseRegion( // 🔥 추가된 부분
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: onDelete,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                  child: Icon(
                    Icons.close,
                    size: Dimens.overlayCardDeleteIconSize,
                    color: AppColors.gray,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
