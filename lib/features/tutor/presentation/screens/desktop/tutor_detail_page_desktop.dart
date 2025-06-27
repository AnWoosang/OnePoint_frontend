import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/core/theme/dimens.dart';
import 'package:one_point/core/widgets/layout/footer_widget.dart';
import 'package:one_point/core/widgets/layout/header_widget.dart';
import 'package:one_point/features/tutor/domain/entities/tutor_models.dart';
import 'package:one_point/features/tutor/presentation/widgets/detail/tutor_info_section.dart';
import 'package:one_point/features/tutor/presentation/widgets/detail/tutor_portfolio_section.dart';
import 'package:one_point/features/tutor/presentation/widgets/detail/tutor_qa_section.dart';
import 'package:one_point/features/tutor/presentation/widgets/detail/tutor_review_section.dart';
import 'package:one_point/features/tutor/presentation/widgets/detail/tutor_media_section.dart';

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this.child);

  final Widget child;

  @override
  double get minExtent => 48;
  @override
  double get maxExtent => 48;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class TutorDetailPageDesktop extends StatefulWidget {
  final Tutor tutor;
  const TutorDetailPageDesktop({super.key, required this.tutor});

  @override
  State<TutorDetailPageDesktop> createState() => _TutorDetailPageDesktopState();
}

