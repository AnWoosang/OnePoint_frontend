import 'package:flutter/material.dart';
import 'package:one_point/core/theme/app_text_styles.dart';

class PopularServiceSection extends StatelessWidget {
  const PopularServiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: 데이터 모델을 만들고 mock 데이터로 교체해야 합니다.
    final popularServices = List.generate(10, (index) => {
      'title': '서비스 제목 ${index + 1}',
      'image_url': 'https://picsum.photos/seed/service${index}/150/150',
      'category': '카테고리 ${index % 3}',
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '핏클 인기 서비스',
                style: AppTextStyles.sliderSectionTitleStyleDesktop,
              ),
              TextButton(
                onPressed: () {
                  // TODO: 인기 서비스 전체보기 페이지로 이동
                },
                child: Text(
                  '전체보기 >',
                  style: AppTextStyles.productNameStyleDesktop.copyWith(color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220, // 카드 높이에 맞게 조절
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popularServices.length,
              itemBuilder: (context, index) {
                final service = popularServices[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SizedBox(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              service['image_url']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          service['title']!,
                          style: AppTextStyles.productNameStyleDesktop,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          service['category']!,
                          style: AppTextStyles.logoActionTextCompact.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 