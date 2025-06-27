import 'package:flutter/material.dart';
import 'package:fitkle/core/widgets/layout/header/desktop/logo_search_section_desktop.dart';
import 'package:fitkle/core/widgets/layout/header/mobile/logo_search_section_mobile.dart';

class LogoSearchSection extends StatelessWidget {
  final isApp;

  const LogoSearchSection({
    super.key,
    required this.isApp,
  });

  @override
  Widget build(BuildContext context) {
    return isApp
        ? const LogoSearchSectionMobile()
        : LogoSearchSectionDesktop();
  }
}
