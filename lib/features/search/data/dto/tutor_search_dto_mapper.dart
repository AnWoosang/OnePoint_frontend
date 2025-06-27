import '../dto/tutor_search_response_dto.dart';
import '../models/tutor_search_result_item.dart';

extension TutorSearchItemDtoMapper on TutorSearchItemDto {
  TutorSearchResultItem toModel() {
    return TutorSearchResultItem(
      id: id,
      name: name,
      rating: rating,
      ratingCount: ratingCount,
      employmentCount: employmentCount,
      careerYears: careerYears,
      description: description,
      profileImageUrl: profileImageUrl,
    );
  }
}

extension TutorSearchResponseDtoMapper on TutorSearchResponseDto {
  List<TutorSearchResultItem> toModelList() {
    return data.map((dto) => dto.toModel()).toList();
  }
} 