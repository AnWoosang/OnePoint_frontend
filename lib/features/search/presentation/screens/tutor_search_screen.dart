import 'package:flutter/material.dart';
import 'package:fitkle/core/utils/responsive.dart';
import 'package:fitkle/features/search/presentation/screens/desktop/tutor_search_page_desktop.dart';
import 'package:fitkle/features/search/presentation/screens/mobile/tutor_search_page_mobile.dart';
import 'package:provider/provider.dart';
import 'package:fitkle/features/search/presentation/providers/tutor_search_provider.dart';
import 'package:fitkle/features/search/data/repositories/tutor_search_repository.dart';

class TutorSearchScreen extends StatelessWidget {
  const TutorSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TutorSearchProvider(TutorSearchRepositoryImpl()),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // 1024px 이상은 데스크톱 버전 사용 (Responsive.isDesktop과 동일)
          if (Responsive.isDesktop(context)) {
            return const TutorSearchPageDesktop();
          } else {
            return const TutorSearchPageMobile();
          }
        },
      ),
    );
  }
} 