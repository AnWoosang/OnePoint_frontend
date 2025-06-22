import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';

class RecentSearchSection extends StatelessWidget {
  final List<String> recentSearches;
  final VoidCallback onClearAll;
  final void Function(String) onRemove;

  const RecentSearchSection({
    super.key,
    required this.recentSearches,
    required this.onClearAll,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header + 모두 삭제
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('최근 검색어', style: AppTextStyles.searchPageTitleStyleMobile),
            TextButton(
              onPressed: onClearAll,
              child: Text(
                '모두 삭제',
                style: AppTextStyles.searchPageGraphStyleMobile.copyWith(
                  decoration: TextDecoration.underline,
                  color: AppColors.grayDark,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        recentSearches.isNotEmpty
            ? Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: recentSearches.map((search) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gray),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(search, style: AppTextStyles.searchPageRecentWordStyleMobile),
                  SizedBox(width: 4.w),
                  GestureDetector(
                    onTap: () => onRemove(search),
                    child: Icon(Icons.close, size: 16.w, color: AppColors.gray),
                  )
                ],
              ),
            );
          }).toList(),
        )
            : Center(child: Text('최근 검색어가 없습니다.', style: AppTextStyles.searchPageRecentWordStyleMobile)),
      ],
    );
  }
}
