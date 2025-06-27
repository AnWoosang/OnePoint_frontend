import 'package:flutter/material.dart';
import 'region_selector_dialog.dart';

class TutorSearchBarSection extends StatefulWidget {
  final String? sortValue;
  final String? regionValue;
  final String? categoryValue;
  final List<String> regions;
  final List<String> categories;
  final Function(String?) onSortChanged;
  final Function(String?) onRegionChanged;
  final Function(String?) onCategoryChanged;
  final Function(String) onSearch;

  const TutorSearchBarSection({
    super.key,
    this.sortValue,
    this.regionValue,
    this.categoryValue,
    required this.regions,
    required this.categories,
    required this.onSortChanged,
    required this.onRegionChanged,
    required this.onCategoryChanged,
    required this.onSearch,
  });

  @override
  State<TutorSearchBarSection> createState() => _TutorSearchBarSectionState();
}

class _TutorSearchBarSectionState extends State<TutorSearchBarSection> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        children: [
          // 상단: 지역 + 정렬 드롭다운
          Row(
            children: [
              // 지역 버튼 (모달 선택)
              Flexible(
                child: _buildRegionButton(),
              ),
              const SizedBox(width: 12),
              // 카테고리 드롭다운
              Flexible(
                child: _buildFilterButton(
                  value: widget.categoryValue,
                  defaultText: widget.categoryValue ?? '카테고리',
                  items: [
                    const DropdownMenuItem(value: null, child: Text('카테고리')),
                    ...widget.categories.map((c) => DropdownMenuItem(value: c, child: Text(c))),
                  ],
                  onChanged: widget.onCategoryChanged,
                ),
              ),
              
            ],
          ),
          
          const SizedBox(height: 12),
          
          // 구분선
          Container(
            height: 1,
            color: Colors.grey.shade200,
          ),
          
          const SizedBox(height: 12),
          
          // 하단: 검색창 + 검색 버튼
          Row(
            children: [
              _buildFilterButton(
                value: widget.sortValue,
                defaultText: '리뷰 많은 순',
                items: const [
                  DropdownMenuItem(value: '리뷰 많은 순', child: Text('리뷰 많은 순')),
                  DropdownMenuItem(value: '평점 높은 순', child: Text('평점 높은 순')),
                  DropdownMenuItem(value: '가격 낮은 순', child: Text('가격 낮은 순')),
                  DropdownMenuItem(value: '가격 높은 순', child: Text('가격 높은 순')),
                  DropdownMenuItem(value: '최신 순', child: Text('최신 순')),
                ],
                onChanged: widget.onSortChanged,
              ),
              const SizedBox(width: 12),
              // 검색창
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    style: const TextStyle(fontSize: 14),
                    controller: _searchController,
                    onSubmitted: widget.onSearch,
                    decoration: InputDecoration(
                      hintText: '어떤 서비스가 필요하세요?',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade500,
                        size: 20,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // 검색 버튼
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextButton(
                  onPressed: () {
                    widget.onSearch(_searchController.text);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    '검색',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton({
    required String? value,
    required String defaultText,
    required List<DropdownMenuItem<String?>> items,
    required Function(String?) onChanged,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 80,
        maxWidth: 150,
      ),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            highlightColor: Theme.of(context).colorScheme.primary.withOpacity(0.08),
            splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.08),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String?>(
              value: value,
              hint: Text(
                defaultText,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              items: items,
              onChanged: onChanged,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 13,
              ),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey.shade600,
                size: 16,
              ),
              isDense: true,
              isExpanded: true,
              dropdownColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegionButton() {
    final text = widget.regionValue ?? '지역';
    return InkWell(
      onTap: () async {
        final result = await showDialog<String?>(
          context: context,
          builder: (context) => RegionSelectorDialog(initialRegion: widget.regionValue),
        );
        if (result != null) {
          widget.onRegionChanged(result);
        }
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 80, maxWidth: 150),
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey.shade600),
            ],
          ),
        ),
      ),
    );
  }
} 