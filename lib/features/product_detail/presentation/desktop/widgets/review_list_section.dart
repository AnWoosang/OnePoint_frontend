import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/features/product_detail/data/models/review.dart';

class ReviewListSection extends StatelessWidget {
  final List<Review> reviews;

  const ReviewListSection({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '리뷰 목록',
          style: AppTextStyles.reviewTextStyle.copyWith(fontSize: 6.sp),
        ),
        SizedBox(height: 12.h),

        ...reviews.map((review) => _buildReviewCard(review)).toList(),
      ],
    );
  }

  Widget _buildReviewCard(Review review) {
    final scoreMap = {
      '단맛': review.sweetness,
      '멘솔': review.menthol,
      '목긁음': review.throatHit,
      '바디감': review.body,
      '상큼함': review.freshness,
    };

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(6.r),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ 사용자 정보
          Row(
            children: [
              Icon(Icons.person, size: 14.w, color: AppColors.gray),
              SizedBox(width: 6.w),
              Text(review.nickname, style: AppTextStyles.reviewTextStyle),
              SizedBox(width: 10.w),
              Text(
                DateFormat('yyyy.MM.dd').format(review.createdAt),
                style: AppTextStyles.reviewTextStyle.copyWith(color: AppColors.gray, fontSize: 3.5.sp),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // ✅ 리뷰 평점 카드들
          Wrap(
            spacing: 8.w,
            runSpacing: 4.h,
            children: scoreMap.entries.map((e) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.grayLighter,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text('${e.key} ${e.value.toStringAsFixed(1)}',
                    style: AppTextStyles.reviewTextStyle.copyWith(fontSize: 4.sp)),
              );
            }).toList(),
          ),

          SizedBox(height: 10.h),

          // ✅ 리뷰 내용
          Text(review.content, style: AppTextStyles.reviewTextStyle.copyWith(fontSize: 4.5.sp)),
        ],
      ),
    );
  }
}
