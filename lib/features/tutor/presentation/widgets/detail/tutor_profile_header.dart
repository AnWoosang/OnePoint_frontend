import 'package:flutter/material.dart';
import 'package:fitkle/core/theme/app_text_styles.dart';
import 'package:fitkle/features/tutor/domain/entities/tutor_models.dart';

class TutorProfileHeader extends StatelessWidget {
  final Tutor tutor;
  final VoidCallback onFavorite;
  final VoidCallback onShare;

  const TutorProfileHeader({
    super.key,
    required this.tutor,
    required this.onFavorite,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          tutor.headerImageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 60, color: Colors.grey),
            );
          },
        ),
        // Add a subtle scrim for text readability
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black45],
              stops: [0.5, 1.0],
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: NetworkImage(tutor.profileImageUrl),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tutor.name,
                          style: AppTextStyles.sliderSectionTitleStyleMobile,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          tutor.shortIntro,
                          style: AppTextStyles.searchPageTitleStyleMobile,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Text(tutor.region ?? '활동 지역 미입력', style: const TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
              const SizedBox(height: 12),
              if (tutor.tags?.isNotEmpty ?? false)
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: tutor.tags!
                      .map((tag) => Chip(
                            label: Text(tag),
                            labelStyle: AppTextStyles.keywordChipTextStyleMobile.copyWith(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                            backgroundColor: Colors.grey[200],
                            side: BorderSide.none,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 4.0),
                          ))
                      .toList(),
                ),
            ],
          ),
        ),
      ],
    );
  }
} 