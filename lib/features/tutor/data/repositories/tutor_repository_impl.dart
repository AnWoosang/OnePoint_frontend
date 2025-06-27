export 'package:one_point/features/tutor/domain/repositories/tutor_repository.dart';

import 'package:one_point/features/tutor/domain/entities/common/tutor.dart';
import 'package:one_point/features/tutor/domain/repositories/tutor_repository.dart';
import 'package:one_point/features/tutor/data/mock/mock_tutors.dart';
import 'package:one_point/features/tutor/data/dto/tutor_dto_mapper.dart';

class TutorRepositoryImpl implements TutorRepository {
  @override
  Future<Tutor> getTutorById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final dto = mockTutors.firstWhere((e) => e.id == id);
    return dto.toModel();
  }
} 