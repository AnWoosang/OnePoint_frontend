import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/core/theme/dimens.dart';
import 'package:one_point/core/utils/responsive.dart';
import 'package:one_point/core/widgets/layout/header/desktop/overlays/logo_bar_product_card.dart';
import 'overlay_header.dart';
import 'overlay_title.dart';
import 'overlay_pagination.dart';

class OverlayContent extends StatefulWidget {
  final Offset offset;
  final Size size;
  final double boxWidth;
  final double cardWidth;
  final double cardHeight;
  final List<String> products;
  final String title;
  final VoidCallback onClose;
  final double cardDividerWidth;
  final double dividerPadding;
  final int itemsPerPage;

  const OverlayContent({
    super.key,
    required this.offset,
    required this.size,
    required this.boxWidth,
    required this.cardWidth,
    required this.cardHeight,
    required this.products,
    required this.title,
    required this.onClose,
    required this.cardDividerWidth,
    required this.dividerPadding,
    required this.itemsPerPage,
  });

  @override
  State<OverlayContent> createState() => _OverlayContentState();
}

class _OverlayContentState extends State<OverlayContent> {
  int currentPage = 0;
  late List<String> _products;
  bool _showConfirmDialog = false;

  @override
  void initState() {
    super.initState();
    _products = List.from(widget.products);
  }

  void _handleProductDelete(String product) {
    setState(() {
      _products.remove(product);
    });
  }

  void _handleDeleteAllPressed() {
    setState(() {
      _showConfirmDialog = true;
    });
  }

  void _confirmDeleteAll() {
    setState(() {
      _products.clear();
      _showConfirmDialog = false;
    });
  }

  void _cancelDeleteAll() {
    setState(() {
      _showConfirmDialog = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (_products.length / widget.itemsPerPage).ceil();
    final startIndex = currentPage * widget.itemsPerPage;
    final endIndex = (startIndex + widget.itemsPerPage).clamp(0, _products.length);
    final visibleProducts = _products.sublist(startIndex, endIndex);
    final leftPosition = Responsive.getResponsiveHorizontalPadding(context);

    return Stack(
      children: [
        GestureDetector(
          onTap: widget.onClose,
          child: Container(color: Colors.transparent),
        ),
        Positioned(
          top: widget.offset.dy + widget.size.height + Dimens.overlayAnchorOffset,
          left: leftPosition,
          child: Material(
            borderRadius: BorderRadius.zero,
            color: Colors.transparent, // ✅ 색상은 Container에서 적용
            child: Container(
              width: widget.boxWidth,
              height: Dimens.overlayHeight,
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(
                  color: AppColors.divider, // ✅ 테두리 색상
                  width: 1,                 // ✅ 테두리 두께
                ),
                borderRadius: BorderRadius.zero,
              ),
              child: Stack(
                children: [
                  // ✅ 콘텐츠는 padding 안쪽에
                  Padding(
                    padding: EdgeInsets.all(Dimens.overlayPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OverlayHeader(
                          onDeleteAll: _handleDeleteAllPressed,
                          totalCount: _products.length,
                        ),
                        Divider(
                          height: 24.h,
                          thickness: 1.h,
                          color: AppColors.dividerGray,
                        ),
                        if (_products.isNotEmpty) ...[
                          OverlayTitle(title: widget.title),
                          SizedBox(height: 14.h),
                        ],
                        SizedBox(height: 14.h),
                        Expanded(
                          child: _products.isEmpty
                              ? Center(
                                  child: Text(
                                    '최근 본 상품이 없습니다.',
                                    style: AppTextStyles.alertDialogDesktop,
                                  ),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: visibleProducts.length,
                                  itemBuilder: (context, index) {
                                    final product = visibleProducts[index];
                                    final isLast = index == visibleProducts.length - 1;

                                    return Row(
                                      children: [
                                        SizedBox(
                                          width: widget.cardWidth,
                                          height: widget.cardHeight,
                                          child: ProductCardOverlay(
                                            title: product,
                                            price: '12,000원',
                                            onDelete: () => _handleProductDelete(product),
                                          ),
                                        ),
                                        if (!isLast)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: widget.dividerPadding),
                                            child: Container(
                                              width: widget.cardDividerWidth,
                                              height: widget.cardHeight,
                                              color: AppColors.divider,
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                        ),
                        SizedBox(height: 20.h),
                        if (_products.isNotEmpty)
                          OverlayPagination(
                            totalPages: totalPages,
                            currentPage: currentPage,
                            onPageChanged: (index) {
                              setState(() {
                                currentPage = index;
                              });
                            },
                          ),
                      ],
                    ),
                  ),

                  // ✅ 삭제 확인창 전체 오버레이 덮음
                  if (_showConfirmDialog)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                        alignment: Alignment.center,
                        child: Dialog(
                          backgroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 100.w,
                              maxWidth: 100.w, // 가로 너비 줄임
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 16.h,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '전체 상품을 삭제하시겠습니까?',
                                    style: AppTextStyles.alertDialogDesktop,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        onPressed: _cancelDeleteAll,
                                        child: const Text(
                                          '취소',
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: _confirmDeleteAll,
                                        child: const Text(
                                          '삭제',
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}