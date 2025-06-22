import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';

class ReviewWriteSection extends StatefulWidget {
  const ReviewWriteSection({super.key});

  @override
  State<ReviewWriteSection> createState() => _ReviewWriteSectionState();
}

class _ReviewWriteSectionState extends State<ReviewWriteSection> {
  int overallRating = 0;
  final Map<String, int> detailRatings = {
    '단맛': 0,
    '멘솔': 0,
    '목긁음': 0,
    '바디감': 0,
    '상큼함': 0,
  };
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('리뷰 작성', style: AppTextStyles.reviewTextStyle.copyWith(fontSize: 6.sp)),
        SizedBox(height: 16.h),

        // 1. 전체 만족도
        _buildSectionBox(
          title: '1. 이 제품 어떠셨나요?',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (index) {
              final face = ['😡', '😕', '😐', '😊', '😍'][index];
              return GestureDetector(
                onTap: () {
                  setState(() => overallRating = index + 1);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: overallRating == index + 1 ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
                    border: Border.all(
                      color: overallRating == index + 1 ? AppColors.primary : AppColors.divider,
                    ),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(face, style: TextStyle(fontSize: 20.sp)),
                ),
              );
            }),
          ),
        ),

        SizedBox(height: 16.h),

        // 2. 세부 평가
        _buildSectionBox(
          title: '2. 세부 평가',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: detailRatings.entries.map((entry) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Row(
                  children: [
                    SizedBox(
                      width: 70.w,
                      child: Text(entry.key, style: AppTextStyles.reviewTextStyle),
                    ),
                    ...List.generate(5, (i) {
                      return GestureDetector(
                        onTap: () {
                          setState(() => detailRatings[entry.key] = i + 1);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          width: 18.w,
                          height: 18.w,
                          decoration: BoxDecoration(
                            color: (i + 1) <= entry.value ? AppColors.primary : AppColors.grayLighter,
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              );
            }).toList(),
          ),
        ),

        SizedBox(height: 16.h),

        // 3. 리뷰 작성 영역
        _buildSectionBox(
          title: '3. 리뷰 작성',
          child: TextField(
            controller: _controller,
            maxLength: 400,
            maxLines: 6,
            decoration: InputDecoration(
              hintText: '제품에 대한 사용 경험을 자유롭게 작성해주세요.',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.r)),
              contentPadding: EdgeInsets.all(12.w),
            ),
          ),
        ),

        SizedBox(height: 16.h),

        // 4. 등록 버튼
        _buildSectionBox(
          title: '4. 리뷰 등록',
          child: Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {
                // 등록 로직
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
              ),
              child: Text('리뷰 등록하고 1000P 받기', style: TextStyle(color: Colors.white, fontSize: 5.sp)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionBox({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.grayLighter.withOpacity(0.4),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.reviewTextStyle),
          SizedBox(height: 10.h),
          child,
        ],
      ),
    );
  }
}
