import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/theme/app_colors.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;

  const SearchAppBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          // 👈 작게 만든 뒤로가기 버튼
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new, size: 16.w),
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),

          // 👉 버튼과 검색창 간격 좁힘
          SizedBox(width: 4.w),

          // 🔍 검색창
          Expanded(
            child: Container(
              height: 40.h,
              margin: EdgeInsets.only(right: 8.w),
              decoration: BoxDecoration(
                color: AppColors.grayLighter,
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: TextField(
                controller: controller,
                cursorColor: AppColors.primary,
                decoration: InputDecoration(
                  hintText: '검색어를 입력하세요...',
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  suffixIcon: Icon(Icons.search, color: AppColors.gray),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
