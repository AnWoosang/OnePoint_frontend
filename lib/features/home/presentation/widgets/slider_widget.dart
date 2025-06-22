import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:one_point/core/utils/responsive.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/core/theme/dimens.dart';

import 'package:one_point/features/home/data/models/home_product.dart';
import 'package:one_point/features/home/presentation/widgets/desktop/product_card_slider_desktop.dart';
import 'package:one_point/features/home/presentation/widgets/mobile/product_card_slider_mobile.dart';

class SliderWidget extends StatefulWidget {
  final String title;
  final List<Product> products;
  final InfiniteScrollController controller;
  final bool showNavigationButtons;
  final double horizontalPadding;

  const SliderWidget({
    super.key,
    required this.title,
    required this.products,
    required this.controller,
    this.showNavigationButtons = false,
    required this.horizontalPadding,
  });

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    final isCompact = Responsive.isMobile(context) || Responsive.isTablet(context);
    final isMobile = Responsive.isMobile(context);

    final double padding = widget.horizontalPadding ;

    // 👉 슬라이더 전체 높이
    final double sliderHeight = isCompact
        ? Dimens.sliderHeightCompact
        : Dimens.sliderHeightDesktop;

    // 👉 카드 너비 계산
    final double containerWidth = MediaQuery.of(context).size.width - (padding * 2);
    final double cardWidth = isMobile
        ? Dimens.sliderCardWidthMobile
        : (containerWidth - (Dimens.sliderBetweenCardGapDesktop * (Dimens.sliderCardVisibleCountDesktop - 1))) /
            Dimens.sliderCardVisibleCountDesktop;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Dimens.sliderSectionTitleSpacing),
        Text(widget.title, 
          style: isCompact
          ? AppTextStyles.sliderSectionTitleStyleMobile
          : AppTextStyles.sliderSectionTitleStyleDesktop,
        ),
        SizedBox(height: 16.h),

        SizedBox(
          height: sliderHeight,
          child: isMobile
              // ✅ 모바일은 가로 스크롤 + 카드 고정 너비
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: widget.products.asMap().entries.map((entry) {
                    final index = entry.key;
                    final product = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(
                        right: Dimens.sliderBetweenCardGapMobile,
                        left: index == 0 ? 0 : 0,
                      ),
                      child: ProductCardSliderMobile(product: product, width: cardWidth),
                    );
                  }).toList(),
                ),
              )

            // ✅ 데스크탑은 InfiniteCarousel + 카드 간격 + 높이 넘김
            : Container(
                height: sliderHeight,
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Stack(
                  children: [
                    InfiniteCarousel.builder(
                      itemCount: widget.products.length,
                      itemExtent: cardWidth,
                      controller: widget.controller,
                      center: true,
                      anchor: 0.0,
                      velocityFactor: 0.2,
                      axisDirection: Axis.horizontal,
                      loop: true,
                      itemBuilder: (context, itemIndex, realIndex) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimens.sliderBetweenCardGapDesktop,
                          ),
                          child: ProductCardSlider(
                            product: widget.products[itemIndex],
                            width: cardWidth,
                            height: sliderHeight, // ✅ 카드에 높이 전달
                          ),
                        );
                      },
                    ),
                    if (widget.showNavigationButtons) ...[
                      Positioned(
                        left: 0,
                        top: Dimens.sliderNavButtonTopOffset,
                        child: _navButton(Icons.arrow_back_ios_new, () {
                          widget.controller.previousItem();
                        }),
                      ),
                      Positioned(
                        right: 0,
                        top: Dimens.sliderNavButtonTopOffset,
                        child: _navButton(Icons.arrow_forward_ios, () {
                          widget.controller.nextItem();
                        }),
                      ),
                    ],
                  ],
                ),
              ),
        ),
      ],
    );
  }

  Widget _navButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: Dimens.sliderNavButtonWidth,
        height: Dimens.sliderNavButtonHeight,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray.withAlpha(40),
              blurRadius: 4.r,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 14.r, color: AppColors.black),
      ),
    );
  }
}
