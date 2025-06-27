import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkle/core/theme/app_colors.dart';

class IdentityVerificationPage extends StatefulWidget {
  const IdentityVerificationPage({super.key});

  @override
  State<IdentityVerificationPage> createState() => _IdentityVerificationPageState();
}

class _IdentityVerificationPageState extends State<IdentityVerificationPage> {
  bool _isNextHover = false;

  void _showSkipDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        child: SizedBox(
          width: 300, // 가로 크기 절반
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF3F4F6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.info_outline, color: Color(0xFF9CA3AF), size: 28),
                ),
                const SizedBox(height: 24),
                const Text(
                  '본인 인증을 건너뛸까요?',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  '본인인증은 이후\n마이픽클에서 하실 수 있어요',
                  style: TextStyle(fontSize: 15, color: Color(0xFF6B7280), height: 1.5),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          side: const BorderSide(color: Color(0xFFD1D5DB), width: 2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          backgroundColor: Colors.white,
                          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                          minimumSize: const Size.fromHeight(50),
                          alignment: Alignment.center,
                        ),
                        child: const Text('취소'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          GoRouter.of(context).go('/recommendation-complete');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.grayLight,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                          elevation: 0,
                          minimumSize: const Size.fromHeight(50),
                          alignment: Alignment.center,
                        ),
                        child: const Text('확인'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
              const SizedBox(height: 48),
              const Text(
                '안전한 거래를 위해\n본인인증이 필요해요',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.black, height: 1.3),
              ),
              const SizedBox(height: 20),
              const Text(
                '서비스를 판매 / 구매하는 과정에서의\n서로의 신뢰를 위해 본인인증을 진행합니다',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, color: Color(0xFF6B7280), height: 1.5),
              ),
              const SizedBox(height: 48),
              Icon(Icons.verified_user, size: 100, color: Colors.green), // 임시 일러스트
              const SizedBox(height: 56),
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
                    // 본인인증 로직
                  },
                  child: const Text('본인인증 하기'),
                ),
              ),
              const SizedBox(height: 24),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => setState(() => _isNextHover = true),
                onExit: (_) => setState(() => _isNextHover = false),
                child: GestureDetector(
                  onTap: () {
                    _showSkipDialog(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                    decoration: BoxDecoration(
                      color: _isNextHover ? const Color(0xFFF3F4F6) : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('다음에 하기', style: TextStyle(color: Color(0xFF6B7280), fontSize: 15,fontWeight: FontWeight.w700)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, size: 18, color: Color(0xFF6B7280)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 