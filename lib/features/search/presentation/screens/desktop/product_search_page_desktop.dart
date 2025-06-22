import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/widgets/layout/page_scaffold.dart';
import 'package:one_point/features/search/data/mock/product_preview_mock.dart';
import 'package:one_point/features/search/data/models/product_preview.dart';
import 'package:one_point/features/search/presentation/widgets/desktop/product_search_card.dart';
import 'package:one_point/features/search/presentation/widgets/desktop/search_result_pagination.dart';
import 'package:one_point/features/search/presentation/widgets/desktop/filter_bar.dart'; // ✅ 수정된 필터바
import 'package:one_point/core/theme/dimens.dart';
import 'package:one_point/core/utils/responsive.dart';

class ProductSearchPageDesktop extends StatefulWidget {
  final String? keyword;
  final String? category;

  const ProductSearchPageDesktop({
    super.key,
    this.keyword,
    this.category,
  });

  @override
  State<ProductSearchPageDesktop> createState() => _ProductSearchPageDesktopState();
}

class _ProductSearchPageDesktopState extends State<ProductSearchPageDesktop> {
  late List<ProductPreview> filteredProducts;
  late List<ProductPreview> allProducts;

  int currentPage = 0;
  int itemsPerPage = 24;

  Set<String> selectedCategories = {};
  Set<String> selectedBrands = {};
  Set<String> selectedInhaleTypes = {};

  String minPrice = '';
  String maxPrice = '';

  late List<String> allCategories;
  late List<String> allBrands;

  @override
  void initState() {
    super.initState();

    allProducts = mockPreviewProducts;

    final hasKeyword = widget.keyword?.isNotEmpty ?? false;

    filteredProducts = allProducts.where((product) {
      final matchesKeyword = !hasKeyword || product.name.contains(widget.keyword!);
      final matchesCategory = widget.category == null || product.productCategory.label == widget.category;
      return matchesKeyword && matchesCategory;
    }).toList();

    allCategories = allProducts.map((p) => p.productCategory.label).toSet().toList();
    allBrands = allProducts.map((p) => p.brand).toSet().toList();

    selectedCategories = widget.category != null ? {widget.category!} : {};
  }

  void _applyFilters() {
    final result = allProducts.where((product) {
      final matchesCategory = selectedCategories.isEmpty ||
          selectedCategories.contains(product.productCategory.label);
      final matchesBrand = selectedBrands.isEmpty || selectedBrands.contains(product.brand);
      final matchesInhale = selectedInhaleTypes.isEmpty || selectedInhaleTypes.contains(product.inhaleType);

      final min = int.tryParse(minPrice) ?? 0;
      final max = int.tryParse(maxPrice) ?? 100000;
      final matchesPrice = product.price >= min && product.price <= max;

      return matchesCategory && matchesBrand && matchesInhale && matchesPrice;
    }).toList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          filteredProducts = result;
          currentPage = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.getResponsiveHorizontalPadding(context);

    final cardSpacing = 2.w;
    final cardPerRow = 4;
    final totalSpacing = cardSpacing * (cardPerRow - 1);
    final availableWidth = MediaQuery.of(context).size.width - (padding * 2);
    final cardWidth = (availableWidth - totalSpacing) / cardPerRow;

    final totalPages = (filteredProducts.length / itemsPerPage).ceil();
    final pagedProducts = filteredProducts
        .skip(currentPage * itemsPerPage)
        .take(itemsPerPage)
        .toList();

    return PageScaffold(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '상품 검색 결과',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              Align(
                alignment: Alignment.centerRight,
                child: DropdownButton<int>(
                  value: itemsPerPage,
                  items: [24, 36, 48]
                      .map((count) => DropdownMenuItem(value: count, child: Text('$count개씩 보기')))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        itemsPerPage = value;
                        currentPage = 0;
                      });
                    }
                  },
                ),
              ),

              const SizedBox(height: 16),

              FilterBar(
                categories: allCategories,
                brands: allBrands,
                inhaleTypes: ['MTL', 'DTL'],
                selectedCategories: selectedCategories,
                selectedBrands: selectedBrands,
                selectedInhaleTypes: selectedInhaleTypes,
                minPrice: minPrice,
                maxPrice: maxPrice,
                onCategoryToggle: (value) {
                  setState(() {
                    selectedCategories.contains(value)
                        ? selectedCategories.remove(value)
                        : selectedCategories.add(value);
                    _applyFilters();
                  });
                },
                onBrandToggle: (value) {
                  setState(() {
                    selectedBrands.contains(value)
                        ? selectedBrands.remove(value)
                        : selectedBrands.add(value);
                    _applyFilters();
                  });
                },
                onInhaleTypeToggle: (value) {
                  setState(() {
                    selectedInhaleTypes.contains(value)
                        ? selectedInhaleTypes.remove(value)
                        : selectedInhaleTypes.add(value);
                    _applyFilters();
                  });
                },
                onMinPriceChanged: (val) {
                  minPrice = val;
                  _applyFilters();
                },
                onMaxPriceChanged: (val) {
                  maxPrice = val;
                  _applyFilters();
                },
              ),

              const SizedBox(height: 24),

              if (pagedProducts.isEmpty)
                const Center(child: Text('해당 조건의 상품이 없습니다.'))
              else
                Wrap(
                  spacing: cardSpacing,
                  runSpacing: 16.h,
                  children: List.generate(
                    pagedProducts.length,
                    (index) {
                      final product = pagedProducts[index];
                      return SizedBox(
                        width: cardWidth,
                        child: ProductSearchCard(
                          key: ValueKey(product.id),
                          title: product.name,
                          price: product.formattedPrice,
                          width: cardWidth,
                          height: Dimens.overlayCardHeight,
                        ),
                      );
                    },
                  ),
                ),

              const SizedBox(height: 32),

              Center(
                child: SearchResultPagination(
                  totalPages: totalPages,
                  currentPage: currentPage,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}