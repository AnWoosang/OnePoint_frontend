import 'package:flutter/material.dart';
import 'package:fitkle/core/widgets/layout/header/desktop/category_bar_desktop.dart';
import 'package:fitkle/core/widgets/layout/header/mobile/category_bar_mobile.dart';

class CategoryBar extends StatelessWidget {
  final double padding;
  final Function(String) onSelected;
  final String selectedTab;
  final bool isApp;

  const CategoryBar({
    super.key,
    required this.padding,
    required this.onSelected,
    required this.selectedTab,
    required this.isApp,
  });

  @override
  Widget build(BuildContext context) {
    return isApp
        ? CategoryBarMobile(
            padding: padding,
            selectedTab: selectedTab,
            onSelected: onSelected,
          )
        : CategoryBarDesktop(
            padding: padding,
            onSelected: onSelected,
          );
  }
}
