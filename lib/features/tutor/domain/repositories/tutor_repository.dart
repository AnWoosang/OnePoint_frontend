import '../entities/common/tutor.dart';

abstract class TutorRepository {
  Future<Tutor> getTutorById(String id);
  // 추가 메서드: 검색, 목록 등 필요시 정의
} 