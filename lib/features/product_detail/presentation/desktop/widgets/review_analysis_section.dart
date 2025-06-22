import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/features/product_detail/data/models/average_review_info.dart';

class ReviewAnalysisSection extends StatelessWidget {
  final AverageReviewInfo average;

  const ReviewAnalysisSection({super.key, required this.average});

  @override
  Widget build(BuildContext context) {
    final categories = {
      '단맛': average.sweetness,
      '멘솔': average.menthol,
      '목긁음': average.throatHit,
      '바디감': average.body,
      '상큼함': average.freshness,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '리뷰 분석',
          style: TextStyle(
            fontSize: 6.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 10.h),

        // 평균 평점 + 별
        Row(
          children: [
            Text(
              '평균 평점 ${average.rating.toStringAsFixed(1)}',
              style: AppTextStyles.reviewAnalysisStyle,
            ),
            SizedBox(width: 8.w),
            Row(
              children: List.generate(5, (index) {
                final filled = index < average.rating.round();
                return Icon(
                  filled ? Icons.star : Icons.star_border,
                  size: 14.sp,
                  color: filled ? Colors.amber : AppColors.gray,
                );
              }),
            ),
          ],
        ),

        SizedBox(height: 20.h),

        // 세로 막대 그래프
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: categories.entries.map((entry) {
            return _buildVerticalBar(entry.key, entry.value);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildVerticalBar(String label, double value) {
    int filledCount = value.round(); // 0~5
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // 막대
        Column(
          children: List.generate(5, (i) {
            bool filled = 4 - i < filledCount;
            return Container(
              width: 10.w,
              height: 10.w,
              margin: EdgeInsets.symmetric(vertical: 2.h),
              decoration: BoxDecoration(
                color: filled ? AppColors.primary : AppColors.grayLighter,
                borderRadius: BorderRadius.circular(2.r),
              ),
            );
          }),
        ),
        SizedBox(height: 6.h),
        Text(label, style: AppTextStyles.reviewAnalysisStyle),
      ],
    );
  }
}
