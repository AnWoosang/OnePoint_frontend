import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fitkle/core/utils/responsive.dart';
import 'package:fitkle/core/theme/app_text_styles.dart';
import 'package:fitkle/core/widgets/login_modal.dart';
import 'package:fitkle/core/widgets/layout/header/profile_dropdown.dart';

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
  bool _isLoggedIn = false; // mock 로그인 상태

  void _mockLogin() async {
    // 로그인 모달 닫고 로그인 상태로 전환
    setState(() {
      _isLoggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.getResponsiveHorizontalPadding(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 24),
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
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  // TODO: 각 메뉴별 라우팅
                },
                child: Text(label, style: AppTextStyles.headerLeftMenuDesktop),
              ),
            ),
          )),

          Expanded(child: Container()),

          if (!_isLoggedIn) ...[
            // 로그인/튜터등록
            ...['로그인', '튜터등록'].map((label) => Padding(
              padding: const EdgeInsets.only(left: 15),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    if (label == '로그인') {
                      // 로그인 모달 열고, 성공 시 _mockLogin 호출
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return LoginModal(
                            onLoginSuccess: _mockLogin,
                          );
                        },
                      );
                    }
                    // TODO: 튜터등록 라우팅
                  },
                  child: Text(label, style: AppTextStyles.headerRightMenuDesktop),
                ),
              ),
            )),
          ] else ...[
            // 1. 구매관리(텍스트)
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {},
                  child: Text('구매 관리', style: AppTextStyles.headerRightMenuDesktop),
                ),
              ),
            ),
            // 2. 채팅
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {},
                  child: Tooltip(
                    message: '채팅',
                    child: Icon(Icons.chat_bubble_outline, size: 24, color: Colors.black),
                  ),
                ),
              ),
            ),
            // 3. 알림
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {},
                  child: Tooltip(
                    message: '알림',
                    child: Icon(Icons.notifications_none, size: 24, color: Colors.black),
                  ),
                ),
              ),
            ),
            // 4. 좋아요
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {},
                  child: Tooltip(
                    message: '좋아요',
                    child: Icon(Icons.favorite_border, size: 24, color: Colors.black),
                  ),
                ),
              ),
            ),
            // 5. 프로필(아바타 + 드롭다운)
            ProfileDropdown(onLogout: () {
              setState(() {
                _isLoggedIn = false;
              });
            }),
          ],
        ],
      ),
    );
  }
}