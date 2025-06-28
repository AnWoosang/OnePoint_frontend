import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.white,
  primaryColor: AppColors.grayLight,
  
  // 전역 폰트 설정 - 직접 추가한 Noto Sans KR
  fontFamily: 'NotoSansKR',
  textTheme: TextTheme(
    // 기본 텍스트 스타일들
    bodyLarge: TextStyle(
      fontSize: 14.sp, 
      fontWeight: FontWeight.w400,
      fontFamily: 'NotoSansKR',
    ),
    bodyMedium: TextStyle(
      fontSize: 13.sp, 
      fontWeight: FontWeight.w400,
      fontFamily: 'NotoSansKR',
    ),
    labelSmall: TextStyle(
      fontSize: 10.sp, 
      fontWeight: FontWeight.w500,
      fontFamily: 'NotoSansKR',
    ),
    // 제목 스타일들
    titleLarge: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      fontFamily: 'NotoSansKR',
    ),
    titleMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      fontFamily: 'NotoSansKR',
    ),
    titleSmall: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      fontFamily: 'NotoSansKR',
    ),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.white,
    elevation: 0,
    foregroundColor: AppColors.black,
    titleTextStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      fontFamily: 'NotoSansKR',
      color: AppColors.black,
    ),
  ),

  chipTheme: ChipThemeData(
    backgroundColor: AppColors.primary.withOpacity(0.1),
    labelStyle: TextStyle(
      fontSize: 12.sp,
      fontFamily: 'NotoSansKR',
      color: AppColors.black,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.r),
    ),
  ),

  dividerColor: AppColors.grayLight,
);
