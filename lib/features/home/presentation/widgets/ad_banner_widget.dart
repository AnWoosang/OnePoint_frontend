import 'package:flutter/material.dart';
import 'package:one_point/core/utils/responsive.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/dimens.dart';

enum AdBannerSize {
  leaderboard, // 728x90
  rectangle,   // 300x250
  largeRectangle, // 336x280
  skyscraper,  // 160x600
  mobileBanner, // 320x100
  custom,
}

class AdBannerWidget extends StatelessWidget {
  final AdBannerSize size;
  final String imageUrl;
  final double? customWidth;
  final double? customHeight;

  const AdBannerWidget({
    super.key,
    required this.size,
    required this.imageUrl,
    this.customWidth,
    this.customHeight,
  });

  Size _getResponsiveSize(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    switch (size) {
      case AdBannerSize.leaderboard:
        return isMobile
            ? const Size(320, 100)
            : isTablet
                ? const Size(468, 60)
                : const Size(728, 90);
      case AdBannerSize.rectangle:
        return isMobile ? const Size(300, 200) : const Size(300, 250);
      case AdBannerSize.largeRectangle:
        return isMobile ? const Size(300, 240) : const Size(336, 280);
      case AdBannerSize.skyscraper:
        return isMobile ? const Size(120, 400) : const Size(160, 600);
      case AdBannerSize.mobileBanner:
        return const Size(320, 100);
      case AdBannerSize.custom:
        return Size(customWidth ?? 300, customHeight ?? 250);
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsiveSize = _getResponsiveSize(context);

    return Container(
      width: responsiveSize.width,
      height: responsiveSize.height,
      margin: EdgeInsets.symmetric(vertical: Dimens.adBannerMarginVertical),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.adBannerRadius),
        color: AppColors.adBannerBackground,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
