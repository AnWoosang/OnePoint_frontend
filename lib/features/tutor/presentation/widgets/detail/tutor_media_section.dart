import 'package:flutter/material.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/features/tutor/domain/entities/tutor_models.dart';
import 'package:one_point/features/tutor/presentation/widgets/detail/image_viewer_dialog.dart';

class TutorMediaSection extends StatelessWidget {
  final Tutor tutor;

  const TutorMediaSection({
    super.key,
    required this.tutor,
  });

  @override
  Widget build(BuildContext context) {
    if (tutor.mediaUrls.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('사진 및 동영상', style: AppTextStyles.sliderSectionTitleStyleDesktop),
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
            itemCount: tutor.mediaUrls.length,
            itemBuilder: (context, index) {
              final url = tutor.mediaUrls[index];
              return GestureDetector(
                onTap: () => showImageViewerDialog(context, tutor.mediaUrls, index),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(url, fit: BoxFit.cover),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
} 