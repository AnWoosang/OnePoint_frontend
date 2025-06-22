import 'package:flutter/material.dart';

class FilterBarMobile extends StatelessWidget {
  final List<String> categories;
  final List<String> brands;
  final String? selectedCategory;
  final String? selectedBrand;
  final RangeValues selectedPriceRange;

  final ValueChanged<String?> onCategorySelected;
  final ValueChanged<String?> onBrandSelected;
  final ValueChanged<RangeValues> onPriceRangeChanged;

  const FilterBarMobile({
    super.key,
    required this.categories,
    required this.brands,
    required this.selectedCategory,
    required this.selectedBrand,
    required this.selectedPriceRange,
    required this.onCategorySelected,
    required this.onBrandSelected,
    required this.onPriceRangeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ 카테고리 필터
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ChoiceChip(
                label: const Text('전체'),
                selected: selectedCategory == null,
                onSelected: (_) => onCategorySelected(null),
              ),
              ...categories.map((category) => Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      onSelected: (_) => onCategorySelected(category),
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // ✅ 브랜드 필터 (드롭다운)
        DropdownButton<String>(
          hint: const Text('브랜드 선택'),
          isExpanded: true,
          value: selectedBrand,
          items: [
            const DropdownMenuItem(value: null, child: Text('전체')),
            ...brands.map((brand) => DropdownMenuItem(
                  value: brand,
                  child: Text(brand),
                )),
          ],
          onChanged: onBrandSelected,
        ),
        const SizedBox(height: 12),

        // ✅ 가격 범위 슬라이더
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('가격 범위'),
            RangeSlider(
              values: selectedPriceRange,
              min: 0,
              max: 100000,
              divisions: 20,
              labels: RangeLabels(
                '${selectedPriceRange.start.toInt()}원',
                '${selectedPriceRange.end.toInt()}원',
              ),
              onChanged: onPriceRangeChanged,
            ),
          ],
        ),
      ],
    );
  }
}
