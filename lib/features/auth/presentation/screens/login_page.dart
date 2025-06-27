import 'package:flutter/material.dart';
import 'package:one_point/core/widgets/layout/page_scaffold.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('로그인', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            _LoginForm(),
            SizedBox(height: 32),
            Divider(height: 1),
            SizedBox(height: 24),
            Text('소셜 계정으로 로그인', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 16),
            _SocialLoginButtons(),
          ],
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: const InputDecoration(labelText: '이메일'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          decoration: const InputDecoration(labelText: '비밀번호'),
          obscureText: true,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            // TODO: 로그인 처리
          },
          child: const Text('로그인'),
        ),
      ],
    );
  }
}

class _SocialLoginButtons extends StatelessWidget {
  const _SocialLoginButtons();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFEE500), // 카카오 옐로우
            foregroundColor: Colors.black,
            minimumSize: const Size.fromHeight(48),
          ),
          icon: Image.asset('assets/icons/kakao.png', height: 24),
          label: const Text('카카오 로그인'),
          onPressed: () {
            // TODO: 카카오 연동
          },
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF03C75A), // 네이버 그린
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(48),
          ),
          icon: Image.asset('assets/icons/naver.png', height: 24),
          label: const Text('네이버 로그인'),
          onPressed: () {
            // TODO: 네이버 연동
          },
        ),
      ],
    );
  }
}
