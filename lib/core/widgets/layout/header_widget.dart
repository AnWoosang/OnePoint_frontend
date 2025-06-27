import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:one_point/core/utils/responsive.dart';
import 'package:one_point/core/theme/dimens.dart';
import 'header/desktop/top_menu.dart';
import 'header/logo_search_section.dart';
import 'header/category_bar.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/core/widgets/login_modal.dart';

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
            child: SvgPicture.asset(
              'assets/logo/FITKLE.svg',
              height: 24, // 로고 높이 조절
            ),
          ),
          const SizedBox(width: 30),

          // 왼쪽 메뉴
          ...['견적요청', '고수찾기', '마켓', '커뮤니티'].map((label) => Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                // TODO: 각 메뉴별 라우팅
              },
              child: Text(label, style: AppTextStyles.headerLeftMenuDesktop),
            ),
          )),

          // 왼쪽 끝과 오른쪽 끝 사이 공간
          Expanded(child: Container()),

          // 오른쪽 메뉴
          ...['로그인', '튜터등록'].map((label) => Padding(
            padding: const EdgeInsets.only(left: 15),
            child: GestureDetector(
              onTap: () {
                if (label == '로그인') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const LoginModal();
                    },
                  );
                }
                // TODO: 튜터등록 라우팅
              },
              child: Text(label, style: AppTextStyles.headerRightMenuDesktop),
            ),
          )),
        ],
      ),
    );
  }
}