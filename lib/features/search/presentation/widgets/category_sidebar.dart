import 'package:flutter/material.dart';

class CategorySidebar extends StatelessWidget {
  final List<String> categories;
  final String? selectedCategory;
  final ValueChanged<String>? onCategorySelected;

  const CategorySidebar({
    super.key,
    required this.categories,
    this.selectedCategory,
    this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: Colors.transparent,
      padding: const EdgeInsets.only(top: 24, left: 32, right: 24, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('카테고리', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 20),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...categories.map((cat) => _CategoryItem(
                    text: cat,
                    selected: selectedCategory == cat,
                    onTap: () => onCategorySelected?.call(cat),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatefulWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;
  const _CategoryItem({required this.text, required this.selected, required this.onTap});
  @override
  State<_CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<_CategoryItem> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    final color = widget.selected
        ? Colors.blue.shade50
        : _hover
            ? Colors.grey.shade100
            : Colors.transparent;
    final textColor = widget.selected
        ? Colors.blue
        : _hover
            ? Colors.black
            : Colors.grey[800];
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          margin: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: widget.selected ? FontWeight.bold : FontWeight.normal,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
} 