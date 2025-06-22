import 'package:flutter/material.dart';
import 'package:one_point/core/theme/app_text_styles.dart';

class OverlayTitle extends StatelessWidget {
  final String title;

  const OverlayTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.overlayTitleTextStyle(),
        ),
      ],
    );
  }
}
