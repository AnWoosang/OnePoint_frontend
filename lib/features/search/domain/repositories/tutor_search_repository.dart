import '../entities/tutor_search_params.dart';
import '../../data/dto/tutor_search_response_dto.dart';

abstract class TutorSearchRepository {
  Future<TutorSearchResponseDto> searchTutors(TutorSearchParams params);
} 