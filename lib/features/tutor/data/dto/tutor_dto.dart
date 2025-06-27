class InfoItemDTO {
  final String label;
  final String value;
  final String? icon;

  InfoItemDTO({required this.label, required this.value, this.icon});

  factory InfoItemDTO.fromJson(Map<String, dynamic> json) {
    return InfoItemDTO(
      label: json['label'],
      value: json['value'],
      icon: json['icon'],
    );
  }
}

class ServiceItemDTO {
  final String name;
  ServiceItemDTO({required this.name});
  factory ServiceItemDTO.fromJson(Map<String, dynamic> json) => ServiceItemDTO(name: json['name']);
}

class FeatureItemDTO {
  final String icon;
  final String description;
  FeatureItemDTO({required this.icon, required this.description});
  factory FeatureItemDTO.fromJson(Map<String, dynamic> json) => FeatureItemDTO(icon: json['icon'], description: json['description']);
}

class CareerItemDTO {
  final String title;
  final String? startDate;
  final String? endDate;
  CareerItemDTO({required this.title, this.startDate, this.endDate});
  factory CareerItemDTO.fromJson(Map<String, dynamic> json) => CareerItemDTO(
    title: json['title'],
    startDate: json['startDate'],
    endDate: json['endDate'],
  );
}

class ReviewSummaryDTO {
  final Map<String, int> ratingDistribution;
  final List<String> tags;
  ReviewSummaryDTO({required this.ratingDistribution, required this.tags});
  factory ReviewSummaryDTO.fromJson(Map<String, dynamic> json) => ReviewSummaryDTO(
        ratingDistribution: Map<String, int>.from(json['ratingDistribution']),
        tags: List<String>.from(json['tags']),
      );
}

class PortfolioItemDTO {
  final String id;
  final String title;
  final List<String> imageUrls;
  final String? serviceType;
  final String? region;
  final int? price;
  final String? duration;
  final int? year;
  final String? description;

  PortfolioItemDTO({
    required this.id,
    required this.title,
    required this.imageUrls,
    this.serviceType,
    this.region,
    this.price,
    this.duration,
    this.year,
    this.description,
  });

  factory PortfolioItemDTO.fromJson(Map<String, dynamic> json) {
    return PortfolioItemDTO(
      id: json['id'],
      title: json['title'],
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      serviceType: json['serviceType'],
      region: json['region'],
      price: json['price'],
      duration: json['duration'],
      year: json['year'],
      description: json['description'],
    );
  }
}

class TutorDTO {
  final String id;
  final String name;
  final String profileImageUrl;
  final String shortIntro;
  final double? averageRating;
  final int? totalLessons;
  final int? careerYears;
  final List<String>? tags;
  final String? region;
  final String? availability;
  final List<FeatureItemDTO>? features;
  final String? descriptionText;
  final List<ServiceItemDTO>? services;
  final List<CareerItemDTO>? careers;
  final List<PortfolioItemDTO>? portfolio;
  final List<Map<String, dynamic>>? qnaList;
  final List<Map<String, dynamic>>? reviews;
  final ReviewSummaryDTO? reviewSummary;
  final List<InfoItemDTO>? statsItems;
  final List<InfoItemDTO>? infoItems;
  final String? descriptionTitle;
  final String? certificateTitle;
  final List<String>? certificateImageUrls;

  TutorDTO({
    required this.id,
    required this.name,
    required this.profileImageUrl,
    required this.shortIntro,
    this.averageRating,
    this.totalLessons,
    this.careerYears,
    this.tags,
    this.region,
    this.availability,
    this.features,
    this.descriptionText,
    this.services,
    this.careers,
    this.portfolio,
    this.qnaList,
    this.reviews,
    this.reviewSummary,
    this.statsItems,
    this.infoItems,
    this.descriptionTitle,
    this.certificateTitle,
    this.certificateImageUrls,
  });

  factory TutorDTO.fromJson(Map<String, dynamic> json) => TutorDTO(
    id: json['id'],
    name: json['name'],
    profileImageUrl: json['profileImageUrl'],
    shortIntro: json['shortIntro'],
    averageRating: json['averageRating'],
    totalLessons: json['totalLessons'],
    careerYears: json['careerYears'],
    statsItems: (json['statsItems'] as List<dynamic>?)
        ?.map((item) => InfoItemDTO.fromJson(item))
        .toList(),
    infoItems: (json['infoItems'] as List<dynamic>?)
        ?.map((item) => InfoItemDTO.fromJson(item))
        .toList(),
    descriptionTitle: json['descriptionTitle'],
    certificateTitle: json['certificateTitle'],
    certificateImageUrls: List<String>.from(json['certificateImageUrls'] ?? []),
    tags: List<String>.from(json['tags'] ?? []),
    region: json['region'],
    availability: json['availability'],
    features: (json['features'] as List<dynamic>?)?.map((item) => FeatureItemDTO.fromJson(item)).toList(),
    descriptionText: json['descriptionText'],
    services: (json['services'] as List<dynamic>?)?.map((item) => ServiceItemDTO.fromJson(item)).toList(),
    careers: (json['careers'] as List<dynamic>?)?.map((item) => CareerItemDTO.fromJson(item)).toList(),
    portfolio: (json['portfolio'] as List<dynamic>?)?.map((item) => PortfolioItemDTO.fromJson(item)).toList(),
    qnaList: List<Map<String, dynamic>>.from(json['qnaList'] ?? []),
    reviews: List<Map<String, dynamic>>.from(json['reviews'] ?? []),
    reviewSummary: json['reviewSummary'] != null ? ReviewSummaryDTO.fromJson(json['reviewSummary']) : null,
  );
}