class _TutorDetailPageDesktopState extends State<TutorDetailPageDesktop>
    with TickerProviderStateMixin {
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
  bool _isTabTapped = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _scrollController.addListener(_handleScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _calculateSectionOffsets());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _calculateSectionOffsets() {
    if (!mounted) return;
    double accumulatedOffset = 0;
    _sectionKeys.forEach((label, key) {
      final RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        _sectionOffsets[label] = accumulatedOffset;
        accumulatedOffset += box.size.height;
      }
    });
  }

  void _handleScroll() {
    if (_isTabTapped || !_scrollController.hasClients) return;

    final scrollOffset = _scrollController.offset;
    for (int i = _tabs.length - 1; i >= 0; i--) {
      final tab = _tabs[i];
      final sectionOffset = _sectionOffsets[tab] ?? double.infinity;
      if (scrollOffset >= sectionOffset - 150) {
        if (_tabController.index != i) {
          _tabController.animateTo(i);
        }
        break;
      }
    }
  }

  void _scrollToSection(int index) {
    final tab = _tabs[index];
    final offset = _sectionOffsets[tab];

    if (offset != null) {
      _isTabTapped = true;
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      ).whenComplete(() {
        _isTabTapped = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const double maxWidth = 1200;
    const int leftFlex = 7;
    const int rightFlex = 3;
    const double horizontalPadding = 40.0;
    const double rightQuoteBoxWidth = 320;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const HeaderWidget(isApp: !kIsWeb),
          Expanded(
            child: Stack(
              children: [
                // Layer 1: Scrollable content area
                CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: maxWidth),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: horizontalPadding),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: leftFlex,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 40),
                                      _buildDesktopProfileHeader(),
                                    ],
                                  ),
                                ),
                                const Expanded(
                                    flex: rightFlex, child: SizedBox()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                      delegate: _SliverAppBarDelegate(
                        Center(
                          child: ConstrainedBox(
                            constraints:
                                const BoxConstraints(maxWidth: maxWidth),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: horizontalPadding),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: leftFlex,
                                      child: _buildDesktopTabBar()),
                                  const Expanded(
                                      flex: rightFlex, child: SizedBox()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      pinned: true,
                    ),
                    SliverToBoxAdapter(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: maxWidth),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: horizontalPadding),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: leftFlex,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 32.0),
                                    child: _buildTabContent(),
                                  ),
                                ),
                                const Expanded(
                                    flex: rightFlex, child: SizedBox()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: maxWidth),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: horizontalPadding),
                            child: FooterWidget(
                              isApp: !kIsWeb,
                              horizontalPadding: 0,
                              verticalSpacing: Dimens.elementVerticalGap,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Layer 2: Sticky right column
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: maxWidth),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 40.0, right: horizontalPadding),
                        child: SizedBox(
                          width: rightQuoteBoxWidth,
                          child: Column(
                            children: [
                              _StickyQuoteRequestBox(tutor: widget.tutor),
                              const SizedBox(height: 16),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.access_time,
                                      size: 16, color: AppColors.gray),
                                  SizedBox(width: 4),
                                  Text('평균 1시간 내 응답하는 튜터입니다.',
                                      style: TextStyle(
                                          color: AppColors.gray, fontSize: 13)),
                                ],
                              )
                            ],
                          ),
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

  Widget _buildDesktopProfileHeader() {
    return SizedBox(
      height: 280, // Define a height for the header area
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              widget.tutor.headerImageUrl,
              fit: BoxFit.cover,
            ),
          ),
          // Scrim for readability
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                begin: Alignment.center,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Profile content
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(widget.tutor.profileImageUrl),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(widget.tutor.name,
                          style: AppTextStyles.logoTitleDesktop
                              .copyWith(fontSize: 28, color: Colors.white)),
                      const SizedBox(height: 8),
                      Text(widget.tutor.shortIntro,
                          style: AppTextStyles.categoryBarGroupTextDesktop
                              .copyWith(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.9))),
                      // Tags
                      if (widget.tutor.tags?.isNotEmpty ?? false) ...[
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: widget.tutor.tags!
                              .map(
                                (tag) => Chip(
                                  label: Text(tag),
                                  backgroundColor: Colors.grey[200],
                                  labelStyle: AppTextStyles.sliderSectionTitleStyleDesktop
                                      .copyWith(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w500,
                                  ),
                                  shape: const StadiumBorder(),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  side: BorderSide.none,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                // Stats
                Row(
                  children: [
                    _buildStatItem('리뷰', widget.tutor.reviews.length.toString(),
                        textColor: Colors.white, labelColor: Colors.white70),
                    _buildStatDivider(color: Colors.white54),
                    _buildStatItem(
                        '총 레슨', widget.tutor.totalLessons.toString(),
                        textColor: Colors.white, labelColor: Colors.white70),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value,
      {Color textColor = Colors.black, Color labelColor = AppColors.gray}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Text(value,
              style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 14, color: labelColor)),
        ],
      ),
    );
  }

  Widget _buildStatDivider({Color? color}) {
    return Container(
      height: 35,
      width: 1,
      color: color ?? Colors.grey.shade300,
    );
  }

  TabBar _buildDesktopTabBar() {
    return TabBar(
      controller: _tabController,
      onTap: _scrollToSection,
      tabs: _tabs.map((name) => Tab(text: name)).toList(),
      isScrollable: true,
      labelColor: AppColors.black,
      unselectedLabelColor: AppColors.gray,
      indicatorColor: AppColors.black,
      indicatorWeight: 2.5,
      labelPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      labelStyle: AppTextStyles.sliderSectionTitleStyleDesktop.copyWith(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle:
          AppTextStyles.sliderSectionTitleStyleDesktop.copyWith(
        fontSize: 17,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTabContent() {
    final sections = <Widget>[
      Container(
          key: _sectionKeys['튜터정보'],
          child: TutorInfoSection(tutor: widget.tutor)),
      Container(
          key: _sectionKeys['포트폴리오'],
          child: TutorPortfolioSection(tutor: widget.tutor)),
      Container(
          key: _sectionKeys['사진 및 동영상'],
          child: TutorMediaSection(tutor: widget.tutor)),
      Container(
          key: _sectionKeys['리뷰'],
          child: TutorReviewSection(tutor: widget.tutor)),
      Container(
          key: _sectionKeys['Q&A'], child: TutorQaSection(tutor: widget.tutor)),
    ];

    return Column(
      children: List.generate(sections.length * 2 - 1, (index) {
        if (index.isEven) {
          return sections[index ~/ 2];
        } else {
          return Divider(color: Colors.grey.shade200, thickness: 1);
        }
      }),
    );
  }
}

class _StickyQuoteRequestBox extends StatelessWidget {
  final Tutor tutor;
  const _StickyQuoteRequestBox({required this.tutor});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${tutor.name} 튜터에게 원하는 서비스를 받아보세요.',
              style: AppTextStyles.sliderSectionTitleStyleDesktop
                  .copyWith(fontSize: 17),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('견적 요청하기',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
} 