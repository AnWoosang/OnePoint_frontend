import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.white,
  primaryColor: AppColors.primary,
  fontFamily: 'Pretendard', // 통일된 폰트

  textTheme: TextTheme(
    bodyLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.normal),
    labelSmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.white,
    elevation: 0,
    foregroundColor: AppColors.black,
    titleTextStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
      fontFamily: 'Pretendard',
      color: AppColors.black,
    ),
  ),

  chipTheme: ChipThemeData(
    backgroundColor: AppColors.primary.withOpacity(0.1),
    labelStyle: TextStyle(
      fontSize: 12.sp,
      color: AppColors.black,
      fontFamily: 'Pretendard',
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.r),
    ),
  ),

  dividerColor: AppColors.grayLight,
);
