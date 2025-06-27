import 'package:flutter/material.dart';
import '../../data/dto/tutor_search_dto_mapper.dart';
import '../../data/models/tutor_search_params.dart';
import '../../data/models/tutor_search_result_item.dart';
import '../../data/repositories/tutor_search_repository.dart';
// import '../../data/services/recent_search_service.dart';

enum SearchStatus { initial, loading, success, error, loadingMore }

class TutorSearchProvider extends ChangeNotifier {
  final TutorSearchRepository _repository;
  // final RecentSearchService _recentSearchService;

  TutorSearchProvider(this._repository);

  // 상태
  SearchStatus _status = SearchStatus.initial;
  List<TutorSearchResultItem> _tutors = [];
  String? _errorMessage;
  bool _hasNext = true;
  int _currentPage = 1;
  
  // 검색 파라미터
  TutorSearchParams _searchParams = const TutorSearchParams();

  // Getters
  SearchStatus get status => _status;
  List<TutorSearchResultItem> get tutors => _tutors;
  String? get errorMessage => _errorMessage;
  bool get hasNext => _hasNext;
  bool get isLoading => _status == SearchStatus.loading;
  bool get isLoadingMore => _status == SearchStatus.loadingMore;
  TutorSearchParams get searchParams => _searchParams;

  // 초기 검색 또는 새로운 검색
  Future<void> searchTutors({
    String? query,
    String? category,
    String? region,
    String? sortBy,
  }) async {
    _status = SearchStatus.loading;
    _currentPage = 1;
    _tutors.clear();
    notifyListeners();

    _searchParams = _searchParams.copyWith(
      query: query,
      category: category,
      region: region,
      sortBy: sortBy,
      page: 1,
    );

    await _performSearch();
  }

  // 무한 스크롤을 위한 다음 페이지 로드
  Future<void> loadMoreTutors() async {
    if (!_hasNext || _status == SearchStatus.loadingMore) return;

    _status = SearchStatus.loadingMore;
    notifyListeners();

    _currentPage++;
    _searchParams = _searchParams.copyWith(page: _currentPage);

    await _performSearch(isLoadingMore: true);
  }

  // 실제 검색 수행
  Future<void> _performSearch({bool isLoadingMore = false}) async {
    try {
      final response = await _repository.searchTutors(_searchParams);
      final newTutors = response.toModelList();

      if (isLoadingMore) {
        _tutors.addAll(newTutors);
      } else {
        _tutors = newTutors;
      }

      _hasNext = response.pagination.hasNext;
      _status = SearchStatus.success;
      _errorMessage = null;
    } catch (e) {
      _status = SearchStatus.error;
      _errorMessage = e.toString();
      
      if (isLoadingMore) {
        _currentPage--; // 실패 시 페이지 롤백
      }
    }
    
    notifyListeners();
  }

  // 공통 검색 요청
  Future<void> _reload() async {
    await searchTutors(
      query: _searchParams.query,
      category: _searchParams.category,
      region: _searchParams.region,
      sortBy: _searchParams.sortBy,
    );
  }

  // 검색어만 변경
  Future<void> updateQuery(String? query) async {
    // if (query != null && query.trim().isNotEmpty) {
    //   await _recentSearchService.addRecentSearch(query.trim());
    //   await loadRecentSearches();
    // }
    _searchParams = _searchParams.copyWith(query: query, page: 1);
    await _reload();
  }

  // 카테고리만 변경
  Future<void> updateCategory(String? category) async {
    debugPrint('DEBUG: updateCategory called with: $category');
    _searchParams = _searchParams.copyWith(category: category, page: 1);
    debugPrint('DEBUG: searchParams after update: ${_searchParams.category}');
    notifyListeners(); // 즉시 UI 업데이트
    await _reload();
  }

  // 지역만 변경
  Future<void> updateRegion(String? region) async {
    debugPrint('DEBUG: updateRegion called with: $region');
    _searchParams = _searchParams.copyWith(region: region, page: 1);
    debugPrint('DEBUG: searchParams after update: ${_searchParams.region}');
    notifyListeners(); // 즉시 UI 업데이트
    await _reload();
  }

  // 정렬만 변경
  Future<void> updateSortBy(String? sortBy) async {
    debugPrint('DEBUG: updateSortBy called with: $sortBy');
    _searchParams = _searchParams.copyWith(sortBy: sortBy, page: 1);
    debugPrint('DEBUG: searchParams after update: ${_searchParams.sortBy}');
    notifyListeners(); // 즉시 UI 업데이트
    await _reload();
  }

  // 초기 로드
  Future<void> initialLoad() async {
    if (_status == SearchStatus.initial) {
      await searchTutors();
    }
  }

  // 검색 상태 초기화
  void clearSearch() {
    _searchParams = const TutorSearchParams();
    _tutors.clear();
    _status = SearchStatus.initial;
    _errorMessage = null;
    _hasNext = true;
    _currentPage = 1;
    notifyListeners();
  }

  // /// 최근 검색어 로드
  // Future<void> loadRecentSearches() async {
  //   _recentSearches = await _recentSearchService.getRecentSearches();
  //   notifyListeners();
  // }
  //
  // /// 최근 검색어 삭제
  // Future<void> removeRecentSearch(String query) async {
  //   await _recentSearchService.removeRecentSearch(query);
  //   await loadRecentSearches();
  // }
  //
  // /// 최근 검색어 전체 삭제
  // Future<void> clearRecentSearches() async {
  //   await _recentSearchService.clearRecentSearches();
  //   await loadRecentSearches();
  // }
} 