import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/extensions/num_extensions.dart';
import 'app_colors.dart';

/// `.sp.clampDouble(min, max)` 으로 사용 가능
class AppTextStyles {
  static const defaultFontFamily = 'Pretendard'; //아이폰체

  static final alertDialogDesktop = TextStyle(
    fontSize: 14.sp.clampDouble(12, 16),
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily,
    color: AppColors.black,
  );

  // --------------------------------------------------
  // 🧭 Header / LogoSearchSection
  // --------------------------------------------------

  //Desktop
  static final logoTitleDesktop = TextStyle(
    fontSize: 32.sp.clampDouble(24, 36),
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily,
    color: AppColors.primary,
  );

  static final logoActionTextDesktop = TextStyle(
    fontSize: 13.sp.clampDouble(12, 14),
    color: AppColors.black,
    fontWeight: FontWeight.w500,
    fontFamily: defaultFontFamily,
  );

  static final logoSearchHintText = TextStyle(
    fontSize: 13.sp.clampDouble(11, 14),
    fontFamily: defaultFontFamily,
    color: AppColors.gray,
  );
  
  //Mobile
  static final logoTitleMobile = TextStyle(
    fontSize: 22.sp.clampDouble(18, 24),
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily,
    color: AppColors.primary,
  );

  static final logoActionTextCompact = TextStyle(
    fontSize: 12.sp.clampDouble(10, 13),
    color: AppColors.gray,
    fontFamily: defaultFontFamily,
  );

  static final logoSearchInputText = TextStyle(
    fontSize: 13.sp.clampDouble(11, 14),
    fontFamily: defaultFontFamily,
  );

  // --------------------------------------------------
  // 🧭 Header / HeaderLink
  // --------------------------------------------------

  static TextStyle headerLinkTextStyle({
    required bool isCompact,
    double? customFontSize,
    Color? color,
  }) {
    final fontSize = customFontSize ??
        (isCompact ? 12.sp.clampDouble(10, 13) : 13.sp.clampDouble(12, 14));

    return TextStyle(
      fontSize: fontSize,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.normal,
      color: color ?? AppColors.gray,
      decoration: TextDecoration.none,
    );
  }

  // --------------------------------------------------
  // 🧭 Header / CategoryBar
  // --------------------------------------------------

  static final categoryBarTextMobile = TextStyle(
    fontSize: 13.sp.clampDouble(11, 14),
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    fontFamily: defaultFontFamily,
  );

  static final categoryBarTextDesktop = TextStyle(
    fontSize: 15.sp.clampDouble(13, 16),
    fontWeight: FontWeight.w600,
    color: AppColors.black,
    fontFamily: defaultFontFamily,
  );

  // AppTextStyles에 추가해줘야 할 수 있음

