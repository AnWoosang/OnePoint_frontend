class TutorSearchParams {
  final String? query;
  final String? category;
  final String? region;
  final String? sortBy;
  final int page;
  final int pageSize;

  const TutorSearchParams({
    this.query,
    this.category,
    this.region,
    this.sortBy,
    this.page = 1,
    this.pageSize = 10,
  });

  TutorSearchParams copyWith({
    String? query,
    String? category,
    String? region,
    String? sortBy,
    int? page,
    int? pageSize,
  }) {
    return TutorSearchParams(
      query: query ?? this.query,
      category: category ?? this.category,
      region: region ?? this.region,
      sortBy: sortBy ?? this.sortBy,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (query != null && query!.isNotEmpty) 'query': query,
      if (category != null && category!.isNotEmpty) 'category': category,
      if (region != null && region!.isNotEmpty) 'region': region,
      if (sortBy != null && sortBy!.isNotEmpty) 'sort_by': sortBy,
      'page': page,
      'page_size': pageSize,
    };
  }
} 