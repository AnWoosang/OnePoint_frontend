import 'package:flutter/material.dart';
import 'package:one_point/core/theme/app_text_styles.dart';

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: 데이터 모델을 만들고 mock 데이터로 교체해야 합니다.
    final portfolios = List.generate(10, (index) => {
      'title': '포트폴리오 ${index + 1}',
      'image_url': 'https://picsum.photos/seed/portfolio${index}/200/200',
      'expert': '고수 이름 ${index + 1}',
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
                '숨은 고수 포트폴리오',
                style: AppTextStyles.sliderSectionTitleStyleDesktop,
              ),
              TextButton(
                onPressed: () {
                  // TODO: 포트폴리오 전체보기 페이지로 이동
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
            height: 260, // 카드 높이에 맞게 조절
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: portfolios.length,
              itemBuilder: (context, index) {
                final portfolio = portfolios[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SizedBox(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  portfolio['image_url']!,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.7),
                                      ],
                                      stops: const [0.5, 1.0],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  left: 8,
                                  right: 8,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        portfolio['title']!,
                                        style: AppTextStyles.productNameStyleDesktop.copyWith(color: Colors.white),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        portfolio['expert']!,
                                        style: AppTextStyles.logoActionTextCompact.copyWith(color: Colors.white.withOpacity(0.8)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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