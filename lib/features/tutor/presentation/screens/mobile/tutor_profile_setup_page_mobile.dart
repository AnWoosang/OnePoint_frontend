import 'package:flutter/material.dart';

class TutorProfileSetupPageMobile extends StatelessWidget {
  const TutorProfileSetupPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('프로필 등록/수정')),
      body: const Center(child: Text('모바일 프로필 설정 UI')),
    );
  }
} 