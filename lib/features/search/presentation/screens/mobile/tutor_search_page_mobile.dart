import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../constants/search_constants.dart';
import '../../providers/tutor_search_provider.dart';
import '../../widgets/tutor_search_bar_section.dart';
import '../../widgets/mobile/tutor_search_result_card_mobile.dart';
import 'package:one_point/core/widgets/layout/mobile/mobile_bottom_nav.dart';
import 'package:one_point/core/router/route_names.dart';

/// 모바일 검색 메인 페이지 (nav_bar가 보이는 첫 화면)
class TutorSearchPageMobile extends StatefulWidget {
  const TutorSearchPageMobile({super.key});

  @override
  State<TutorSearchPageMobile> createState() => _TutorSearchPageMobileState();
}

class _TutorSearchPageMobileState extends State<TutorSearchPageMobile> {
  late ScrollController _scrollController;
  bool _showTitle = true;
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
    
    // 페이지 진입 시 초기 데이터만 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<TutorSearchProvider>();
      // 상태가 initial이고 데이터가 없을 때만 초기 로드
      if (provider.status == SearchStatus.initial && provider.tutors.isEmpty) {
        provider.initialLoad();
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int get _selectedIndex {
    final location = GoRouter.of(context).routerDelegate.currentConfiguration.uri.path;
    switch (location) {
      case RouteNames.home:
        return 0;
      case RouteNames.search:
        return 1;
      case RouteNames.message:
        return 2;
      case RouteNames.mypage:
        return 3;
      default:
        return 0;
    }
  }

  void _onBottomNavTap(int index) {
    switch (index) {
      case 0:
        context.go(RouteNames.home);
        break;
      case 1:
        context.go(RouteNames.search);
        break;
      case 2:
        context.go(RouteNames.message);
        break;
      case 3:
        context.go(RouteNames.mypage);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TutorSearchProvider>(
      builder: (context, provider, child) {
        // 검색어가 있으면 결과 화면의 헤더와 함께 표시
        if (provider.searchParams.query != null && provider.searchParams.query!.isNotEmpty) {
          return _buildSearchResults(provider);
        }
        
        // 기본 검색 화면 (검색바 + 튜터 리스트)
        return PopScope(
          canPop: true,
          onPopInvoked: (didPop) {
            if (!didPop) {
              // 홈으로 이동하거나 다른 처리
              context.go(RouteNames.home);
            }
          },
          child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                
                // 제목 영역 (애니메이션 적용)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: _showTitle ? null : 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _showTitle ? 1.0 : 0.0,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '검색',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
                
                // 검색바 영역 (항상 표시)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TutorSearchBarSection(
                    sortValue: provider.searchParams.sortBy,
                    regionValue: provider.searchParams.region,
                    categoryValue: provider.searchParams.category,
                    regions: kRegions.skip(1).toList(),
                    categories: kTutorCategories.skip(1).toList(),
                    onSortChanged: (value) => provider.updateSortBy(value ?? '리뷰 많은 순'),
                    onRegionChanged: (value) => provider.updateRegion(value),
                    onCategoryChanged: (value) => provider.updateCategory(value),
                    onSearch: (query) {
                      if (query.isNotEmpty) {
                        provider.updateQuery(query);
                      }
                    },
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // 튜터 리스트 (기본 화면에서도 표시)
                _buildTutorList(provider),
              ],
            ),
          ),
          bottomNavigationBar: MobileBottomNav(
            currentIndex: _selectedIndex,
            onTap: _onBottomNavTap,
          ),
        ),
      );
      },
    );
  }

  Widget _buildSearchResults(TutorSearchProvider provider) {
    return PopScope(
      canPop: false, // 자체적으로 뒤로가기 처리
      onPopInvoked: (didPop) {
        if (!didPop) {
          // 검색 결과에서 뒤로가기 시 검색 클리어
          provider.clearSearch();
        }
      },
      child: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            
            // 제목 영역 (애니메이션 적용)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _showTitle ? null : 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _showTitle ? 1.0 : 0.0,
                child: Column(
                  children: [
                    // 뒤로가기 버튼과 제목
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // 검색 상태 초기화하고 메인 검색 화면으로
                              provider.clearSearch();
                            },
                            child: const Icon(Icons.arrow_back, size: 24),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              '검색 결과 ${provider.tutors.length}개',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            
            // 검색바 영역 (항상 표시)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TutorSearchBarSection(
                sortValue: provider.searchParams.sortBy,
                regionValue: provider.searchParams.region,
                categoryValue: provider.searchParams.category,
                regions: kRegions.skip(1).toList(),
                categories: kTutorCategories.skip(1).toList(),
                onSortChanged: (value) => provider.updateSortBy(value ?? '리뷰 많은 순'),
                onRegionChanged: (value) => provider.updateRegion(value),
                onCategoryChanged: (value) => provider.updateCategory(value),
                onSearch: (query) {
                  if (query.isNotEmpty) {
                    provider.updateQuery(query);
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            
            // 검색 결과
            _buildTutorList(provider),
          ],
        ),
      ),
      bottomNavigationBar: MobileBottomNav(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
      ),
    ),
  );
  }

  Widget _buildTutorList(TutorSearchProvider provider) {
    if (provider.isLoading && provider.tutors.isEmpty) {
      return const Expanded(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.status == SearchStatus.error) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                '검색 중 오류가 발생했습니다.',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => provider.updateQuery(provider.searchParams.query ?? ''),
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      );
    }

    if (provider.tutors.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 48, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                '검색 결과가 없습니다.',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!provider.isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            provider.loadMoreTutors();
          }
          return false;
        },
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: provider.tutors.length + (provider.isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= provider.tutors.length) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final tutor = provider.tutors[index];
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