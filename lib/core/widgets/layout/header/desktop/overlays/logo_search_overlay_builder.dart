import 'package:flutter/material.dart';
import 'product_overlay.dart';

class LogoSearchOverlayBuilder {
  static OverlayEntry build({
    required BuildContext context,
    required GlobalKey anchorKey,
    required double horizontalPadding,
    required VoidCallback onClose,
    required String title,
    required List<String> products,
  }) {
    return ProductOverlay.build(
      context: context,
      anchorKey: anchorKey,
      horizontalPadding: horizontalPadding,
      onClose: onClose,
      title: title,
      products: products,
    );
  }
}