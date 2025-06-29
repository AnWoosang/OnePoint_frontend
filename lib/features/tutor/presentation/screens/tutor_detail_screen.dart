import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fitkle/core/utils/responsive.dart';
import 'package:fitkle/features/tutor/presentation/providers/tutor_detail_provider_riverpod.dart';
import 'package:fitkle/features/tutor/presentation/screens/desktop/tutor_detail_page_desktop.dart';
import 'package:fitkle/features/tutor/presentation/screens/mobile/tutor_detail_page_mobile.dart';

class TutorDetailScreen extends ConsumerStatefulWidget {
  final String tutorId;

  const TutorDetailScreen({super.key, required this.tutorId});

  @override
  ConsumerState<TutorDetailScreen> createState() => _TutorDetailScreenState();
}

class _TutorDetailScreenState extends ConsumerState<TutorDetailScreen> {
  @override
  void initState() {
    super.initState();
    // 화면이 로드될 때 튜터 정보 가져오기
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(tutorDetailProvider.notifier).loadTutorDetail(widget.tutorId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tutorDetailState = ref.watch(tutorDetailProvider);
    
    if (tutorDetailState.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    if (tutorDetailState.hasError) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                tutorDetailState.errorMessage ?? '튜터 정보를 불러올 수 없습니다.',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(tutorDetailProvider.notifier).loadTutorDetail(widget.tutorId);
                },
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      );
    }
    
    final tutor = tutorDetailState.tutorDetail;
    if (tutor == null) {
      return const Scaffold(
        body: Center(child: Text('튜터 정보가 없습니다.')),
      );
    }
    
    return LayoutBuilder(
      builder: (context, constraints) {
        if (Responsive.isDesktop(context)) {
          return TutorDetailPageDesktop(tutor: tutor);
        } else {
          return TutorDetailPageMobile(tutor: tutor);
        }
      },
    );
  }
} 