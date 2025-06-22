import 'package:flutter/material.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/core/theme/dimens.dart';
import 'package:one_point/core/utils/responsive.dart';

class BrandSectionWidget extends StatelessWidget {
  final List<String> brands;

  const BrandSectionWidget({
    super.key,
    required this.brands,
  });

  @override
  Widget build(BuildContext context) {
    final isCompact = Responsive.isMobile(context) || Responsive.isTablet(context);
    final spacing = isCompact ? Dimens.brandChipSpacingCompact : Dimens.brandChipSpacingDesktop;
    final runSpacing = isCompact ? Dimens.brandChipRunSpacingCompact : Dimens.brandChipRunSpacingDesktop;

    final baseStyle = isCompact
        ? AppTextStyles.brandChipTextStyleMobile
        : AppTextStyles.brandChipTextStyleDesktop;

    final textStyle = isCompact
        ? baseStyle // ✅ 모바일은 그대로
        : baseStyle.copyWith(height: 1.2); // ✅ 데스크탑만 height 조정

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '💎 브랜드별 바로가기',
          style: isCompact
              ? AppTextStyles.brandTitleStyleMobile
              : AppTextStyles.brandTitleStyleDesktop,
        ),
        SizedBox(height: Dimens.brandTitleSpacing),
        Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: brands.map((brand) => Chip(
            label: Text(
              brand,
              style: textStyle,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 1,
            ),
            backgroundColor: AppColors.brandChipBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.brandChipRadius),
            ),
          )).toList(),
        ),
      ],
    );
  }
}
