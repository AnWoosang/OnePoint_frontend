import 'package:flutter/material.dart';
import 'package:fitkle/core/utils/responsive.dart';
import 'package:fitkle/core/theme/app_text_styles.dart';

class HeaderLink extends StatelessWidget {
  final String label;
  final TextStyle? style;

  const HeaderLink({
    super.key,
    required this.label,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final isCompact = Responsive.isMobile(context) || Responsive.isTablet(context);

    return Text(
      label,
      style: style ?? AppTextStyles.headerLinkTextStyle(isCompact: isCompact),
    );
  }
}