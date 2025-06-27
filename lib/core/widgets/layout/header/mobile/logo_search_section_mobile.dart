import 'package:flutter/material.dart';
import 'package:fitkle/core/theme/app_text_styles.dart';
import 'package:fitkle/core/theme/app_colors.dart';
import 'package:fitkle/core/theme/dimens.dart';

class LogoSearchSectionMobile extends StatelessWidget {
  const LogoSearchSectionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final logoTitle = 'fitkle';
    final searchPageUrl = '/search';
    final notificationsPageUrl = '/notifications';
    

    return Padding(
      padding: EdgeInsets.only(
        right: Dimens.logoSearchIconRightPaddingMobile,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 👈 로고
          Text(logoTitle, style: AppTextStyles.logoTitleMobile),

          // 👉 아이콘 2개 (검색, 알람)
          Row(
            children: [
              _buildIcon(Icons.search, () {
                Navigator.pushNamed(context, searchPageUrl);
              }),
              _buildIcon(Icons.notifications_none, () {
                Navigator.pushNamed(context, notificationsPageUrl);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.only(left: Dimens.logoSearchIconLeftPaddingMobile),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Icon(icon, color: AppColors.gray, size: Dimens.logoSearchIconSizeMobile),
      ),
    );
  }
}
