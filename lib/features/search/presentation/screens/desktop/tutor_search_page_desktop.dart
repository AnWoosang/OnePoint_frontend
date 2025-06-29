import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkle/core/widgets/layout/header_widget.dart';
import 'package:fitkle/core/router/route_names.dart';
import 'package:fitkle/features/search/constants/search_constants.dart';
import 'package:fitkle/features/search/presentation/providers/tutor_search_provider_riverpod.dart';
import 'package:fitkle/features/search/presentation/widgets/tutor_search_bar_section.dart';
import 'package:fitkle/features/search/presentation/widgets/tutor_search_result_card.dart';
import 'package:fitkle/features/search/presentation/widgets/category_sidebar.dart';
import 'package:fitkle/features/search/domain/entities/tutor_search_params.dart';

class TutorSearchPageDesktop extends ConsumerStatefulWidget {
  const TutorSearchPageDesktop({super.key});

  @override
  ConsumerState<TutorSearchPageDesktop> createState() => _TutorSearchPageDesktopState();
}

class _TutorSearchPageDesktopState extends ConsumerState<TutorSearchPageDesktop> {
  final List<String> _categories = kTutorCategories;
  final List<String> _regions = kRegions;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    
    // 초기 데이터 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(searchProvider.notifier).searchTutors(const TutorSearchParams());
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchProvider);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 헤더 영역 (고정)
          const HeaderWidget(isApp: false),
          // 메인 컨텐츠 영역 (스크롤 가능)
          Expanded(
            child: Row(
              children: [
                // 카테고리 사이드바 (고정)
                CategorySidebar(
                  categories: _categories,
                  selectedCategory: searchState.searchParams.category,
                  onCategorySelected: (category) {
                    final newParams = searchState.searchParams.copyWith(
                      category: category,
                      page: 1,
                    );
                    ref.read(searchProvider.notifier).searchTutors(newParams);
                  },
                ),
                // 메인 컨텐츠 영역
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notice) {
                      if (notice.metrics.extentAfter < 400 && !searchState.isLoading) {
                        ref.read(searchProvider.notifier).loadMoreResults();
                      }
                      return false;
                    },
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 검색 필터 섹션
                            TutorSearchBarSection(
                              sortValue: searchState.searchParams.sortBy,
                              regionValue: searchState.searchParams.region,
                              categoryValue: searchState.searchParams.category,
                              regions: _regions.skip(1).toList(),
                              categories: _categories.skip(1).toList(),
                              onSortChanged: (value) {
                                final newParams = searchState.searchParams.copyWith(
                                  sortBy: value,
                                  page: 1,
                                );
                                ref.read(searchProvider.notifier).searchTutors(newParams);
                              },
                              onRegionChanged: (value) {
                                final newParams = searchState.searchParams.copyWith(
                                  region: value,
                                  page: 1,
                                );
                                ref.read(searchProvider.notifier).searchTutors(newParams);
                              },
                              onCategoryChanged: (value) {
                                final newParams = searchState.searchParams.copyWith(
                                  category: value,
                                  page: 1,
                                );
                                ref.read(searchProvider.notifier).searchTutors(newParams);
                              },
                              onSearch: (query) {
                                final newParams = searchState.searchParams.copyWith(
                                  query: query,
                                  page: 1,
                                );
                                ref.read(searchProvider.notifier).searchTutors(newParams);
                              },
                            ),
                            const SizedBox(height: 32),
                            // 검색 결과
                            _buildSearchResults(searchState),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(SearchState searchState) {
    if (searchState.isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (searchState.hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Icon(Icons.error_outline, size: 48, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                '검색 중 오류가 발생했습니다.',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              if (searchState.errorMessage != null)
                Text(
                  searchState.errorMessage!,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(searchProvider.notifier).searchTutors(const TutorSearchParams());
                },
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      );
    }

    final tutors = searchState.searchResults;
    if (tutors.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text(
            '검색 결과가 없습니다.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return Column(
      children: [
        ...tutors.map((tutor) => Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              context.go(RoutePaths.tutorDetail(tutor.id));
            },
            child: TutorSearchResultCard(tutor: tutor),
          ),
        )),
        if (searchState.isLoading)
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),
      ],
    );
  }
} 