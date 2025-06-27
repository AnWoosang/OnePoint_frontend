import 'package:flutter/material.dart';

class TutorProfileSetupPageDesktop extends StatelessWidget {
  const TutorProfileSetupPageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('프로필 등록/수정')),
      body: const Center(child: Text('데스크톱 프로필 설정 UI')),
    );
  }
} 