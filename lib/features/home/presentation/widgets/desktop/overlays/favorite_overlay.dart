import 'package:flutter/material.dart';
import 'package:one_point/core/widgets/layout/header/desktop/overlays/product_overlay.dart';

class FavoriteOverlay {
  static OverlayEntry build({
    required BuildContext context,
    required GlobalKey anchorKey,
    required double horizontalPadding,
    required VoidCallback onClose,
    List<String> products = const ['찜한 A', '찜한 B'],
  }) {
    return ProductOverlay.build(
      context: context,
      anchorKey: anchorKey,
      horizontalPadding: horizontalPadding,
      onClose: onClose,
      title: '❤️ 찜한 상품이에요',
      products: products,
    );
  }
}
