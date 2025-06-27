import 'package:flutter/material.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/features/tutor/domain/entities/tutor_models.dart';
import 'package:one_point/features/tutor/presentation/widgets/detail/portfolio_detail_dialog.dart';

class TutorPortfolioSection extends StatelessWidget {
  final Tutor tutor;

  const TutorPortfolioSection({
    super.key,
    required this.tutor,
  });

  @override
  Widget build(BuildContext context) {
    if (tutor.portfolio.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('포트폴리오', style: AppTextStyles.sliderSectionTitleStyleDesktop),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.0,
            ),
            itemCount: tutor.portfolio.length,
            itemBuilder: (context, index) {
              final item = tutor.portfolio[index];
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => PortfolioDetailDialog(portfolioItem: item),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (item.imageUrls.isNotEmpty)
                        Image.network(
                          item.imageUrls.first,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
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
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        right: 8,
                        child: Text(
                          item.title,
                          style: AppTextStyles.productNameStyleDesktop.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
} 