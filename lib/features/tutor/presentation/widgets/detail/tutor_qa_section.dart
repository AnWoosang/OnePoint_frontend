import 'package:flutter/material.dart';
import 'package:fitkle/core/theme/app_colors.dart';
import 'package:fitkle/core/theme/app_text_styles.dart';
import 'package:fitkle/features/tutor/domain/entities/tutor_models.dart';

class TutorQaSection extends StatelessWidget {
  final Tutor tutor;

  const TutorQaSection({super.key, required this.tutor});

  @override
  Widget build(BuildContext context) {
    if (tutor.qnaItems.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 48.0),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.question_answer_outlined,
                  size: 48.0, color: AppColors.grayLight),
              const SizedBox(height: 16.0),
              Text('아직 작성된 Q&A가 없어요.',
                  style: AppTextStyles.searchPageRecentWordStyleMobile),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Q&A', style: AppTextStyles.sliderSectionTitleStyleDesktop),
          const SizedBox(height: 20.0),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tutor.qnaItems.length,
            itemBuilder: (context, index) {
              final qna = tutor.qnaItems[index];
              return _buildQnaItem(qna);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16.0),
          ),
        ],
      ),
    );
  }

  Widget _buildQnaItem(QnaItem qna) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question part
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Q.',
                    style: AppTextStyles.sliderSectionTitleStyleDesktop
                        .copyWith(color: AppColors.primary)),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    qna.question,
                    style: AppTextStyles.productNameStyleDesktop
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
              height: 1, thickness: 1, indent: 16.0, endIndent: 16.0),
          // Answer part
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('A.',
                    style: AppTextStyles.sliderSectionTitleStyleDesktop
                        .copyWith(color: Colors.grey[600])),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    qna.answer,
                    style: AppTextStyles.productNameStyleDesktop
                        .copyWith(height: 1.5, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 