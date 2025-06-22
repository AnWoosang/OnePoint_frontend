import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/dimens.dart';
import 'package:one_point/core/router/route_names.dart';

class SearchBarDesktop extends StatefulWidget {
  final double height;
  final double iconSize;
  final Key? anchorKey;

  const SearchBarDesktop({
    super.key,
    required this.height,
    required this.iconSize,
    this.anchorKey,
  });

  @override
  State<SearchBarDesktop> createState() => _SearchBarDesktopState();
}

class _SearchBarDesktopState extends State<SearchBarDesktop> {
  final TextEditingController _controller = TextEditingController();

  void _onSearchSubmit() {
    final keyword = _controller.text.trim();
    context.go('${RouteNames.productSearch}?keyword=$keyword'); // ✅ 빈 값도 허용
  }

  @override
  Widget build(BuildContext context) {
    final String hintText = '상품, 브랜드, 성분 검색';

    return Container(
      key: widget.anchorKey,
      height: widget.height,
      padding: EdgeInsets.symmetric(horizontal: Dimens.searchBarIconPadding),
      decoration: BoxDecoration(
        color: AppColors.grayLighter,
        borderRadius: BorderRadius.circular(Dimens.searchBarRadius),
        border: Border.all(color: AppColors.primary, width: 1.2),
      ),
      child: Row(
        children: [
          // 📝 입력창
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (_) => _onSearchSubmit(),
              style: AppTextStyles.logoSearchInputText,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: Dimens.searchBarInputVerticalPadding,
                ),
                hintText: hintText,
                hintStyle: AppTextStyles.logoSearchHintText,
                border: InputBorder.none,
              ),
              onChanged: (_) {
                if (mounted) setState(() {});
              },
            ),
          ),

          // ❌ X 버튼
          if (_controller.text.isNotEmpty) ...[
            const SizedBox(width: 8),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  _controller.clear();
                  if (mounted) setState(() {});
                },
                child: Container(
                  width: widget.iconSize,
                  height: widget.iconSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black12,
                  ),
                  child: const Icon(Icons.close, size: 18, color: Colors.black54),
                ),
              ),
            ),
          ],

          const SizedBox(width: 8),

          // 🔍 검색 아이콘 (맨 오른쪽)
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _onSearchSubmit,
              child: Icon(Icons.search, color: AppColors.gray, size: widget.iconSize),
            ),
          ),
        ],
      ),
    );
  }
}
