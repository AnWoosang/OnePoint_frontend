import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkle/core/theme/app_colors.dart';

class ExpertRegisterCompletePage extends StatefulWidget {
  const ExpertRegisterCompletePage({super.key});
  @override
  State<ExpertRegisterCompletePage> createState() => _ExpertRegisterCompletePageState();
}

class _ExpertRegisterCompletePageState extends State<ExpertRegisterCompletePage> {
  bool agreeTerms = false;

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
              Container(
                width: 520,
                padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 48),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF3F4F6)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('본인인증하면\n전문가 등록완료!',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black, height: 1.3),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('본인인증', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          side: BorderSide(color: Color(0xFFE5E7EB)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text('휴대폰 본인인증', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(height: 36),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('전문가 약관동의', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xFFE5E7EB)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: agreeTerms,
                                onChanged: (v) => setState(() => agreeTerms = v ?? false),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                side: const BorderSide(color: Color(0xFFD1D5DB), width: 2),
                                activeColor: Colors.black,
                                checkColor: Colors.white,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                hoverColor: Colors.transparent,
                                overlayColor: WidgetStateProperty.all(Colors.transparent),
                                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text: '핏클 판매 이용약관에 동의합니다.',
                                    style: TextStyle(color: Colors.black, fontSize: 15),
                                    children: [
                                      TextSpan(
                                        text: ' (필수)',
                                        style: TextStyle(color: Colors.red, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: agreeTerms ? () {/* 등록 완료 로직 */} : null,
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            agreeTerms ? AppColors.limeOlive : Color(0xFFF3F4F6),
                          ),
                          foregroundColor: WidgetStateProperty.all(Colors.black),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          elevation: WidgetStateProperty.all(0),
                          textStyle: WidgetStateProperty.all(
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          mouseCursor: WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.disabled)) {
                              return SystemMouseCursors.forbidden;
                            }
                            return SystemMouseCursors.click;
                          }),
                        ),
                        child: Opacity(
                          opacity: agreeTerms ? 1.0 : 0.5,
                          child: Text('전문가 등록 완료', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 