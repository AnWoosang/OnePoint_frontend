import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitkle/core/theme/dimens.dart';
import 'overlay_content.dart';

class ProductOverlay {
  static OverlayEntry build({
    required BuildContext context,
    required GlobalKey anchorKey,
    required double horizontalPadding,
    required VoidCallback onClose,
    required String title,
    required List<String> products,
  }) {
    final renderBox = anchorKey.currentContext!.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    final screenWidth = MediaQuery.of(context).size.width;
    final boxWidth = screenWidth - horizontalPadding * 2;

    const int itemsPerPage = 4;
    final double cardDividerWidth = 0.4.w;
    final double dividerPadding = 4.w;
    final int dividerCount = itemsPerPage - 1;

    final double totalDividerSpace = dividerCount * (cardDividerWidth + 2 * dividerPadding);
    final double contentWidth = boxWidth - (Dimens.overlayPadding * 2);
    final double availableWidth = contentWidth - totalDividerSpace;
    final double cardWidth = (availableWidth / itemsPerPage).floorToDouble();
    final double cardHeight = Dimens.overlayCardHeight;

    return OverlayEntry(
      builder: (context) => OverlayContent(
        offset: offset,
        size: size,
        boxWidth: boxWidth,
        cardWidth: cardWidth,
        cardHeight: cardHeight,
        products: products,
        title: title,
        onClose: onClose,
        cardDividerWidth: cardDividerWidth,
        dividerPadding: dividerPadding,
        itemsPerPage: itemsPerPage,
      ),
    );
  }
}
