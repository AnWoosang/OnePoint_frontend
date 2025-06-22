import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';

class ProductPriceGraphSection extends StatelessWidget {
  const ProductPriceGraphSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.grayLighter,
      ),
      alignment: Alignment.center,
      child: Text('📈 가격 변동 그래프 영역', style: AppTextStyles.alertDialogDesktop),
    );
  }
}