  static TextStyle categoryBarGroupTitleDesktop = TextStyle(
    fontSize: 14.sp.clampDouble(12, 16),
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static final categoryBarGroupTextDesktop = TextStyle(
    fontSize: 13.sp.clampDouble(11, 15),
    fontWeight: FontWeight.w500,
    color: AppColors.black,
    fontFamily: defaultFontFamily,
  );


  // ✅ Header / TopMenu

  static final topMenuDividerStyle = TextStyle(
    fontSize: 11.sp.clampDouble(10, 13),
    color: AppColors.grayLight,
    fontFamily: defaultFontFamily,
  );

  // --------------------------------------------------
  // 🏠 Home / Slider Title
  // --------------------------------------------------

  static TextStyle sliderSectionTitleStyleMobile = TextStyle(
    fontSize: 14.sp.clampDouble(12, 16),
    fontWeight: FontWeight.bold,
    fontFamily: defaultFontFamily,
    color: AppColors.textHeading,
  );

  static TextStyle sliderSectionTitleStyleDesktop = TextStyle(
    fontSize: 16.sp.clampDouble(14, 18),
    fontWeight: FontWeight.w600,
    fontFamily: defaultFontFamily,
    color: AppColors.textHeading,
  );


  // 🏠 Home / ProductCardSlider
  static TextStyle productNameStyleMobile = TextStyle(
    fontSize: 12.sp.clampDouble(11, 13),
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily,
  );

  static TextStyle productNameStyleDesktop = TextStyle(
    fontSize: 13.sp.clampDouble(12, 14),
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily,
  );

  static TextStyle productPriceStyleMobile = TextStyle(
    fontSize: 12.sp.clampDouble(11, 13),
    color: AppColors.red,
    fontWeight: FontWeight.w500,
    fontFamily: defaultFontFamily,
  );

static TextStyle productPriceStyleDesktop = TextStyle(
  fontSize: 13.sp.clampDouble(12, 14),
  color: AppColors.red,
  fontWeight: FontWeight.w500,
  fontFamily: defaultFontFamily,
);


  // 🏠 Home / KeywordTrendWidget

  static TextStyle keywordTrendTitleStyleMobile = TextStyle(
    fontSize: 14.sp.clampDouble(12, 16),
    fontWeight: FontWeight.bold,
    fontFamily: defaultFontFamily,
    color: AppColors.textHeading,
  );

  static TextStyle keywordTrendTitleStyleDesktop = TextStyle(
    fontSize: 16.sp.clampDouble(14, 18),
    fontWeight: FontWeight.bold,
    fontFamily: defaultFontFamily,
    color: AppColors.textHeading,
  );

  static TextStyle keywordChipTextStyleMobile = TextStyle(
    fontSize: 12.sp.clampDouble(10, 14),
    fontWeight: FontWeight.w500,
    color: AppColors.black,
    fontFamily: defaultFontFamily,
  );

  static TextStyle keywordChipTextStyleDesktop = TextStyle(
    fontSize: 14.sp.clampDouble(12, 16),
    fontWeight: FontWeight.w500,
    color: AppColors.black,
    fontFamily: defaultFontFamily,
  );

  // 🏠 Home / BrandSectionWidget

  static TextStyle brandTitleStyleMobile = TextStyle(
    fontSize: 14.sp.clampDouble(12, 16),
    fontWeight: FontWeight.bold,
    fontFamily: defaultFontFamily,
    color: AppColors.textHeading,
  );

  static TextStyle brandTitleStyleDesktop = TextStyle(
    fontSize: 16.sp.clampDouble(14, 18),
    fontWeight: FontWeight.bold,
    fontFamily: defaultFontFamily,
    color: AppColors.textHeading,
  );

  static TextStyle brandChipTextStyleMobile = TextStyle(
    fontSize: 12.sp.clampDouble(10, 14),
    fontWeight: FontWeight.w500,
    color: AppColors.black,
    fontFamily: defaultFontFamily,
  );

  static TextStyle brandChipTextStyleDesktop = TextStyle(
    fontSize: 14.sp.clampDouble(12, 16),
    fontWeight: FontWeight.w500,
    color: AppColors.black,
    fontFamily: defaultFontFamily,
  );

  // --------------------------------------------------
  // 🧩 Overlay / productOverLay
  // --------------------------------------------------

  static TextStyle overlayPaginationTextStyle(bool isActive) => TextStyle(
    fontSize: 12.sp.clampDouble(10, 14),
    fontWeight: FontWeight.bold,
    fontFamily: defaultFontFamily,
    color: isActive ? AppColors.white : AppColors.black,
  );

  // 🧩 Overlay / Header Text
  static TextStyle overlayHeaderText({Color color = AppColors.black}) => TextStyle(
    fontSize: 13.sp.clampDouble(12, 14),
    fontWeight: FontWeight.bold,
    fontFamily: defaultFontFamily,
    color: color,
  );

  // 🧩 Overlay / Title
  static TextStyle overlayTitleTextStyle() => TextStyle(
    fontSize: 13.sp.clampDouble(11, 15),
    fontWeight: FontWeight.w600,
    fontFamily: defaultFontFamily,
    color: AppColors.black,
  );

  // 🧩 Overlay / Button Text
  static TextStyle overlayButtonText() => TextStyle(
    fontSize: 10.sp.clampDouble(8, 12),
    fontWeight: FontWeight.bold,
    fontFamily: defaultFontFamily,
    color: AppColors.gray,
  );

  // --------------------------------------------------
  // 🧩 Overlay / ProductCardOverlay
  // -------------------------------------------------

  static final overlayCardTitleTextStyle = TextStyle(
    fontSize: 13.sp.clampDouble(12, 16),
    fontWeight: FontWeight.w500,
    fontFamily: defaultFontFamily,
    color: AppColors.black,
  );

  static final overlayCardPriceTextStyle = TextStyle(
    fontSize: 12.sp.clampDouble(11, 14),
    fontWeight: FontWeight.bold,
    fontFamily: defaultFontFamily,
    color: const Color.fromARGB(255, 232, 89, 78),
  );

  // --------------------------------------------------
  // 🧭 SearchPage
  // --------------------------------------------------

  // Mobile
  static TextStyle searchPageTitleStyleMobile = TextStyle(
    fontSize: 14.sp.clampDouble(12, 16),
    fontWeight: FontWeight.bold,
    fontFamily: defaultFontFamily,
    color: AppColors.textHeading,
  );

  static TextStyle searchPageRecentWordStyleMobile = TextStyle(
    fontSize: 12.sp.clampDouble(10, 14),
    fontFamily: defaultFontFamily,
    color: AppColors.gray,
  );

  static TextStyle searchPageGraphStyleMobile = TextStyle(
    fontSize: 10.sp.clampDouble(8, 12),
    fontWeight: FontWeight.bold,
    fontFamily: defaultFontFamily,
    color: AppColors.black,
  );

  // --------------------------------------------------
  // 🧭 ProductDetailPage
  // --------------------------------------------------

  static TextStyle productImageInfoTitleStyleDesktop = TextStyle(
    fontSize: 19.sp.clampDouble(17, 19),
    fontWeight: FontWeight.w600,
    fontFamily: defaultFontFamily,
  );

  static TextStyle productImageInfoTextStyleDesktop = TextStyle(
    fontSize: 15.sp.clampDouble(13, 17),
    fontWeight: FontWeight.w600,
    fontFamily: defaultFontFamily,
  );

  static TextStyle productPriceInfoTextStyleDesktop = TextStyle(
    fontSize: 10.sp.clampDouble(9, 11),
    color: AppColors.gray,
    fontWeight: FontWeight.w600,
    fontFamily: defaultFontFamily,
  );

  static TextStyle sellerBoxTextStyleDesktop = TextStyle(
    fontSize: 12.sp.clampDouble(11, 15),
    fontWeight: FontWeight.w600,
    fontFamily: defaultFontFamily,
  );


  // --------------------------------------------------
  // 🧭 ProductDetailPage / Review
  // --------------------------------------------------

  static TextStyle reviewAnalysisStyle = TextStyle(
    fontSize: 14.sp.clampDouble(13, 15),
    fontWeight: FontWeight.w600,
    fontFamily: defaultFontFamily,
  );

  static TextStyle reviewTextStyle = TextStyle(
    fontSize: 14.sp.clampDouble(13, 15),
    fontWeight: FontWeight.w600,
    fontFamily: defaultFontFamily,
  );

  // --------------------------------------------------
  // 🧭 Footer
  // --------------------------------------------------

  static TextStyle footerInfoStyle(bool isCompact) => TextStyle(
    fontSize: isCompact ? 11.sp.clampDouble(10, 12) : 12.sp.clampDouble(11, 13),
    color: AppColors.grayDark,
    fontFamily: defaultFontFamily,
  );

  static TextStyle footerLinkStyle(bool isCompact) => TextStyle(
    fontSize: isCompact ? 12.sp.clampDouble(11, 13) : 13.sp.clampDouble(12, 14),
    color: AppColors.gray,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w500,
  );

  static TextStyle footerDividerStyle(bool isCompact) => TextStyle(
    fontSize: isCompact ? 12.sp.clampDouble(11, 13) : 13.sp.clampDouble(12, 14),
    color: AppColors.grayLight,
    fontFamily: defaultFontFamily,
  );
}