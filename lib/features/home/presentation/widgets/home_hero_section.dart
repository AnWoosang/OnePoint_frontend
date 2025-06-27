import 'package:flutter/material.dart';
import 'package:fitkle/core/theme/app_text_styles.dart';
import 'package:fitkle/core/theme/app_colors.dart';

class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      alignment: Alignment.center,
      child: Column(
        children: [
          // Title
          Text(
            '당신에게 핏한 쪽집게 레슨',
            style: AppTextStyles.logoTitleDesktop.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 30),

          // Search Bar
          Container(
            width: 500,
            height: 48.0,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.grayLighter,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppColors.grayLight),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Icon(Icons.search, size: 20, color: AppColors.gray),
                ),
                Expanded(
                  child: Transform.translate(
                    offset: const Offset(0, -4.0),
                    child: TextField(
                      style: AppTextStyles.homeHeroSearchInputStyle,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        hintText: '어떤 서비스가 필요하세요?',
                        hintStyle: AppTextStyles.homeHeroSearchHintStyle,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Category Icons
          _buildCategoryIcons(),
        ],
      ),
    );
  }

  Widget _buildCategoryIcons() {
    final categories = [
      {'icon': Icons.apps, 'label': '전체보기'},
      {'icon': Icons.local_shipping, 'label': '이사/청소'},
      {'icon': Icons.build, 'label': '설치/수리'},
      {'icon': Icons.chair, 'label': '인테리어'},
      {'icon': Icons.work_outline, 'label': '외주'},
      {'icon': Icons.event, 'label': '이벤트/뷰티'},
      {'icon': Icons.school, 'label': '취업/직무'},
      {'icon': Icons.lightbulb, 'label': '과외'},
      {'icon': Icons.sports_basketball, 'label': '취미/자기계발'},
      {'icon': Icons.directions_car, 'label': '자동차'},
      {'icon': Icons.book, 'label': '법률/금융'},
      {'icon': Icons.checkroom, 'label': '기타'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categories.map((category) {
        return Expanded(
          child: Column(
            children: [
              Icon(category['icon'] as IconData, size: 24, color: Colors.primaries[categories.indexOf(category) % Colors.primaries.length]),
              const SizedBox(height: 8),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  category['label'] as String,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.homeHeroCategoryLabelStyle,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
} 