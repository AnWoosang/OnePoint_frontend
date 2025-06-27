import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitkle/core/theme/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Responsive {
  // ✅ 화면 너비 기준 분기

  static bool isMobile(BuildContext context) => ScreenUtil().screenWidth < 600;
  static bool isTablet(BuildContext context) => ScreenUtil().screenWidth >= 600 && ScreenUtil().screenWidth < 1024;
  static bool isDesktop(BuildContext context) => ScreenUtil().screenWidth >= 1024;

  static bool isApp(BuildContext context) => !kIsWeb;

  // ✅ 패딩 분기 처리
  static double getResponsiveHorizontalPadding(BuildContext context) {
    if (isMobile(context)) {
      return Dimens.leftHorizontalPaddingMobile;
    } else {
      return Dimens.getResponsiveHorizontalPadding(context);
    }
  }

  // ✅ 슬라이더 등에서 카드 하나당 item 크기 계산
  static double getResponsiveItemWidth({
    required BuildContext context,
    required double totalPadding,
    required int columns,
    required double gap,
  }) {
    final screenWidth = ScreenUtil().screenWidth;
    final contentWidth = screenWidth - totalPadding * 2;
    final totalGap = gap * (columns - 1);
    return (contentWidth - totalGap) / columns;
  }

  // ✅ 카드 개수 분기 (예: 홈 슬라이더)
  static int getResponsiveCardCount(BuildContext context) {
    final width = ScreenUtil().screenWidth;
    if (width >= 1440) return 5;
    if (width >= 1024) return 4;
    if (width >= 768) return 3;
    return 2;
  }
}