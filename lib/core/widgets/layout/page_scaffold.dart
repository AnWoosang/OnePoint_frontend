import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkle/core/utils/responsive.dart';
import 'package:fitkle/core/utils/performance_utils.dart';
import 'package:fitkle/core/widgets/layout/header_widget.dart';
import 'package:fitkle/core/widgets/layout/footer_widget.dart';
import 'package:fitkle/core/widgets/layout/mobile/mobile_bottom_nav.dart';

class PageScaffold extends ConsumerStatefulWidget {
  final Widget child;
  final double? verticalSpacing;
  final bool showHeader;
  final bool showFooter;
  final bool showBottomNav;
  final ScrollController? scrollController;

  const PageScaffold({
    super.key,
    required this.child,
    this.verticalSpacing,
    this.showHeader = true,
    this.showFooter = true,
    this.showBottomNav = true,
    this.scrollController,
  });

  @override
  ConsumerState<PageScaffold> createState() => _PageScaffoldState();
}

class _PageScaffoldState extends ConsumerState<PageScaffold> {
  late ScrollController _scrollController;
  bool _showBottomNav = true;
  double _lastOffset = 0;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _handleScroll() {
    if (!mounted) return;
    
    final offset = _scrollController.position.pixels;

    if (offset > _lastOffset && _showBottomNav) {
      // 스크롤 다운 → 바텀 네비 숨김
      setState(() => _showBottomNav = false);
    } else if (offset < _lastOffset && !_showBottomNav) {
      // 스크롤 업 → 바텀 네비 보여줌
      setState(() => _showBottomNav = true);
    }

    _lastOffset = offset;
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isApp = Responsive.isApp(context);
    final verticalSpacing = widget.verticalSpacing ?? (isApp ? 16.h : 32.h);
    final horizontalPadding = Responsive.getResponsiveHorizontalPadding(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: _buildScrollableBody(
              isApp: isApp,
              horizontalPadding: horizontalPadding,
              verticalSpacing: verticalSpacing,
            ),
          ),

          // 바텀 네비게이션 (모바일 전용)
          if (isApp && widget.showBottomNav)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedSlide(
                duration: PerformanceUtils.getOptimizedAnimationDuration(),
                offset: _showBottomNav ? Offset.zero : const Offset(0, 1),
                child: MobileBottomNav(
                  currentIndex: _selectedIndex,
                  onTap: _onBottomNavTap,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildScrollableBody({
    required bool isApp,
    required double horizontalPadding,
    required double verticalSpacing,
  }) {
    final header = widget.showHeader 
        ? HeaderWidget(isApp: isApp)
        : const SizedBox.shrink();

    final footer = widget.showFooter
        ? FooterWidget(
            horizontalPadding: horizontalPadding,
            verticalSpacing: verticalSpacing,
            isApp: isApp,
          )
        : const SizedBox.shrink();

    if (isApp) {
      return Column(
        children: [
          header,
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: PerformanceUtils.getOptimizedScrollPhysics(),
              padding: EdgeInsets.only(bottom: 80.h),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 200,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.child,
                    footer,
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return SingleChildScrollView(
        controller: _scrollController,
        physics: PerformanceUtils.getOptimizedScrollPhysics(),
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header,
            widget.child,
            footer,
          ],
        ),
      );
    }
  }
}
