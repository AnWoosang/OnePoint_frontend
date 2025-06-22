import 'package:flutter/material.dart';
import 'package:one_point/core/utils/responsive.dart';
import 'package:one_point/core/theme/dimens.dart';
import 'header/desktop/top_menu.dart';
import 'header/logo_search_section.dart';
import 'header/category_bar.dart';
import 'package:one_point/core/theme/app_text_styles.dart';

class HeaderWidget extends StatefulWidget {
  final bool isApp;

  const HeaderWidget({
    super.key,
    required this.isApp,
  });

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String _selectedTab = '홈';

  void _handleTabSelect(String label) {
    setState(() {
      _selectedTab = label;
    });
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.getResponsiveHorizontalPadding(context);
    bool isApp = widget.isApp;

    final verticalSpacing = isApp
        ? Dimens.headerVerticalSpacingMobile
        : Dimens.headerVerticalSpacingDesktop;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
      child: Row(
        children: [
          // 로고
          GestureDetector(
            onTap: () {
              // TODO: 홈으로 이동
            },
            child: Text('one_point', style: AppTextStyles.logoTitleDesktop),
          ),
          const SizedBox(width: 40),

          // 왼쪽 메뉴
          ...['견적요청', '고수찾기', '마켓', '커뮤니티'].map((label) => Padding(
            padding: const EdgeInsets.only(right: 24),
            child: GestureDetector(
              onTap: () {
                // TODO: 각 메뉴별 라우팅
              },
              child: Text(label, style: AppTextStyles.logoActionTextDesktop),
            ),
          )),

          // 왼쪽 끝과 오른쪽 끝 사이 공간
          Expanded(child: Container()),

          // 오른쪽 메뉴
          ...['로그인', '회원가입', '튜터등록'].map((label) => Padding(
            padding: const EdgeInsets.only(left: 24),
            child: GestureDetector(
              onTap: () {
                // TODO: 각 메뉴별 라우팅
              },
              child: Text(label, style: AppTextStyles.logoActionTextDesktop),
            ),
          )),
        ],
      ),
    );
  }
}