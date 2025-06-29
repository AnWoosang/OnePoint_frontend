import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkle/core/utils/responsive.dart';
import 'package:fitkle/features/search/presentation/screens/desktop/tutor_search_page_desktop.dart';
import 'package:fitkle/features/search/presentation/screens/mobile/tutor_search_page_mobile.dart';

class TutorSearchScreen extends ConsumerWidget {
  const TutorSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 1024px 이상은 데스크톱 버전 사용 (Responsive.isDesktop과 동일)
        if (Responsive.isDesktop(context)) {
          return const TutorSearchPageDesktop();
        } else {
          return const TutorSearchPageMobile();
        }
      },
    );
  }
} 