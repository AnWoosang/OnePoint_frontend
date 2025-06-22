import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';

class RecommendedKeywords extends StatelessWidget {
  final List<String> keywords;

  const RecommendedKeywords({
    super.key,
    required this.keywords,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('추천 키워드', style: AppTextStyles.searchPageTitleStyleMobile),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: keywords.map((keyword) {
            return Chip(
              backgroundColor: Colors.white,
              label: Text(keyword, style: AppTextStyles.searchPageRecentWordStyleMobile),
              side: BorderSide(color: AppColors.gray),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
