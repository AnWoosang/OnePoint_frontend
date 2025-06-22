import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/theme/dimens.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';

class CategoryBarMobile extends StatelessWidget {
  final double padding;
  final String selectedTab;
  final Function(String) onSelected;

  const CategoryBarMobile({
    super.key,
    required this.padding,
    required this.selectedTab,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final mobileTabs = ['홈', '랭킹', '브랜드', '이벤트', '공지'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        SizedBox(height: 8.h),
        Container(
          color: AppColors.white,
          padding: EdgeInsets.only(left: padding),
          child: Row(
            children: mobileTabs.asMap().entries.map((entry) {
              final index = entry.key;
              final label = entry.value;
              final isSelected = label == selectedTab;

              return Padding(
                padding: EdgeInsets.only(
                  left: padding,
                  right: index != mobileTabs.length - 1 ? Dimens.categoryBarItemSpacingMobile : 0,
                ),
                child: GestureDetector(
                  onTap: () => onSelected(label),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        style: AppTextStyles.categoryBarTextMobile.copyWith(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? AppColors.primaryDark : AppColors.gray,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      if (isSelected)
                        Container(
                          height: 2.h,
                          margin: EdgeInsets.only(top: 2.h),
                          color: AppColors.primaryDark,
                          width: 24.w,
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
