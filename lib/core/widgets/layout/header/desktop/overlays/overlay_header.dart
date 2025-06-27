import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitkle/core/theme/app_colors.dart';
import 'package:fitkle/core/theme/app_text_styles.dart';
import 'package:fitkle/core/theme/dimens.dart';

class OverlayHeader extends StatelessWidget {
  final VoidCallback onDeleteAll;
  final int totalCount;

  const OverlayHeader({
    super.key,
    required this.onDeleteAll,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: '총 ', style: AppTextStyles.overlayHeaderText()),
              TextSpan(
                text: '$totalCount',
                style: AppTextStyles.overlayHeaderText(color: AppColors.primary),
              ),
              TextSpan(text: '개', style: AppTextStyles.overlayHeaderText()),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: onDeleteAll,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.gray,
            textStyle: AppTextStyles.overlayButtonText(),
            minimumSize: Size(10.w, 32.h),
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.overlayButtonPaddingHorizontal,
              vertical: Dimens.overlayButtonPaddingVertical,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide(color: AppColors.grayBorderLight),
            ),
            elevation: 1,
          ),
          child: const Text(
            '전체 삭제',
            textAlign: TextAlign.center,
            style: TextStyle(height: 1.2),
          ),
        ),
      ],
    );
  }
}
