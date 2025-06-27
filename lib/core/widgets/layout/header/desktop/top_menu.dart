import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkle/core/theme/app_text_styles.dart';
import 'package:fitkle/core/router/route_names.dart';
import '../header_link.dart';

class TopMenu extends StatelessWidget {
  const TopMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final links = ['로그인', '회원가입', '고객센터'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: List.generate(links.length * 2 - 1, (i) {
        if (i.isEven) {
          final label = links[i ~/ 2];

          return MouseRegion(
            cursor: SystemMouseCursors.click, // ✅ 마우스 포인터 설정
            child: GestureDetector(
              onTap: () {
                switch (label) {
                  case '로그인':
                    debugPrint('[TopMenu] 로그인 클릭됨'); // ✅ 확인용
                    context.go(RouteNames.login);
                    break;
                  case '회원가입':
                    context.go(RouteNames.signup);
                    break;
                  case '고객센터':
                    // TODO: 고객센터 경로 생기면 연결
                    break;
                }
              },
              child: HeaderLink(label: label),
            ),
          );
        } else {
          return Text(
            '  |  ',
            style: AppTextStyles.topMenuDividerStyle,
          );
        }
      }),
    );
  }
}
