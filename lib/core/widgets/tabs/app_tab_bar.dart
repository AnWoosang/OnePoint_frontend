import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../providers/cursor_provider_riverpod.dart';

class AppTabBar extends ConsumerWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final bool isScrollable;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double? height;

  const AppTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
    this.isScrollable = false,
    this.padding,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cursorSystem = ref.watch(cursorSystemProvider);
    
    return Container(
      height: height ?? 48,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.grayLight,
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        tabs: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = index == selectedIndex;
          
          return MouseRegion(
            onEnter: (_) => cursorSystem.setPointerCursor(),
            onExit: (_) => cursorSystem.resetCursor(),
            child: Tab(
              child: Container(
                padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tab,
                      style: _getTextStyle(isSelected),
                    ),
                    if (isSelected) ...[
                      const SizedBox(height: 4),
                      Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: selectedColor ?? AppColors.primary,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }).toList(),
        onTap: onTap,
        isScrollable: isScrollable,
        indicator: const BoxIndicator(),
        labelColor: selectedColor ?? AppColors.primary,
        unselectedLabelColor: unselectedColor ?? AppColors.gray,
        labelStyle: AppTextStyles.body1.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTextStyles.body1.copyWith(
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  TextStyle _getTextStyle(bool isSelected) {
    if (isSelected) {
      return AppTextStyles.body1.copyWith(
        color: selectedColor ?? AppColors.primary,
        fontWeight: FontWeight.w600,
      );
    } else {
      return AppTextStyles.body1.copyWith(
        color: unselectedColor ?? AppColors.gray,
        fontWeight: FontWeight.w400,
      );
    }
  }
}

class BoxIndicator extends Decoration {
  const BoxIndicator();

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _BoxPainter();
  }
}

class _BoxPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // 기본 인디케이터는 숨김 (커스텀 인디케이터 사용)
  }
} 