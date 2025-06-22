import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/theme/app_text_styles.dart';

class TrendingKeywords extends StatelessWidget {
  final List<Map<String, dynamic>> trending;
  final String currentTime;

  const TrendingKeywords({
    super.key,
    required this.trending,
    required this.currentTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('급상승 검색어', style: AppTextStyles.searchPageTitleStyleMobile),
            Text(currentTime, style: AppTextStyles.searchPageGraphStyleMobile),
          ],
        ),
        SizedBox(height: 10.h),
        Column(
          children: List.generate(5, (i) {
            final first = trending[i];
            final second = trending[i + 5];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Row(
                children: [
                  _buildItem(i + 1, first['keyword'], first['status']),
                  SizedBox(width: 16.w),
                  _buildItem(i + 6, second['keyword'], second['status']),
                ],
              ),
            );
          }),
        )
      ],
    );
  }

  Widget _buildItem(int index, String keyword, String status) {
    Icon? icon;
    if (status == 'up') {
      icon = Icon(Icons.arrow_drop_up, color: Colors.red, size: 18.w);
    } else if (status == 'down') {
      icon = Icon(Icons.arrow_drop_down, color: Colors.blue, size: 18.w);
    }

    return Expanded(
      child: Row(
        children: [
          Text('$index', style: AppTextStyles.searchPageGraphStyleMobile),
          SizedBox(width: 4.w),
          Expanded(child: Text(keyword, style: AppTextStyles.searchPageGraphStyleMobile, overflow: TextOverflow.ellipsis)),
          if (icon != null) icon,
          if (status == 'new')
            Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: Text('NEW', style: AppTextStyles.searchPageGraphStyleMobile.copyWith(color: Colors.orange)),
            ),
        ],
      ),
    );
  }
}
