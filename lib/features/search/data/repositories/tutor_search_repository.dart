import '../dto/tutor_search_response_dto.dart';
import 'package:fitkle/features/search/domain/entities/tutor_search_params.dart';
import 'package:fitkle/features/search/domain/repositories/tutor_search_repository.dart';
import '../mock/mock_search_result_items.dart';

export 'package:fitkle/features/search/domain/repositories/tutor_search_repository.dart';

class TutorSearchRepositoryImpl implements TutorSearchRepository {
  // 실제로는 여기서 HTTP 요청을 보냄
  @override
  Future<TutorSearchResponseDto> searchTutors(TutorSearchParams params) async {
    // 네트워크 지연 시뮬레이션
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Mock API 응답 시뮬레이션
    return _getMockResponse(params);
  }
  
  TutorSearchResponseDto _getMockResponse(TutorSearchParams params) {
    // Mock 데이터를 실제 API 응답 형태로 변환
    final mockResponse = {
      "data": _getMockDataForPage(params),
      "pagination": {
        "current_page": params.page,
        "total_pages": 10,
        "total_count": 100,
        "page_size": params.pageSize,
        "has_next": params.page < 10,
      }
    };
    
    return TutorSearchResponseDto.fromJson(mockResponse);
  }
  
  List<Map<String, dynamic>> _getMockDataForPage(TutorSearchParams params) {
    // 실제 Mock 데이터에서 페이지에 맞는 데이터 반환
    final startIndex = (params.page - 1) * params.pageSize;
    final endIndex = startIndex + params.pageSize;
    
    // 기존 mock 데이터를 DTO 형태로 변환
    final allMockData = mockSearchResults.map((item) => {
      "id": item.id,
      "name": item.name,
      "rating": item.rating,
      "rating_count": item.ratingCount,
      "employment_count": item.employmentCount,
      "career_years": item.careerYears,
      "description": item.description,
      "profile_image_url": "https://picsum.photos/200/300?random=${item.id}",  // 임시 이미지 URL
    }).toList();
    
    // 카테고리 필터링
    var filteredData = allMockData;
    if (params.category != null && params.category!.isNotEmpty) {
      // 카테고리 필터링 로직
    }
    
    // 검색어 필터링
    if (params.query != null && params.query!.isNotEmpty) {
      filteredData = filteredData.where((item) {
        return item['name'].toString().contains(params.query!) ||
               item['description'].toString().contains(params.query!);
      }).toList();
    }
    
    // 정렬
    switch (params.sortBy) {
      case '리뷰 많은 순':
        filteredData.sort((a, b) => (b['rating_count'] as int).compareTo(a['rating_count'] as int));
        break;
      case '평점 높은 순':
        filteredData.sort((a, b) => (b['rating'] as double).compareTo(a['rating'] as double));
        break;
      case '경력 많은 순':
        filteredData.sort((a, b) => (b['career_years'] as int).compareTo(a['career_years'] as int));
        break;
    }
    
    // 페이징
    if (startIndex >= filteredData.length) return [];
    final actualEndIndex = endIndex > filteredData.length ? filteredData.length : endIndex;
    
    return filteredData.sublist(startIndex, actualEndIndex);
  }
} 