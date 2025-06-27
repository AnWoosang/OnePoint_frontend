import 'dart:io';

/// 튜터 프로필 설정 폼 데이터
class TutorProfileForm {
  String? name;
  String? shortIntro;
  String? region;
  List<String> tags;
  File? headerImage;
  String? headerImageUrl; // 기존 이미지 URL (수정 시)
  
  TutorProfileForm({
    this.name,
    this.shortIntro,
    this.region,
    this.tags = const [],
    this.headerImage,
    this.headerImageUrl,
  });

  /// 폼 데이터가 유효한지 검증
  bool get isValid {
    return name != null && 
           name!.trim().isNotEmpty &&
           shortIntro != null && 
           shortIntro!.trim().isNotEmpty &&
           region != null &&
           region!.trim().isNotEmpty;
  }

  /// 폼 데이터를 JSON으로 변환 (API 전송용)
  Map<String, dynamic> toJson() {
    return {
      'name': name?.trim(),
      'shortIntro': shortIntro?.trim(),
      'region': region?.trim(),
      'tags': tags,
      'headerImageUrl': headerImageUrl,
    };
  }

  /// 기존 튜터 데이터로부터 폼 초기화 (수정 모드)
  factory TutorProfileForm.fromExisting({
    required String name,
    required String shortIntro,
    required String region,
    required List<String> tags,
    required String headerImageUrl,
  }) {
    return TutorProfileForm(
      name: name,
      shortIntro: shortIntro,
      region: region,
      tags: List.from(tags),
      headerImageUrl: headerImageUrl,
    );
  }

  TutorProfileForm copyWith({
    String? name,
    String? shortIntro,
    String? region,
    List<String>? tags,
    File? headerImage,
    String? headerImageUrl,
  }) {
    return TutorProfileForm(
      name: name ?? this.name,
      shortIntro: shortIntro ?? this.shortIntro,
      region: region ?? this.region,
      tags: tags ?? this.tags,
      headerImage: headerImage ?? this.headerImage,
      headerImageUrl: headerImageUrl ?? this.headerImageUrl,
    );
  }
} 