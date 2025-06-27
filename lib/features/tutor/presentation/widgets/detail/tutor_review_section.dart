import 'package:flutter/material.dart';
import 'package:fitkle/core/theme/app_colors.dart';
import 'package:fitkle/core/theme/app_text_styles.dart';
import 'package:fitkle/features/tutor/domain/entities/tutor_models.dart';

class TutorReviewSection extends StatelessWidget {
  final Tutor tutor;

  const TutorReviewSection({super.key, required this.tutor});

  @override
  Widget build(BuildContext context) {
    if (tutor.reviews.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 48.0),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.rate_review_outlined,
                  size: 48.0, color: AppColors.grayLight),
              const SizedBox(height: 16.0),
              Text('아직 작성된 리뷰가 없어요.',
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
          Text(tutor.reviewSummaryTitle,
              style: AppTextStyles.sliderSectionTitleStyleDesktop),
          const SizedBox(height: 24.0),
          _buildReviewSummary(context, tutor.averageRating, tutor.reviewSummary),
          const SizedBox(height: 40.0),
          _buildReviewList(tutor.reviews),
        ],
      ),
    );
  }

  Widget _buildReviewSummary(
      BuildContext context, double averageRating, ReviewSummary summary) {
    int totalRatings =
        summary.ratingDistribution.values.fold(0, (prev, e) => prev + e);

    Widget summaryBox = Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(averageRating.toStringAsFixed(1),
                    style:
                        const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Icon(
                      index < averageRating.floor()
                          ? Icons.star
                          : (index < averageRating
                              ? Icons.star_half
                              : Icons.star_border),
                      color: Colors.amber,
                      size: 22.0,
                    );
                  }),
                ),
                const SizedBox(height: 8.0),
                Text('$totalRatings개 리뷰',
                    style: AppTextStyles.productNameStyleMobile
                        .copyWith(color: AppColors.grayDark)),
              ],
            ),
          ),
          const SizedBox(width: 24.0),
          Expanded(
            flex: 3,
            child: Column(
              children: List.generate(5, (index) {
                final star = 5 - index;
                final count = summary.ratingDistribution[star] ?? 0;
                return _buildRatingBar(star, count, totalRatings);
              }).toList(),
            ),
          ),
        ],
      ),
    );

    if (summary.tags.isNotEmpty) {
      return Column(
        children: [
          summaryBox,
          const SizedBox(height: 20.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            alignment: WrapAlignment.center,
            children: summary.tags
                .map((tag) => Chip(
                      label: Text(tag),
                      labelStyle:
                          AppTextStyles.keywordChipTextStyleMobile.copyWith(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                      backgroundColor: Colors.grey[200],
                      side: BorderSide.none,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 5.0),
                      shape: const StadiumBorder(),
                    ))
                .toList(),
          )
        ],
      );
    }

    return summaryBox;
  }

  Widget _buildRatingBar(int star, int count, int total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Text('$star점', style: AppTextStyles.productNameStyleMobile),
          const SizedBox(width: 8.0),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: LinearProgressIndicator(
                value: total > 0 ? count / total : 0,
                minHeight: 10.0,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            '$count',
            style: AppTextStyles.productNameStyleMobile
                .copyWith(color: AppColors.grayDark),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Widget _buildReviewList(List<dynamic> reviews) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index] as Review;
        return _buildReviewItem(review);
      },
      separatorBuilder: (context, index) => const Divider(height: 48.0),
    );
  }

  Widget _buildReviewItem(Review review) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24.0,
              backgroundImage: NetworkImage(review.reviewerProfileImageUrl),
            ),
            const SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(review.reviewer,
                    style: AppTextStyles.productNameStyleDesktop
                        .copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    ...List.generate(
                        5,
                        (i) => Icon(
                            i < review.rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 18.0)),
                    const SizedBox(width: 8.0),
                    Text(_formatDate(review.date),
                        style: AppTextStyles.productNameStyleMobile
                            .copyWith(color: Colors.black54)),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(review.comment,
            style: AppTextStyles.productNameStyleDesktop
                .copyWith(color: Colors.black87)),
        const SizedBox(height: 12.0),
        if (review.imageUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(review.imageUrl!,
                height: 200.0, width: double.infinity, fit: BoxFit.cover),
          ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}.${date.month}.${date.day}';
  }
} 