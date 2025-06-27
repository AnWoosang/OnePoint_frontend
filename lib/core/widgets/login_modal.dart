import 'package:flutter/material.dart';
import 'package:fitkle/core/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LoginModal extends StatefulWidget {
  const LoginModal({super.key});
  @override
  State<LoginModal> createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 56),
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header (Perfect Centered Logo + X)
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: SvgPicture.asset(
                      'assets/logo/FITKLE.svg',
                      height: 26,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: -2,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                    splashRadius: 18,
                    padding: EdgeInsets.all(4),
                    constraints: BoxConstraints(),
                    splashColor: AppColors.grayLighter,
                    hoverColor: AppColors.grayLighter,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Email & Password Fields + Login Button + Options Row (all aligned to modal padding)
            TextField(
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              cursorColor: Colors.black,
              maxLines: 1,
              minLines: 1,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: '이메일을 입력해 주세요.',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.grayLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.grayLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.grayLight, width: 2),
                ),
                hintStyle: const TextStyle(fontSize: 16, color: AppColors.grayLight),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              cursorColor: Colors.black,
              maxLines: 1,
              minLines: 1,
              textAlignVertical: TextAlignVertical.center,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '비밀번호를 입력해 주세요.',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.grayLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.grayLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.grayLight, width: 2),
                ),
                hintStyle: const TextStyle(fontSize: 16, color: AppColors.grayLight),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.grayLight,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () { /* TODO: Login Logic */ },
              child: const Text('로그인', style: TextStyle(color: AppColors.black, fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        splashFactory: NoSplash.splashFactory,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        unselectedWidgetColor: AppColors.gray,
                      ),
                      child: Checkbox(
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                        activeColor: AppColors.grayLighter,
                        checkColor: AppColors.gray,
                        hoverColor: Colors.transparent,
                        overlayColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed)) {
                            return Colors.transparent;
                          }
                          return Colors.transparent;
                        }),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    const Text('로그인 유지', style: TextStyle(fontSize: 14, color: AppColors.gray, fontWeight: FontWeight.w500)),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed)) {
                        return AppColors.grayLighter;
                      }
                      return null;
                    }),
                  ),
                  child: const Text('아이디/비밀번호 찾기', style: TextStyle(color: AppColors.gray, fontSize: 14, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // SNS Login Divider
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('SNS 간편 로그인', style: TextStyle(color: AppColors.gray, fontSize: 13, fontWeight: FontWeight.w500)),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 24),

            // SNS Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Kakao
                _buildSocialLoginButton(
                  const Text('kakao', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
                  const Color(0xFFFFE812),
                ),
                const SizedBox(width: 16),
                // Naver
                _buildSocialLoginButton(
                  _NaverIcon(),
                  const Color(0xFF03C75A),
                ),
                const SizedBox(width: 16),
                // Google (colored G)
                _buildSocialLoginButton(
                  const Text('G', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF4285F4))),
                  Colors.white,
                ),
                const SizedBox(width: 16),
                // Facebook
                _buildSocialLoginButton(
                  const Text('f', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                  Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Sign Up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                const Text('아직 회원이 아니신가요?', style: TextStyle(color: AppColors.gray, fontSize: 14, fontWeight: FontWeight.w500, height: 1.0)),
                SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    GoRouter.of(context).go('/signup');
                  },
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                    minimumSize: WidgetStateProperty.all(Size(0, 0)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    overlayColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed)) {
                        return AppColors.grayLighter;
                      }
                      return null;
                    }),
                  ),
                  child: const Text('회원가입', style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 14, height: 1.0)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton(Widget child, Color color) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: color,
      child: child,
    );
  }
}

class _NaverIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: Center(
        child: Text(
          'N',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Arial',
          ),
        ),
      ),
    );
  }
} 