import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fitkle/core/widgets/layout/header_widget.dart';
import 'package:fitkle/core/widgets/layout/footer_widget.dart';
import 'package:fitkle/core/router/route_names.dart';
import '../../providers/tutor_search_provider.dart';
import '../../widgets/tutor_search_bar_section.dart';
import '../../widgets/tutor_search_result_card.dart';
import '../../../constants/search_constants.dart';

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this.child, this.screenWidth);

  final Widget child;
  final double screenWidth;

  @override
  double get minExtent => 140; // 검색바 높이 증가
  @override
  double get maxExtent => 140;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    // 화면 크기 변화 또는 내부 child가 변경되었을 때 재빌드
    return oldDelegate.screenWidth != screenWidth || oldDelegate.child != child;
  }
}

class TutorSearchPageDesktop extends StatefulWidget {
  const TutorSearchPageDesktop({super.key});

  @override
  State<TutorSearchPageDesktop> createState() => _TutorSearchPageDesktopState();
}

class _TutorSearchPageDesktopState extends State<TutorSearchPageDesktop> {
  final List<String> _categories = kTutorCategories;
  final List<String> _regions = kRegions;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    
    // 초기 데이터 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TutorSearchProvider>().initialLoad();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TutorSearchProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              // 헤더 영역 (고정)
              const HeaderWidget(isApp: false),
              // 메인 컨텐츠 영역 (스크롤 가능)
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notice) {
                    if (notice.metrics.extentAfter < 400 && !provider.isLoadingMore) {
                      provider.loadMoreTutors();
                    }
                    return false;
                  },
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // 더 안전한 패딩 계산
                      final sidePad = constraints.maxWidth > 1200 
                          ? constraints.maxWidth * 0.2 
                          : constraints.maxWidth > 800 
                              ? constraints.maxWidth * 0.1 
                              : 20.0;
                      return CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          // 제목 영역
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: sidePad),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 32),
                                  const Text(
                                    '튜터찾기',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -1,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ),
                          ),
                          // 고정될 검색바 영역
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: _SliverAppBarDelegate(
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: sidePad),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: TutorSearchBarSection(
                                    sortValue: provider.searchParams.sortBy,
                                    regionValue: provider.searchParams.region,
                                    categoryValue: provider.searchParams.category,
                                    regions: _regions,
                                    categories: _categories,
                                    onSortChanged: (value) => provider.updateSortBy(value),
                                    onRegionChanged: (value) => provider.updateRegion(value),
                                    onCategoryChanged: (value) => provider.updateCategory(value),
                                    onSearch: (query) => provider.updateQuery(query),
                                  ),
                                ),
                              ),
                              constraints.maxWidth, // 화면 너비 전달
                            ),
                          ),
                          // 검색 결과 영역
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: sidePad),
                              child: Column(
                                children: [
                                  const SizedBox(height: 24),
                                  _buildSearchResults(provider),
                                ],
                              ),
                            ),
                          ),
                          // Footer 영역
                          const SliverToBoxAdapter(
                            child: FooterWidget(
                              horizontalPadding: 40.0,
                              verticalSpacing: 32.0,
                              isApp: false,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchResults(TutorSearchProvider provider) {
    if (provider.isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (provider.status == SearchStatus.error) {
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
              if (provider.errorMessage != null)
                Text(
                  provider.errorMessage!,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => provider.initialLoad(),
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      );
    }

    final tutors = provider.tutors;
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
        if (provider.isLoadingMore)
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),
      ],
    );
  }
} 