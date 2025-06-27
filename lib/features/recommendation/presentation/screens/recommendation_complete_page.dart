import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkle/core/theme/app_colors.dart';

class RecommendationCompletePage extends StatelessWidget {
  final String nickname;
  const RecommendationCompletePage({super.key, this.nickname = '관대한복숭아8613'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 48, bottom: 32),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => GoRouter.of(context).go('/'),
                  child: SvgPicture.asset('assets/logo/FITKLE.svg', height: 48),
                ),
              ),
              const SizedBox(height: 32),
              // 아래 이미지는 임시로 아무 이미지나 사용
              Container(
                height: 120,
                width: 240,
                color: const Color(0xFFF3F4F6),
                child: const Center(child: Icon(Icons.image, size: 60, color: Color(0xFF9CA3AF))),
              ),
              const SizedBox(height: 48),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: nickname,
                      style: const TextStyle(
                        color: Color(0xFF2563EB),
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const TextSpan(
                      text: '님',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Text(
                '이제, 회원님께 딱맞는\n서비스들을 추천해 드릴게요.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black, height: 1.4),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: 400,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.grayLight,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    elevation: 0,
                  ),
                  onPressed: () {
                    GoRouter.of(context).go('/service-recommendation-survey');
                  },
                  child: const Text('나에게 딱맞는 서비스 추천받기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 