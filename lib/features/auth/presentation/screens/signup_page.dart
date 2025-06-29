import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkle/core/router/route_names.dart';
import 'package:fitkle/core/widgets/login_modal.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  static const double _buttonWidth = 340;
  static const double _buttonHeight = 52;
  static const double _logoHeight = 48;
  static const double _snsButtonSize = 56;
  static const double _verticalSpacing = 32;
  static const Color _kakaoColor = Color(0xFFFFE812);
  static const Color _naverColor = Color(0xFF03C75A);
  static const Color _facebookColor = Color(0xFF1877F3);
  static const Color _borderGray = Color(0xFFD1D5DB);
  static const TextStyle _mainTitleStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    height: 1.3,
  );
  static const TextStyle _buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle _loginTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 15,
    height: 1.0,
    decoration: TextDecoration.underline,
  );
  static const TextStyle _alreadyTextStyle = TextStyle(
    color: Color(0xFF6B7280),
    fontSize: 15,
    height: 1.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              _LogoSection(context),
              const SizedBox(height: 48),
              _MainTitle(),
              const SizedBox(height: 48),
              _KakaoButton(),
              const SizedBox(height: 16),
              _NaverButton(),
              const SizedBox(height: 16),
              _EmailButton(),
              const SizedBox(height: _verticalSpacing),
              _SnsRow(),
              const SizedBox(height: _verticalSpacing),
              _DividerLine(),
              const SizedBox(height: 24),
              _LoginRow(context),
              const SizedBox(height: 40),
          ],
          ),
        ),
      ),
    );
  }

  // --- 위젯 분리 ---
  static Widget _LogoSection(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          try {
            GoRouter.of(context).go(RouteNames.home);
          } catch (e) {
            Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);
          }
        },
        child: SvgPicture.asset(
          'assets/logo/FITKLE.svg',
          height: _logoHeight,
        ),
      ),
    );
  }

  static Widget _MainTitle() => const Text(
        '핏클과 함께\n맞춤형 피드백을 시작해 보세요!',
        textAlign: TextAlign.center,
        style: _mainTitleStyle,
      );

  static Widget _KakaoButton() => SizedBox(
        width: _buttonWidth,
        height: _buttonHeight,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.chat_bubble, color: Colors.black),
          label: Text('카카오로 시작하기', style: _buttonTextStyle.copyWith(color: Colors.black)),
          style: ElevatedButton.styleFrom(
            backgroundColor: _kakaoColor,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        ),
      );

  static Widget _NaverButton() => SizedBox(
        width: _buttonWidth,
        height: _buttonHeight,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Text('N', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
          label: Text('네이버로 시작하기', style: _buttonTextStyle.copyWith(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: _naverColor,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        ),
      );

  static Widget _EmailButton() => Builder(
        builder: (context) => SizedBox(
          width: _buttonWidth,
          height: _buttonHeight,
          child: OutlinedButton(
          onPressed: () {
              GoRouter.of(context).go('/signup/email');
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: _borderGray, width: 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              backgroundColor: Colors.white,
            ),
            child: Text('이메일로 시작하기', style: _buttonTextStyle.copyWith(color: Colors.black)),
          ),
        ),
      );

  static Widget _SnsRow() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _circleSnsButton(
            icon: const Icon(Icons.g_mobiledata, color: Colors.red, size: 28),
            bgColor: Colors.white,
            border: Border.all(color: _borderGray, width: 1),
          ),
          const SizedBox(width: 24),
          _circleSnsButton(
            icon: const Icon(Icons.facebook, color: Colors.white, size: 28, textDirection: TextDirection.ltr, semanticLabel: '',),
            bgColor: _facebookColor,
          ),
        ],
      );

  static Widget _DividerLine() => Container(
        width: _buttonWidth,
        height: 1,
        color: _borderGray,
      );

  Widget _LoginRow(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          const Text('이미 핏클 회원이신가요?', style: _alreadyTextStyle),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const LoginModal(),
                );
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                overlayColor: Colors.transparent,
              ),
              child: const Text('로그인', style: _loginTextStyle),
            ),
        ),
      ],
      );

  static Widget _circleSnsButton({required Widget icon, required Color bgColor, Border? border}) {
    return Container(
      width: _snsButtonSize,
      height: _snsButtonSize,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: border,
      ),
      child: Center(child: icon),
    );
  }
}
