import '../repositories/tutor_repository.dart';
import '../entities/common/tutor.dart';

class GetTutorDetailUseCase {
  final TutorRepository _repository;
  const GetTutorDetailUseCase(this._repository);

  Future<Tutor> call(String id) {
    return _repository.getTutorById(id);
  }
} 