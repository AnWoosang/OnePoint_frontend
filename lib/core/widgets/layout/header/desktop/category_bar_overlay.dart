import 'package:flutter/material.dart';
import 'package:one_point/core/widgets/layout/header/desktop/overlays/category_menu_overlay_desktop.dart';
import 'package:one_point/core/widgets/layout/header/model/category_group_model.dart';

class CategoryBarOverlay {
  static OverlayEntry build({
    required BuildContext context,
    required Offset position,
    required Size size,
    required List<CategoryGroup> categories,
    required void Function(String) onSelected,
    required VoidCallback onClose,
  }) {
    return OverlayEntry(
      builder: (context) => CategoryOverlayMenu(
        position: position,
        size: size,
        categories: categories,
        onSelected: onSelected,
        onClose: onClose,
      ),
    );
  }
}
