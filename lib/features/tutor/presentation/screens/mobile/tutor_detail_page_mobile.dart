import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkle/core/theme/app_colors.dart';
import 'package:fitkle/core/router/route_names.dart';
import 'package:fitkle/core/theme/app_text_styles.dart';
import 'package:fitkle/features/tutor/domain/entities/tutor_models.dart';
import 'package:fitkle/features/tutor/presentation/widgets/detail/tutor_info_section.dart';
import 'package:fitkle/features/tutor/presentation/widgets/detail/tutor_portfolio_section.dart';
import 'package:fitkle/features/tutor/presentation/widgets/detail/tutor_profile_header.dart';
import 'package:fitkle/features/tutor/presentation/widgets/detail/tutor_qa_section.dart';
import 'package:fitkle/features/tutor/presentation/widgets/detail/tutor_review_section.dart';
import 'package:fitkle/features/tutor/presentation/widgets/detail/tutor_media_section.dart';

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class TutorDetailPageMobile extends StatefulWidget {
  final Tutor tutor;

  const TutorDetailPageMobile({super.key, required this.tutor});

  @override
  State<TutorDetailPageMobile> createState() => _TutorDetailPageMobileState();
}

class _TutorDetailPageMobileState extends State<TutorDetailPageMobile> with TickerProviderStateMixin {
  late final TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final List<String> _tabs = ['튜터정보', '포트폴리오', '사진 및 동영상', '리뷰', 'Q&A'];

  final Map<String, GlobalKey> _sectionKeys = {
    '튜터정보': GlobalKey(),
    '포트폴리오': GlobalKey(),
    '사진 및 동영상': GlobalKey(),
    '리뷰': GlobalKey(),
    'Q&A': GlobalKey(),
  };

  final Map<String, double> _sectionOffsets = {};
  final bool _isTabTapped = false;
  bool _showAppBarTitle = false;
  bool _isTabScrolling = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _calculateSectionOffsets());
    Future.delayed(Duration(milliseconds: 100), () {
      WidgetsBinding.instance.addPostFrameCallback((_) => _calculateSectionOffsets());
    });
    Future.delayed(Duration(milliseconds: 300), () {
      WidgetsBinding.instance.addPostFrameCallback((_) => _calculateSectionOffsets());
    });
    Future.delayed(Duration(seconds: 1), () {
      WidgetsBinding.instance.addPostFrameCallback((_) => _calculateSectionOffsets());
    });
    Future.delayed(Duration(seconds: 2), () {
      WidgetsBinding.instance.addPostFrameCallback((_) => _calculateSectionOffsets());
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // 1. Appbar title visibility
    final bool show = _scrollController.hasClients &&
        _scrollController.offset > 300.0 - kToolbarHeight;
    if (show != _showAppBarTitle) {
      setState(() {
        _showAppBarTitle = show;
      });
    }

    // 2. Tab synchronization
    if (_isTabTapped || !_scrollController.hasClients) return;

    final scrollOffset = _scrollController.offset;
    for (int i = _tabs.length - 1; i >= 0; i--) {
      final tab = _tabs[i];
      final sectionOffset = _sectionOffsets[tab] ?? double.infinity;
      if (scrollOffset >= sectionOffset - 150) { // 150 is adjustment
        if (_tabController.index != i) {
          _tabController.animateTo(i);
        }
        break;
      }
    }
  }

  void _calculateSectionOffsets() {
    if (!mounted) return;
    double accumulatedOffset = 0;
    // We need to account for the space taken by SliverAppBar and SliverPersistentHeader
    // The content starts after the FlexibleSpaceBar of the SliverAppBar
    final headerHeight = 300.0;
    final tabBarHeight = kTextTabBarHeight; // Approximate height of the tab bar
    accumulatedOffset += headerHeight;

    _sectionKeys.forEach((label, key) {
      final RenderBox? box =
          key.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        // The real offset is the accumulated height of widgets before it.
        _sectionOffsets[label] = accumulatedOffset - tabBarHeight;
        accumulatedOffset += box.size.height;
      }
    });
  }

  void _scrollToSection(int index) {
    final tab = _tabs[index];
    final offset = _sectionOffsets[tab];
    if (offset != null) {
      setState(() {
        _isTabScrolling = true;
      });
      _scrollController
          .animateTo(
            offset,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          )
          .whenComplete(() {
        setState(() {
          _isTabScrolling = false;
        });
      });
    }
  }

  void _handleBackNavigation(BuildContext context) {
    // 여러 가지 뒤로가기 옵션을 시도
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else if (context.canPop()) {
      context.pop();
    } else {
      // 마지막 옵션: 홈으로 이동
      context.go(RouteNames.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (!didPop) {
          // 안전한 뒤로가기 처리
          _handleBackNavigation(context);
        }
      },
      child: Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 300.0,
            backgroundColor: Colors.white,
            elevation: 1,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => _handleBackNavigation(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_outlined, color: Colors.black),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border_outlined,
                    color: Colors.black),
                onPressed: () {},
              ),
            ],
            title: _showAppBarTitle
                ? Text(
                    widget.tutor.shortIntro,
                    style: AppTextStyles.searchPageTitleStyleMobile,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: TutorProfileHeader(
                tutor: widget.tutor,
                onFavorite: () {},
                onShare: () {},
              ),
            ),
          ),
          SliverPersistentHeader(
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                onTap: _scrollToSection,
                isScrollable: false,
                labelColor: AppColors.black,
                unselectedLabelColor: AppColors.gray,
                indicatorColor: AppColors.black,
                indicatorWeight: 2.5,
                labelPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                labelStyle: AppTextStyles.sliderSectionTitleStyleMobile
                    .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                unselectedLabelStyle: AppTextStyles.sliderSectionTitleStyleMobile
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                tabs: _tabs.map((name) => Tab(text: name)).toList(),
              ),
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Center(
              child: SizedBox(
                width: double.infinity,
                key: _sectionKeys['튜터정보'],
                child: TutorInfoSection(tutor: widget.tutor),
              ),
            ),
          ),
          SliverToBoxAdapter(child: Divider(color: Colors.grey.shade200, thickness: 1)),
          SliverToBoxAdapter(
            child: Center(
              child: SizedBox(
                width: double.infinity,
                key: _sectionKeys['포트폴리오'],
                child: TutorPortfolioSection(tutor: widget.tutor),
              ),
            ),
          ),
          SliverToBoxAdapter(child: Divider(color: Colors.grey.shade200, thickness: 1)),
          SliverToBoxAdapter(
            child: Center(
              child: SizedBox(
                width: double.infinity,
                key: _sectionKeys['사진 및 동영상'],
                child: TutorMediaSection(tutor: widget.tutor),
              ),
            ),
          ),
          SliverToBoxAdapter(child: Divider(color: Colors.grey.shade200, thickness: 1)),
          SliverToBoxAdapter(
            child: Center(
              child: SizedBox(
                width: double.infinity,
                key: _sectionKeys['리뷰'],
                child: TutorReviewSection(tutor: widget.tutor),
              ),
            ),
          ),
          SliverToBoxAdapter(child: Divider(color: Colors.grey.shade200, thickness: 1)),
          SliverToBoxAdapter(
            child: Center(
              child: SizedBox(
                width: double.infinity,
                key: _sectionKeys['Q&A'],
                child: TutorQaSection(tutor: widget.tutor),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
            onPressed: () {
              // TODO: Implement quote request logic
            },
            child: const Text('견적 요청하기'),
          ),
        ),
      ),
    ),
  );
  }
} 