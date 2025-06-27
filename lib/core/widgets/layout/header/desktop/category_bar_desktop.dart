import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitkle/core/theme/app_colors.dart';
import 'package:fitkle/core/theme/app_text_styles.dart';
import 'package:fitkle/core/theme/dimens.dart';
import 'package:fitkle/core/widgets/layout/header/data/category_data.dart';
import 'package:fitkle/core/widgets/layout/header/model/category_group_model.dart';
import 'package:fitkle/core/widgets/layout/header/desktop/overlays/category_menu_overlay_desktop.dart';

class CategoryBarDesktop extends StatefulWidget {
  final double padding;
  final Function(String) onSelected;

  const CategoryBarDesktop({
    super.key,
    required this.padding,
    required this.onSelected,
  });

  @override
  State<CategoryBarDesktop> createState() => _CategoryBarDesktopState();
}

class _CategoryBarDesktopState extends State<CategoryBarDesktop> {
  final List<CategoryGroup> categories = categoryGroups;
  final GlobalKey _categoryKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  void _toggleOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    } else {
      final renderBox = _categoryKey.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;

      _overlayEntry = OverlayEntry(
        builder: (context) {
          return Stack(
            children: [
              // ✅ 오버레이 외부 클릭 감지 영역
              GestureDetector(
                onTap: _toggleOverlay,
                behavior: HitTestBehavior.translucent,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                ),
              ),
              // ✅ 기존 오버레이
              CategoryOverlayMenu(
                position: position,
                size: size,
                categories: categories,
                onSelected: widget.onSelected,
                onClose: _toggleOverlay,
              ),
            ],
          );
        },
      );

      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = ['인기상품', '베스트셀러', '커뮤니티', '이벤트', '나에게 맞는 액상찾기'];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.divider),
          bottom: BorderSide(color: AppColors.divider),
        ),
      ),
      height: Dimens.categoryBarHeightDesktop,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ✅ 카테고리 버튼 (좌우 테두리만 적용)
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: AppColors.divider, width: 1),
                    right: BorderSide(color: AppColors.divider, width: 1),
                  ),
                ),
                child: TextButton(
                  key: _categoryKey,
                  onPressed: _toggleOverlay,
                  style: TextButton.styleFrom(
                    fixedSize: Size.fromHeight(Dimens.categoryBarHeightDesktop),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    backgroundColor: Colors.transparent,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 6.w, right: 10.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.menu, color: AppColors.black, size: Dimens.categoryBarIconSizeDesktop),
                        SizedBox(width: 4.w),
                        Text('카테고리', style: AppTextStyles.categoryBarTextDesktop),
                      ],
                    ),
                  ),
                ),
              ),

              // 오른쪽 메뉴 버튼들
              Row(
                children: menuItems.map((label) {
                  return Padding(
                    padding: EdgeInsets.only(left: Dimens.categoryBarItemSpacingDesktop),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        fixedSize: Size.fromHeight(Dimens.categoryBarHeightDesktop),
                        backgroundColor: Colors.transparent,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () => widget.onSelected(label),
                      child: Text(
                        label,
                        style: AppTextStyles.categoryBarTextDesktop,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
