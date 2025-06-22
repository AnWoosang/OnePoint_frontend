class AverageReviewInfo {
  final int totalReviewCount;
  final double rating;       // 평균 평점
  final double sweetness;    // 평균 당도
  final double menthol;      // 평균 멘솔 정도
  final double body;         // 평균 바디감 정도
  final double throatHit;    // 평균 목긁음 정도
  final double freshness;    // 평균 상쾌함 정도

  AverageReviewInfo({
    required this.totalReviewCount,
    required this.rating,
    required this.sweetness,
    required this.menthol,
    required this.body,
    required this.throatHit,
    required this.freshness
  });
}