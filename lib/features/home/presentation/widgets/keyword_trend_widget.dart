import 'package:flutter/material.dart';
import 'package:one_point/core/utils/responsive.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/core/theme/dimens.dart';

class KeywordTrendWidget extends StatelessWidget {
  final List<String> popularKeywords;

  const KeywordTrendWidget({
    super.key,
    required this.popularKeywords,
  });

  @override
  Widget build(BuildContext context) {
    final isCompact = Responsive.isMobile(context) || Responsive.isTablet(context);
    final spacing = isCompact ? Dimens.keywordChipSpacingCompact : Dimens.keywordChipSpacingDesktop;
    final runSpacing = isCompact ? Dimens.keywordChipRunSpacingCompact : Dimens.keywordChipRunSpacingDesktop;

    final baseStyle = isCompact
        ? AppTextStyles.keywordChipTextStyleMobile
        : AppTextStyles.keywordChipTextStyleDesktop;

    final textStyle = isCompact
        ? baseStyle // ✅ 모바일은 그대로
        : baseStyle.copyWith(height: 1.2); // ✅ 데스크탑만 height 조정

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '📈 최근 일주일간 검색 트렌드에요',
          style: isCompact 
              ? AppTextStyles.keywordTrendTitleStyleMobile 
              : AppTextStyles.keywordTrendTitleStyleDesktop,
        ),
        SizedBox(height: Dimens.keywordTitleSpacing),
        Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: popularKeywords.map((keyword) => Chip(
            label: Text(
              keyword,
              style: textStyle,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 1,
            ),
            backgroundColor: AppColors.keywordChipBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.brandChipRadius),
            ),
          )).toList(),
        ),
      ],
    );
  }
}