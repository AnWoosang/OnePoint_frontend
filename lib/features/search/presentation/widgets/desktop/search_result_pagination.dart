import 'package:flutter/material.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/core/theme/dimens.dart';

class SearchResultPagination extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  final ValueChanged<int> onPageChanged;

  const SearchResultPagination({
    super.key,
    required this.totalPages,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Dimens.overlayPaginationButtonGap,
      alignment: WrapAlignment.center,
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
    );
  }
}
