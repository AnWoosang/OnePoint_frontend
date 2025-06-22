import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/core/theme/dimens.dart';

class FooterWidget extends StatelessWidget {
  final double horizontalPadding;
  final double verticalSpacing;
  final bool isApp;

  const FooterWidget({
    super.key,
    required this.horizontalPadding,
    required this.verticalSpacing,
    required this.isApp,
  });

  @override
  Widget build(BuildContext context) {
    final footerLinks = [
      '공지',
      '광고안내',
      '제보',
      '사이트정보',
      '이용약관',
      '개인정보처리방침',
    ];

    return Column(
      children: [
        Divider(thickness: Dimens.footerDividerThickness, color: AppColors.divider),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalSpacing / Dimens.footerVerticalSpacingDivider,
          ),
          child: isApp
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCopyright(isApp),
                    SizedBox(height: Dimens.footerSectionGapCompact),
                    _buildLinks(footerLinks, isApp),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCopyright(isApp),
                    _buildLinks(footerLinks, isApp),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildCopyright(bool isApp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '© 2025 one_point. All rights reserved.',
          style: AppTextStyles.footerInfoStyle(isApp),
        ),
        SizedBox(height: Dimens.footerCopyrightSpacing),
        Text(
          'Contact: one_point@gmail.com',
          style: AppTextStyles.footerInfoStyle(isApp),
        ),
      ],
    );
  }

  Widget _buildLinks(List<String> links, bool isApp) {
    return Wrap(
      spacing: isApp ? 2.w : Dimens.footerLinkSpacingDesktop,
      runSpacing: Dimens.footerLinkRunSpacing,
      children: List.generate(links.length * 2 - 1, (i) {
        if (i.isEven) {
          final label = links[i ~/ 2];
          return GestureDetector(
            onTap: () {
              // TODO: 클릭 처리
            },
            child: Text(
              label,
              style: AppTextStyles.footerLinkStyle(isApp),
            ),
          );
        } else {
          return Text(
            '|',
            style: AppTextStyles.footerDividerStyle(isApp),
          );
        }
      }),
    );
  }
}