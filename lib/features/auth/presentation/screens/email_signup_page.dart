import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkle/core/router/route_names.dart';

class EmailSignupPage extends StatelessWidget {
  const EmailSignupPage({super.key});

  static const double _logoHeight = 48;
  static const double _cardWidth = 280;
  static const double _cardHeight = 220;
  static const double _cardRadius = 18;
  static const double _cardIconSize = 56;
  static const double _cardSpacing = 32;
  static const TextStyle _titleStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    height: 1.3,
  );
  static const TextStyle _cardTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  static const TextStyle _cardDescStyle = TextStyle(
    fontSize: 15,
    color: Color(0xFF6B7280),
    height: 1.5,
  );
  static const TextStyle _bottomDescStyle = TextStyle(
    fontSize: 15,
    color: Color(0xFF6B7280),
    height: 1.5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 80, bottom: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => GoRouter.of(context).go(RouteNames.home),
                child: SvgPicture.asset(
                  'assets/logo/FITKLE.svg',
                  height: _logoHeight,
                ),
              ),
            ),
            const SizedBox(height: 48),
            const Text(
              '핏클에서 서비스를\n어떻게 이용하고 싶으세요?',
              textAlign: TextAlign.center,
              style: _titleStyle,
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => GoRouter.of(context).go('/signup/email/client?type=tutee'),
                    child: _SelectCard(
                      icon: Icons.search,
                      iconBg: Color(0xFFFFF7D6),
                      iconAsset: null,
                      title: '의뢰인으로 이용',
                      desc: '내가 원하는 서비스의 전문가를\n찾아서 도움을 받고 싶어요',
                    ),
                  ),
                ),
                const SizedBox(width: _cardSpacing),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => GoRouter.of(context).go('/signup/email/client?type=tutor'),
                    child: _SelectCard(
                      icon: Icons.laptop_mac,
                      iconBg: Color(0xFFE6F4FF),
                      iconAsset: null,
                      title: '전문가로 활동',
                      desc: '내가 잘하는 분야의 전문가로\n활동하고 수익을 창출하고 싶어요',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              '가입 이후에도 언제든 원하는 상태로 전환할 수 있어요!',
              style: _bottomDescStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

class _SelectCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String? iconAsset;
  final String title;
  final String desc;

  const _SelectCard({
    required this.icon,
    required this.iconBg,
    this.iconAsset,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: EmailSignupPage._cardWidth,
      height: EmailSignupPage._cardHeight,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(EmailSignupPage._cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFF3F4F6), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: EmailSignupPage._cardIconSize,
            height: EmailSignupPage._cardIconSize,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: iconAsset != null
                ? SvgPicture.asset(iconAsset!, width: 32, height: 32)
                : Icon(icon, size: 32, color: Colors.black),
          ),
          const SizedBox(height: 20),
          Text(title, style: EmailSignupPage._cardTitleStyle),
          const SizedBox(height: 8),
          Text(desc, style: EmailSignupPage._cardDescStyle, textAlign: TextAlign.center),
        ],
      ),
    );
  }
} 