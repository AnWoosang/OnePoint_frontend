import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/search_constants.dart';
import '../../providers/tutor_search_provider_riverpod.dart';
import '../../widgets/tutor_search_bar_section.dart';
import '../../widgets/mobile/tutor_search_result_card_mobile.dart';
import 'package:fitkle/core/widgets/layout/mobile/mobile_bottom_nav.dart';
import 'package:fitkle/core/router/route_names.dart';
import 'package:fitkle/features/search/domain/entities/tutor_search_params.dart';

/// 모바일 검색 메인 페이지 (nav_bar가 보이는 첫 화면)
class TutorSearchPageMobile extends ConsumerStatefulWidget {
  const TutorSearchPageMobile({super.key});

  @override
  ConsumerState<TutorSearchPageMobile> createState() => _TutorSearchPageMobileState();
}

class _TutorSearchPageMobileState extends ConsumerState<TutorSearchPageMobile> {
  late ScrollController _scrollController;
  bool _showTitle = true;
  double _lastOffset = 0;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
    
    // 페이지 진입 시 초기 데이터만 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final searchState = ref.read(searchProvider);
      // 상태가 initial이고 데이터가 없을 때만 초기 로드
      if (searchState.status == SearchStatus.initial && searchState.searchResults.isEmpty) {
        ref.read(searchProvider.notifier).searchTutors(const TutorSearchParams());
      }
    });
  }

  void _handleScroll() {
    final offset = _scrollController.position.pixels;
    const threshold = 100.0; // 스크롤 임계값

    if (offset > threshold && offset > _lastOffset && _showTitle) {
      // 아래로 스크롤 시 제목만 숨김 (검색창과 네비게이션은 유지)
      setState(() {
        _showTitle = false;
      });
    } else if (offset < _lastOffset && !_showTitle) {
      // 위로 스크롤 시 제목 다시 표시
      setState(() {
        _showTitle = true;
      });
    }

    _lastOffset = offset;
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
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
          // 헤더 영역
          Container(
            color: Colors.white,
            child: Column(
              children: [
                // 제목 (스크롤에 따라 숨김/표시)
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _showTitle ? 1.0 : 0.0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: const Row(
                      children: [
                        Text(
                          '튜터찾기',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // 검색 필터 섹션
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TutorSearchBarSection(
                    sortValue: searchState.searchParams.sortBy,
                    regionValue: searchState.searchParams.region,
                    categoryValue: searchState.searchParams.category,
                    regions: kRegions.skip(1).toList(),
                    categories: kTutorCategories.skip(1).toList(),
                    onSortChanged: (value) {
                      final newParams = searchState.searchParams.copyWith(
                        sortBy: value ?? '리뷰 많은 순',
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
                      if (query.isNotEmpty) {
                        final newParams = searchState.searchParams.copyWith(
                          query: query,
                          page: 1,
                        );
                        ref.read(searchProvider.notifier).searchTutors(newParams);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          
          // 검색 결과
          _buildTutorList(searchState),
        ],
      ),
      bottomNavigationBar: MobileBottomNav(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
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
      children: tutors.map((tutor) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => context.go('/tutor/${tutor.id}'),
            child: TutorSearchResultCardMobile(tutor: tutor),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildTutorList(SearchState searchState) {
    if (searchState.isLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (searchState.hasError) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
      return const Expanded(
        child: Center(
          child: Text(
            '검색 결과가 없습니다.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return Expanded(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!searchState.isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            ref.read(searchProvider.notifier).loadMoreResults();
          }
          return false;
        },
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: tutors.length + (searchState.isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= tutors.length) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final tutor = tutors[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => context.go('/tutor/${tutor.id}'),
                  child: TutorSearchResultCardMobile(tutor: tutor),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
} 