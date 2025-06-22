import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

/// 앱 전역 수치 기준 (폰트, 크기, 간격 등)
class Dimens {
  // --------------------------------------------------
  // 전역 설정 관련
  // --------------------------------------------------

  static final horizontalPaddingMobile = 24.w;
  static final leftHorizontalPaddingMobile = 12.w;
  static final horizontalPaddingDesktop = 48.w;
  static final elementVerticalGap = 17.h;

  static double getResponsiveHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1920) return 80.w; // 울트라 와이드
    if (width >= 1440) return 64.w;  // QHD 이상
    if (width >= 1200) return 48.w;  // 일반 데스크탑
    if (width >= 1024) return 48.w;  // 기본 패딩
    return 24.w; // 타블렛 이하
  }

  // --------------------------------------------------
  // 🧭 HeaderWidget 관련
  // --------------------------------------------------

  //Desktop

  //Mobile

  static final headerVerticalSpacingMobile = 4.h;


  static final headerTopMenuSpacingFactor = 0.7;
  static final headerMidSpacingFactor = 0.5;
  static final headerVerticalSpacingDesktop = 25.h;
  static final headerCategoryTopPadding = 10.h;

  // --------------------------------------------------
  // 🧭 Header / LogoSearchSection
  // --------------------------------------------------

  //Desktop
  static final logoActionIconSizeDesktop = 18.r;
  static final searchBarHeightDesktop = 40.h;
  static final logoSearchElementGap = 24.w;
  static final logoSearchItemGap = 4.w;
  static final searchBarIconPadding = 6.w;
  static final searchBarRadius = 20.r;
  static final searchBarInputLeftPadding = 8.w;
  static final searchBarInputVerticalPadding = 10.h;

  //Mobile
  static final logoSearchIconRightPaddingMobile = 15.w;
  static final logoSearchIconLeftPaddingMobile = 12.w;
  static final logoSearchIconSizeMobile = 20.w;


  // --------------------------------------------------
  // 🧭 Header / CategoryBar
  // --------------------------------------------------

  //Mobile 
  static final categoryBarItemSpacingMobile = 42.w;

  //Desktop
  static final categoryBarHeightDesktop = 48.h;

  static final categoryBarVerticalPaddingCompact = 8.h;
  static final categoryBarVerticalPaddingDesktop = 10.h;

  static final categoryBarItemSpacingCompact = 8.w;
  static final categoryBarItemSpacingDesktop = 10.w;

  static final categoryBarIconSizeCompact = 16.r;
  static final categoryBarIconSizeDesktop = 18.r;

  // --------------------------------------------------
  // 🧭 Header / TopMenu
  // --------------------------------------------------

  static final topMenuVerticalPaddingFactor = 0.25;

  // 🧩 Overlay / ProductOverlay
  static final double overlayHeight = 520.h;
  static final horizontalOverlayPadding = 48.w;
  static final double paginationButtonSize = 7.w;
  static final double overlayPadding = 6.w;
  static final overlayBorderRadius = 12.r;


  //전체삭제 버튼 
  static final double overlayButtonPaddingHorizontal = 4.w;
  static final double overlayButtonPaddingVertical = 8.h;

  //페이지 버튼
  static final double overlayPaginationButtonGap = 2.w;
  static final double overlayPaginationRadius = 4.r;
  static final double overlayElevation = 6.0; // elevation은 dp 기준 유지
  static final double overlayAnchorOffset = 12.h;

  

  // 🧩 Overlay / ProductCardOverlay
  //Desktop
  static final overlayCardSpacing = 10.w;
  static final double overlayCardTextLeftPadding = 2.w;
  static final overlayCardInnerElementGap = 10.h;

  static final overlayCardHeight = 320.h;
  static final double overlayCardImageIconSize = 36.r;
  static final double overlayCardDeleteIconSize = 14.r;
  static final double overlayCardTitleSpacing = 8.h;
  static final double overlayCardPriceSpacing = 4.h;

  // --------------------------------------------------
  // 🏠 Home / Slider Widget
  // --------------------------------------------------

  static final sliderHeightCompact = 250.h;
  static final sliderHeightDesktop = 250.h;
  static const double sliderWidgetBorderWidth = 1;
  static final sliderWidgetBorderPadding = 5.h;

  static final sliderBetweenCardGapDesktop = 0.5.w;
  static final sliderBetweenCardGapMobile = 10.w;
  static final sliderNavButtonTopOffset = 80.h;
  static final sliderNavButtonWidth = 8.w;
  static final sliderNavButtonHeight = 8.w;

  static final sliderVerticalSpacingDefault = 32.h;
  static final sliderSectionTitleSpacing = 12.h;

  // 🏠 Home / ProductCard
  static final sliderCardWidthMobile = 140.w;
  static final sliderCardTextLeftPadding = 1.7.w;
  static const int sliderCardVisibleCountDesktop = 5;
  static final sliderCardMarginHorizontal = 8.w;
  static final sliderCardMarginVertical = 12.h;
  static final sliderCardPadding = 12.w;
  static final sliderCardRadius = 12.r;
  static final sliderCardImageIconSize = 40.r;
  static final sliderCardTextSpacing = 8.h;

  // 🏠 Home / KeywordTrendWidget
  static final keywordTitleSpacing = 12.h;
  static final keywordChipSpacingCompact = 8.w;
  static final keywordChipSpacingDesktop = 4.w;
  static final keywordChipRunSpacingCompact = 4.h;
  static final keywordChipRunSpacingDesktop = 8.h;
  static final keywordChipRadius = 20.r;

  // 🏠 Home / BrandSectionWidget
  static final brandTitleSpacing = 12.h;
  static final brandChipSpacingCompact = 8.w;
  static final brandChipSpacingDesktop = 4.w;
  static final brandChipRunSpacingCompact = 4.h;
  static final brandChipRunSpacingDesktop = 8.h;
  static final brandChipRadius = 20.r;

  // 🏠 Home / AdBannerWidget
  static final adBannerRadius = 8.r;
  static final adBannerMarginVertical = 16.h;

  // 🏠 Home / HomeScreen
  static final homeVerticalSpacingDesktop = 24.h;
  static final homeVerticalSpacingMobile = 8.h;
  static final homeSliderItemGap = 16.w;
  static final adBannerSpacing = 16.w;
  static final dividerHeight = 48.h;
  static final dividerThickness = 1.h;

  // --------------------------------------------------
  // 🧭 Footer
  // --------------------------------------------------

  static final footerSectionGapCompact = 12.h;
  static final footerLinkSpacingCompact = 12.w;
  static final footerLinkSpacingDesktop = 2.w;
  static final footerDividerThickness = 1.h;
  static final footerVerticalSpacingDivider = 2.h;
  static final footerCopyrightSpacing = 4.h;
  static final footerLinkRunSpacing = 6.h;
}