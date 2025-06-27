import 'package:flutter/material.dart';
import 'package:fitkle/core/theme/app_colors.dart';
import 'package:fitkle/core/theme/app_text_styles.dart';
import 'package:fitkle/core/theme/dimens.dart';

class OverlayPagination extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  final ValueChanged<int> onPageChanged;

  const OverlayPagination({
    super.key,
    required this.totalPages,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: Dimens.overlayPaginationButtonGap,
        children: List.generate(totalPages, (i) {
          final isActive = i == currentPage;
          return SizedBox(
            width: Dimens.paginationButtonSize,
            height: Dimens.paginationButtonSize,
            child: TextButton(
              onPressed: () => onPageChanged(i),
              style: ButtonStyle(
                padding: WidgetStateProperty.all(EdgeInsets.zero),
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                shape: WidgetStateProperty.resolveWith<OutlinedBorder>((states) {
                  final isHovered = states.contains(WidgetState.hovered);
                  final borderColor =
                      (isActive || isHovered) ? Colors.black : AppColors.gray;

                  return RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: borderColor, width: 1),
                  );
                }),
                foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                  final isHovered = states.contains(WidgetState.hovered);
                  return (isActive || isHovered)
                      ? Colors.black
                      : AppColors.gray;
                }),
              ),
              child: Text(
                '${i + 1}',
                style: AppTextStyles.overlayPaginationTextStyle(isActive).copyWith(
                  color: isActive ? Colors.black : AppColors.gray,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}