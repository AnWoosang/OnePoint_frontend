import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ✅ 이거 추가!
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/theme/app_colors.dart';

class FilterBar extends StatelessWidget {
  final List<String> categories;
  final List<String> brands;
  final List<String> inhaleTypes;

  final Set<String> selectedCategories;
  final Set<String> selectedBrands;
  final Set<String> selectedInhaleTypes;

  final String minPrice;
  final String maxPrice;

  final ValueChanged<String> onCategoryToggle;
  final ValueChanged<String> onBrandToggle;
  final ValueChanged<String> onInhaleTypeToggle;
  final ValueChanged<String> onMinPriceChanged;
  final ValueChanged<String> onMaxPriceChanged;
  final VoidCallback? onSearchPressed;

  const FilterBar({
    super.key,
    required this.categories,
    required this.brands,
    required this.inhaleTypes,
    required this.selectedCategories,
    required this.selectedBrands,
    required this.selectedInhaleTypes,
    required this.minPrice,
    required this.maxPrice,
    required this.onCategoryToggle,
    required this.onBrandToggle,
    required this.onInhaleTypeToggle,
    required this.onMinPriceChanged,
    required this.onMaxPriceChanged,
    this.onSearchPressed,
  });

  Widget _buildSelectableTextList(
      List<String> items, Set<String> selected, ValueChanged<String> onToggle) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: items.map((item) {
        final isSelected = selected.contains(item);
        return GestureDetector(
          onTap: () => onToggle(item),
          child: Text(
            item,
            style: TextStyle(
              fontSize: 4.sp,
              color: isSelected ? Colors.black : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              decoration:
                  isSelected ? TextDecoration.underline : TextDecoration.none,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRow(String label, Widget content) {
    return Container(
      height: 50.h, // ✅ 각 행의 고정 높이 설정
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // ✅ 수직 가운데 정렬
        children: [
          // 제목 영역
          Expanded(
            flex: 1,
            child: Container(
              color: AppColors.grayLighter,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 6.w),
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 4.sp, // 💡 적절한 가독성 유지
                ),
              ),
            ),
          ),
          // 내용 영역
          Expanded(
            flex: 5,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: content,
            ),
          ),
        ],
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRow(
          '카테고리',
          _buildSelectableTextList(
              categories, selectedCategories, onCategoryToggle),
        ),
        _buildRow(
          '브랜드',
          _buildSelectableTextList(brands, selectedBrands, onBrandToggle),
        ),
        _buildRow(
          '호흡종류',
          _buildSelectableTextList(
              inhaleTypes, selectedInhaleTypes, onInhaleTypeToggle),
        ),
        _buildRow(
          '가격',
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ✅ 최소 가격
                // ✅ 최소 가격
                SizedBox(
                  width: 56.w,
                  child: TextField(
                    keyboardType: const TextInputType.numberWithOptions(decimal: false),
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: minPrice,
                        selection: TextSelection.collapsed(offset: minPrice.length),
                      ),
                    ),
                    onChanged: onMinPriceChanged,
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center, // ✅ 수직 중앙 정렬
                    style: TextStyle(fontSize: 3.sp),
                    cursorHeight: 14.h, // ✅ 커서 길이
                    decoration: InputDecoration(
                      isDense: true,
                      // contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 6.w), // ✅ 중앙 정렬을 위해 수직 패딩 최소화
                      hintText: '0',
                      hintStyle: TextStyle(fontSize: 4.sp, color: Colors.grey),
                      border: const OutlineInputBorder(),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),

                SizedBox(width: 4.w),
                // ✅ 가운데 ~ 기호
                SizedBox(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('~', style: TextStyle(fontSize: 6.sp)),
                  ),
                ),
                SizedBox(width: 4.w),
              // ✅ 최대 가격
                SizedBox(
                  width: 56.w,
                  child: Align(
                    alignment: Alignment.center,
                    child: TextField(
                      cursorHeight: 14.h,
                      keyboardType: const TextInputType.numberWithOptions(decimal: false),
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.center,
                      controller: TextEditingController.fromValue(
                        TextEditingValue(
                          text: maxPrice,
                          selection: TextSelection.collapsed(offset: maxPrice.length),
                        ),
                      ),
                      onChanged: onMaxPriceChanged,
                      style: TextStyle(fontSize: 3.sp, height: 1.4),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: '0',
                        hintStyle: TextStyle(fontSize: 4.sp, color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(horizontal: 6.w),
                        border: const OutlineInputBorder(),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                // 🔍 검색 버튼
                SizedBox(
                  height: 32.h,
                  width: 32.h,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.search, size: 20),
                    onPressed: onSearchPressed ?? () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}