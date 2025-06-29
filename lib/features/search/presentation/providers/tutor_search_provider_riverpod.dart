import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/tutor_search_params.dart';
import '../../domain/entities/tutor_search_result_item.dart';
import '../../domain/repositories/tutor_search_repository.dart';
import '../../data/repositories/tutor_search_repository.dart';
import '../../data/dto/tutor_search_dto_mapper.dart';

enum SearchStatus { initial, loading, success, error, empty }

class SearchState extends Equatable {
  final SearchStatus status;
  final List<TutorSearchResultItem> searchResults;
  final TutorSearchParams searchParams;
  final String? errorMessage;
  final bool hasMoreData;
  final int currentPage;

  const SearchState({
    this.status = SearchStatus.initial,
    this.searchResults = const [],
    this.searchParams = const TutorSearchParams(),
    this.errorMessage,
    this.hasMoreData = true,
    this.currentPage = 1,
  });

  bool get isLoading => status == SearchStatus.loading;
  bool get hasError => status == SearchStatus.error;
  bool get isEmpty => status == SearchStatus.empty;

  SearchState copyWith({
    SearchStatus? status,
    List<TutorSearchResultItem>? searchResults,
    TutorSearchParams? searchParams,
    String? errorMessage,
    bool? hasMoreData,
    int? currentPage,
  }) {
    return SearchState(
      status: status ?? this.status,
      searchResults: searchResults ?? this.searchResults,
      searchParams: searchParams ?? this.searchParams,
      errorMessage: errorMessage ?? this.errorMessage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [
    status, 
    searchResults, 
    searchParams, 
    errorMessage, 
    hasMoreData, 
    currentPage
  ];
}

class SearchNotifier extends StateNotifier<SearchState> {
  final TutorSearchRepository _repository;

  SearchNotifier(this._repository) : super(const SearchState());

  Future<void> searchTutors(TutorSearchParams params) async {
    try {
      state = state.copyWith(
        status: SearchStatus.loading,
        searchParams: params,
        currentPage: 1,
      );

      final response = await _repository.searchTutors(params);
      final results = response.data.map((dto) => dto.toModel()).toList();
      
      if (results.isEmpty) {
        state = state.copyWith(
          status: SearchStatus.empty,
          searchResults: [],
          hasMoreData: false,
        );
      } else {
        state = state.copyWith(
          status: SearchStatus.success,
          searchResults: results,
          hasMoreData: response.pagination.hasNext,
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: SearchStatus.error,
        errorMessage: '검색 중 오류가 발생했습니다: $e',
      );
    }
  }

  Future<void> loadMoreResults() async {
    if (!state.hasMoreData || state.isLoading) return;

    try {
      state = state.copyWith(status: SearchStatus.loading);
      
      final nextPage = state.currentPage + 1;
      final nextParams = state.searchParams.copyWith(page: nextPage);
      
      final response = await _repository.searchTutors(nextParams);
      final results = response.data.map((dto) => dto.toModel()).toList();
      
      if (results.isNotEmpty) {
        state = state.copyWith(
          status: SearchStatus.success,
          searchResults: [...state.searchResults, ...results],
          currentPage: nextPage,
          hasMoreData: response.pagination.hasNext,
        );
      } else {
        state = state.copyWith(
          hasMoreData: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: SearchStatus.error,
        errorMessage: '추가 데이터 로드 중 오류가 발생했습니다: $e',
      );
    }
  }

  void clearSearch() {
    state = const SearchState();
  }

  void updateSearchParams(TutorSearchParams params) {
    state = state.copyWith(searchParams: params);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  void setLoading(bool isLoading) {
    if (isLoading) {
      state = state.copyWith(status: SearchStatus.loading);
    } else if (state.status == SearchStatus.loading) {
      state = state.copyWith(status: SearchStatus.success);
    }
  }
}

// Repository Provider
final tutorSearchRepositoryProvider = Provider<TutorSearchRepository>((ref) {
  return TutorSearchRepositoryImpl();
});

// Search Provider
final searchProvider = StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  final repository = ref.watch(tutorSearchRepositoryProvider);
  return SearchNotifier(repository);
});

// Search 상태별 Selector Providers
final searchResultsProvider = Provider<List<TutorSearchResultItem>>((ref) {
  return ref.watch(searchProvider).searchResults;
});

final searchStatusProvider = Provider<SearchStatus>((ref) {
  return ref.watch(searchProvider).status;
});

final searchParamsProvider = Provider<TutorSearchParams>((ref) {
  return ref.watch(searchProvider).searchParams;
});

final searchErrorProvider = Provider<String?>((ref) {
  return ref.watch(searchProvider).errorMessage;
});

final hasMoreDataProvider = Provider<bool>((ref) {
  return ref.watch(searchProvider).hasMoreData;
});

final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(searchProvider).isLoading;
});

final isEmptyProvider = Provider<bool>((ref) {
  return ref.watch(searchProvider).isEmpty;
});

// Search 유틸리티 Provider
final searchSystemProvider = Provider<SearchSystem>((ref) {
  return SearchSystem(ref);
});

class SearchSystem {
  final Ref _ref;

  SearchSystem(this._ref);

  Future<void> searchTutors(TutorSearchParams params) {
    return _ref.read(searchProvider.notifier).searchTutors(params);
  }

  Future<void> loadMoreResults() {
    return _ref.read(searchProvider.notifier).loadMoreResults();
  }

  void clearSearch() {
    _ref.read(searchProvider.notifier).clearSearch();
  }

  void updateSearchParams(TutorSearchParams params) {
    _ref.read(searchProvider.notifier).updateSearchParams(params);
  }

  void clearError() {
    _ref.read(searchProvider.notifier).clearError();
  }
} 