import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:one_point/core/utils/responsive.dart';
import 'package:one_point/features/tutor/data/repositories/tutor_repository_impl.dart';
import 'package:one_point/features/tutor/domain/usecases/get_tutor_detail_usecase.dart';
import 'package:one_point/features/tutor/presentation/providers/tutor_detail_provider.dart';
import 'package:one_point/features/tutor/presentation/screens/desktop/tutor_detail_page_desktop.dart';
import 'package:one_point/features/tutor/presentation/screens/mobile/tutor_detail_page_mobile.dart';

class TutorDetailScreen extends StatelessWidget {
  final String tutorId;

  const TutorDetailScreen({super.key, required this.tutorId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TutorDetailProvider(
        GetTutorDetailUseCase(TutorRepositoryImpl()),
      )..fetchTutor(tutorId),
      child: Consumer<TutorDetailProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }
          final tutor = provider.tutor;
          if (tutor == null) {
            return const SizedBox();
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
        },
      ),
    );
  }
} 