import 'package:flutter/material.dart';
import 'package:one_point/core/utils/responsive.dart';
import 'package:one_point/features/tutor/presentation/screens/desktop/tutor_profile_setup_page_desktop.dart';
import 'package:one_point/features/tutor/presentation/screens/mobile/tutor_profile_setup_page_mobile.dart';

/// 튜터 프로필 등록/수정 화면 (Responsive Wrapper)
class TutorProfileSetupScreen extends StatelessWidget {
  const TutorProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return const TutorProfileSetupPageDesktop();
    }
    return const TutorProfileSetupPageMobile();
  }
} 