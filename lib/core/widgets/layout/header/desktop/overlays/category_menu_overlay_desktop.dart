import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/core/widgets/layout/header/model/category_group_model.dart';

class CategoryOverlayMenu extends StatelessWidget {
  final Offset position;
  final Size size;
  final List<CategoryGroup> categories;
  final void Function(String) onSelected;
  final VoidCallback onClose;

  const CategoryOverlayMenu({
    super.key,
    required this.position,
    required this.size,
    required this.categories,
    required this.onSelected,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy + size.height,
      child: Material(
        elevation: 0, // ✅ 그림자 제거
        borderRadius: BorderRadius.zero,
        child: Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: AppColors.divider,
              width: 1,
            ),
            borderRadius: BorderRadius.zero,
          ),
          child: IntrinsicHeight( // ✅ 내부 높이를 기준으로 divider 세로 길이 자동 조절
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < categories.length; i++) ...[
                  _buildCategoryColumn(categories[i]),
                  if (i != categories.length - 1)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Container(
                        width: 0.2.w,
                        color: AppColors.divider,
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryColumn(CategoryGroup group) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 👉 타이틀만 왼쪽 패딩
        Padding(
          padding: EdgeInsets.only(left: 2.w),
          child: Text(
            group.title,
            style: AppTextStyles.categoryBarGroupTitleDesktop,
          ),
        ),

        SizedBox(height: 4.h),

        // 👉 Divider는 패딩 없이 그대로 출력
        Container(
          width: 60.w,
          margin: EdgeInsets.only(top: 4.h, bottom: 8.h),
          height: 0.7.h,
          color: AppColors.divider,
        ),

        // 👉 카테고리 리스트들도 각각 왼쪽 패딩
        ...group.categories.map((name) {
          return InkWell(
            onTap: () {
              onSelected(name);
              onClose();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 2.w, top: 8.h, bottom: 6.h),
              child: Text(
                name,
                style: AppTextStyles.categoryBarGroupTextDesktop,
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}