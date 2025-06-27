import 'package:one_point/features/tutor/domain/entities/tutor_models.dart';

class Tutor {
  final String id;
  final String name;
  final String profileImageUrl;
  final String headerImageUrl;
  final String shortIntro;
  final String descriptionTitle;
  final String descriptionText;
  final String certificateTitle;
  final List<String> certificateImageUrls;
  final double averageRating;
  final int totalLessons;
  final int? careerYears;
  final List<InfoItem> statsItems;
  final List<InfoItem> infoItems;
  final List<PortfolioItem> portfolio;
  final String reviewSummaryTitle;
  final ReviewSummary reviewSummary;
  final List<Review> reviews;
  final List<QnaItem> qnaItems;
  final List<String>? tags;
  final String? region;
  final List<FeatureItem> features;
  final List<ServiceItem> services;
  final List<CareerItem> careers;
  final List<String> mediaUrls;

  Tutor({
    required this.id,
    required this.name,
    required this.profileImageUrl,
    required this.headerImageUrl,
    required this.shortIntro,
    required this.descriptionTitle,
    required this.descriptionText,
    required this.certificateTitle,
    required this.certificateImageUrls,
    required this.averageRating,
    required this.totalLessons,
    this.careerYears,
    required this.statsItems,
    required this.infoItems,
    required this.portfolio,
    required this.reviewSummaryTitle,
    required this.reviewSummary,
    required this.reviews,
    required this.qnaItems,
    this.tags,
    this.region,
    required this.features,
    required this.services,
    required this.careers,
    required this.mediaUrls,
  });
} 