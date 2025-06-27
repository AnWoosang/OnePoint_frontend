import 'package:flutter/material.dart';
import 'package:fitkle/features/tutor/data/dto/tutor_dto.dart';
import 'package:fitkle/features/tutor/domain/entities/tutor_models.dart';

// Main DTO to Model Mapper Extension
extension TutorDTOMapper on TutorDTO {
  Tutor toModel() {
    IconData? getIconFromString(String? iconString) {
      switch (iconString) {
        case 'star': return Icons.star;
        case 'person_outline': return Icons.person_outline;
        case 'access_time': return Icons.access_time;
        case 'business_center_outlined': return Icons.business_center_outlined;
        default: return null;
      }
    }

    InfoItem infoItemFromDto(InfoItemDTO dto) => InfoItem(label: dto.label, value: dto.value, icon: getIconFromString(dto.icon));
    PortfolioItem portfolioItemFromDto(PortfolioItemDTO dto) => PortfolioItem(
      id: dto.id,
      title: dto.title,
      imageUrls: dto.imageUrls,
      serviceType: dto.serviceType,
      region: dto.region,
      price: dto.price,
      duration: dto.duration,
      year: dto.year,
      description: dto.description,
    );
    Review reviewFromDto(Map<String, dynamic> dto) {
      final id = dto['id'];
      if (id == null) {
        throw ArgumentError('Review id is required');
      }
      return Review(
        id: id.toString(),
        reviewer: dto['reviewer'] ?? '익명',
        reviewerProfileImageUrl: dto['reviewerProfileImageUrl'] ?? 'https://picsum.photos/seed/default_user/100/100',
        rating: (dto['rating'] as num?)?.toInt() ?? 0,
        comment: dto['comment'] ?? '',
        date: DateTime.tryParse(dto['date'] ?? '') ?? DateTime.now(),
        tags: List<String>.from(dto['tags'] ?? []),
        imageUrl: dto['imageUrl'],
      );
    }
    QnaItem qnaItemFromDto(Map<String, dynamic> dto) => QnaItem(question: dto['question'] ?? '', answer: dto['answer'] ?? '');
    CareerItem careerItemFromDto(CareerItemDTO dto) => CareerItem(title: dto.title, startDate: dto.startDate, endDate: dto.endDate);
    ServiceItem serviceItemFromDto(ServiceItemDTO dto) => ServiceItem(name: dto.name);
    FeatureItem featureItemFromDto(FeatureItemDTO dto) => FeatureItem(icon: dto.icon, description: dto.description);
    ReviewSummary reviewSummaryFromDto(ReviewSummaryDTO dto) => ReviewSummary(
      ratingDistribution: dto.ratingDistribution.map((key, value) => MapEntry(int.parse(key), value)),
      tags: dto.tags,
    );
    return Tutor(
      id: id,
      name: name,
      profileImageUrl: profileImageUrl,
      headerImageUrl: (portfolio?.isNotEmpty == true && portfolio!.first.imageUrls.isNotEmpty)
        ? portfolio!.first.imageUrls.first
        : 'https://picsum.photos/seed/default/800/400',
      shortIntro: shortIntro,
      descriptionTitle: descriptionTitle ?? '서비스 상세 설명',
      descriptionText: descriptionText ?? '상세 설명이 없습니다.',
      certificateTitle: certificateTitle ?? '자격증 및 기타 서류',
      certificateImageUrls: certificateImageUrls ?? <String>[],
      averageRating: (averageRating as num?)?.toDouble() ?? 0.0,
      totalLessons: (totalLessons as num?)?.toInt() ?? 0,
      careerYears: (careerYears as num?)?.toInt(),
      statsItems: (statsItems?.map(infoItemFromDto).toList()) ?? <InfoItem>[],
      infoItems: (infoItems?.map(infoItemFromDto).toList()) ?? <InfoItem>[],
      portfolio: (portfolio?.map(portfolioItemFromDto).toList()) ?? <PortfolioItem>[],
      reviewSummaryTitle: '리뷰 ${reviews?.length ?? 0}개',
      reviews: (reviews?.map(reviewFromDto).toList()) ?? <Review>[],
      qnaItems: (qnaList?.map(qnaItemFromDto).toList()) ?? <QnaItem>[],
      tags: tags,
      region: region,
      features: (features?.map(featureItemFromDto).toList()) ?? <FeatureItem>[],
      services: (services?.map(serviceItemFromDto).toList()) ?? <ServiceItem>[],
      careers: (careers?.map(careerItemFromDto).toList()) ?? <CareerItem>[],
      mediaUrls: certificateImageUrls ?? <String>[],
      reviewSummary: reviewSummary != null ? reviewSummaryFromDto(reviewSummary!) : ReviewSummary(ratingDistribution: {}, tags: []),
    );
  }
}
