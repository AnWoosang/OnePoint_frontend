import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/utils/responsive.dart';
import 'package:one_point/core/widgets/layout/header_widget.dart';
import 'package:one_point/core/widgets/layout/footer_widget.dart';
import 'package:one_point/core/widgets/layout/mobile/mobile_bottom_nav.dart';

class PageScaffold extends StatefulWidget {
  final Widget child;
  final double? verticalSpacing;

  const PageScaffold({
    super.key,
    required this.child,
    this.verticalSpacing,
  });

  @override
  State<PageScaffold> createState() => _PageScaffoldState();
}

class _PageScaffoldState extends State<PageScaffold> {
  final ScrollController _scrollController = ScrollController();
  bool _showBottomNav = true;
  double _lastOffset = 0;

  int _selectedIndex = 0;

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isApp = Responsive.isApp(context);
    final verticalSpacing = widget.verticalSpacing ?? (isApp ? 16.h : 32.h);
    final horizontalPadding = Responsive.getResponsiveHorizontalPadding(context);

    final header = HeaderWidget(
      isApp: isApp,
    );

    final footer = FooterWidget(
      horizontalPadding: horizontalPadding,
      verticalSpacing: verticalSpacing,
      isApp: isApp,
    );

    //ㅇㅕ기서 헤더랑 푸터랑 다 구성을 하는거임
    final scrollableBody = isApp
      ? Column(
          children: [
            header,
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 80.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.child,
                    footer,
                  ],
                ),
              ),
            ),
          ],
        )
      : SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header, // ✅ 웹에선 헤더도 스크롤 안에 포함
              widget.child,
              footer,
            ],
          ),
        );

    // ✅ 전체 Body 영역 (스크롤 포함)

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(child: scrollableBody),

          // ✅ 바텀 네비게이션 (모바일 전용)
          if (isApp)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 300),
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
}
