class TutorSearchResponseDto {
  final List<TutorSearchItemDto> data;
  final PaginationDto pagination;

  TutorSearchResponseDto({
    required this.data,
    required this.pagination,
  });

  factory TutorSearchResponseDto.fromJson(Map<String, dynamic> json) {
    return TutorSearchResponseDto(
      data: (json['data'] as List)
          .map((item) => TutorSearchItemDto.fromJson(item))
          .toList(),
      pagination: PaginationDto.fromJson(json['pagination']),
    );
  }
}

class TutorSearchItemDto {
  final String id;
  final String name;
  final double rating;
  final int ratingCount;
  final int employmentCount;
  final int careerYears;
  final String description;
  final String profileImageUrl;

  TutorSearchItemDto({
    required this.id,
    required this.name,
    required this.rating,
    required this.ratingCount,
    required this.employmentCount,
    required this.careerYears,
    required this.description,
    required this.profileImageUrl,
  });

  factory TutorSearchItemDto.fromJson(Map<String, dynamic> json) {
    return TutorSearchItemDto(
      id: json['id'] as String,
      name: json['name'] as String,
      rating: (json['rating'] as num).toDouble(),
      ratingCount: json['rating_count'] as int,
      employmentCount: json['employment_count'] as int,
      careerYears: json['career_years'] as int,
      description: json['description'] as String,
      profileImageUrl: json['profile_image_url'] as String,
    );
  }
}

class PaginationDto {
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final int pageSize;
  final bool hasNext;

  PaginationDto({
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.pageSize,
    required this.hasNext,
  });

  factory PaginationDto.fromJson(Map<String, dynamic> json) {
    return PaginationDto(
      currentPage: json['current_page'] as int,
      totalPages: json['total_pages'] as int,
      totalCount: json['total_count'] as int,
      pageSize: json['page_size'] as int,
      hasNext: json['has_next'] as bool,
    );
  }
} 