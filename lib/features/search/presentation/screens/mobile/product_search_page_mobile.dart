import 'package:flutter/material.dart';
import 'package:one_point/core/widgets/layout/page_scaffold.dart';
import 'package:one_point/features/search/data/mock/product_preview_mock.dart';
import 'package:one_point/features/search/data/models/product_preview.dart';
import 'package:one_point/features/search/presentation/widgets/mobile/filter_bar_mobile.dart';
import 'package:one_point/features/search/presentation/widgets/mobile/product_search_card_mobile.dart';

class ProductSearchPageMobile extends StatefulWidget {
  final String? keyword;
  final String? category;

  const ProductSearchPageMobile({
    super.key,
    this.keyword,
    this.category,
  });

  @override
  State<ProductSearchPageMobile> createState() => _ProductSearchPageMobileState();
}

class _ProductSearchPageMobileState extends State<ProductSearchPageMobile> {
  late List<ProductPreview> filteredProducts;
  late List<ProductPreview> allProducts;

  String? selectedCategory;
  String? selectedBrand;
  RangeValues selectedPriceRange = const RangeValues(0, 100000);

  late List<String> allCategories;
  late List<String> allBrands;

  @override
  void initState() {
    super.initState();

    allProducts = mockPreviewProducts;

    // keyword/category 기반 초기 필터
    filteredProducts = allProducts.where((product) {
      final matchesKeyword = widget.keyword == null || product.name.contains(widget.keyword!);
      final matchesCategory = widget.category == null || product.productCategory.label == widget.category;
      return matchesKeyword && matchesCategory;
    }).toList();

    allCategories = allProducts.map((p) => p.productCategory.label).toSet().toList();
    allBrands = allProducts.map((p) => p.brand).toSet().toList();
  }

  void _applyFilters() {
    setState(() {
      filteredProducts = allProducts.where((product) {
        final matchesCategory = selectedCategory == null || product.productCategory.label == selectedCategory;
        final matchesBrand = selectedBrand == null || product.brand == selectedBrand;
        final matchesPrice = product.price >= selectedPriceRange.start &&
            product.price <= selectedPriceRange.end;
        return matchesCategory && matchesBrand && matchesPrice;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔼 모바일용 필터 UI
            FilterBarMobile(
              categories: allCategories,
              brands: allBrands,
              selectedCategory: selectedCategory,
              selectedBrand: selectedBrand,
              selectedPriceRange: selectedPriceRange,
              onCategorySelected: (value) {
                selectedCategory = value;
                _applyFilters();
              },
              onBrandSelected: (value) {
                selectedBrand = value;
                _applyFilters();
              },
              onPriceRangeChanged: (range) {
                selectedPriceRange = range;
                _applyFilters();
              },
            ),
            const SizedBox(height: 16),

            // 🔽 상품 목록
            Expanded(
              child: filteredProducts.isEmpty
                  ? const Center(child: Text('조건에 맞는 상품이 없습니다.'))
                  : ListView.separated(
                      itemCount: filteredProducts.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return ProductSearchCardMobile(
                          title: product.name,
                          price: product.formattedPrice,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
