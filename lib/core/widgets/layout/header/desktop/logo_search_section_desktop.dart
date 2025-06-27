import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/dimens.dart';
import 'package:one_point/core/utils/responsive.dart';
import 'package:one_point/core/router/route_names.dart';
import 'package:one_point/core/widgets/layout/header/desktop/overlays/logo_search_overlay_builder.dart';
import 'package:one_point/core/widgets/layout/header/desktop/search_bar.dart';

class LogoSearchSectionDesktop extends StatefulWidget {
  const LogoSearchSectionDesktop({super.key});

  @override
  State<LogoSearchSectionDesktop> createState() => _LogoSearchSectionDesktopState();
}

class _LogoSearchSectionDesktopState extends State<LogoSearchSectionDesktop> {
  OverlayEntry? _recentOverlay;
  OverlayEntry? _favoriteOverlay;
  final GlobalKey _anchorKey = GlobalKey();

  List<String> recentViewedProducts = const ['상품 A', '상품 B', '상품 C', '상품 D', '상품 E','상품 F','상품 G','상품 H','상품 I'];
  List<String> favoriteProducts = const ['찜한 A', '찜한 B'];
  String? _activeSection;

  void _toggleRecentOverlay() {
    setState(() => _activeSection = 'recent');
    if (_recentOverlay != null) {
      _recentOverlay!.remove();
      _recentOverlay = null;
      setState(() => _activeSection = null);
    } else {
      _recentOverlay = LogoSearchOverlayBuilder.build(
        title: '🔥 최근에 조회하신 상품이에요',
        context: context,
        anchorKey: _anchorKey,
        horizontalPadding: Responsive.getResponsiveHorizontalPadding(context),
        onClose: () {
          _recentOverlay?.remove();
          _recentOverlay = null;
          setState(() => _activeSection = null);
        },
        products: recentViewedProducts
      );
      Overlay.of(context).insert(_recentOverlay!);
    }
  }

  void _toggleFavoriteOverlay() {
    setState(() => _activeSection = 'favorite');
    if (_favoriteOverlay != null) {
      _favoriteOverlay!.remove();
      _favoriteOverlay = null;
      setState(() => _activeSection = null);
    } else {
      _favoriteOverlay = LogoSearchOverlayBuilder.build(
        title: '❤️ 찜한 상품이에요',
        context: context,
        anchorKey: _anchorKey,
        horizontalPadding: Responsive.getResponsiveHorizontalPadding(context),
        onClose: () {
          _favoriteOverlay?.remove();
          _favoriteOverlay = null;
          setState(() => _activeSection = null);
        },
        products: favoriteProducts
      );
      Overlay.of(context).insert(_favoriteOverlay!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final logoFontStyle = AppTextStyles.logoTitleDesktop;
    final searchBarHeight = Dimens.searchBarHeightDesktop;
    final iconSize = Dimens.logoActionIconSizeDesktop;
    final actionTextStyle = AppTextStyles.headerLeftMenuDesktop;
    final elementGap = Dimens.logoSearchElementGap;
    final itemGap = Dimens.logoSearchItemGap;
    final logoTitle = 'one_point';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 로고
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => context.go(RouteNames.home),
            child: Text(logoTitle, style: logoFontStyle),
          ),
        ),
        SizedBox(width: elementGap),

        // 검색창
        Expanded(
          child: SearchBarDesktop(
            anchorKey: _anchorKey,
            height: searchBarHeight,
            iconSize: iconSize,
          ),
        ),
        SizedBox(width: elementGap),

        // 최근 본 상품 & 찜한 상품
        Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: _toggleRecentOverlay,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 2),
                      decoration: _activeSection == 'recent'
                          ? const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1.8,
                                ),
                              ),
                            )
                          : null,
                      child: Text(
                        '최근 본 상품',
                        style: actionTextStyle,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, size: iconSize, color: AppColors.gray),
                  ],
                ),
              ),
            ),
            SizedBox(width: itemGap),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: _toggleFavoriteOverlay,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 2),
                      decoration: _activeSection == 'favorite'
                          ? const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1.8,
                                ),
                              ),
                            )
                          : null,
                      child: Text(
                        '찜한 상품',
                        style: actionTextStyle,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, size: iconSize, color: AppColors.gray),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}