class Review {
  final String nickname;              // 사용자 닉네임
  final DateTime createdAt;           // 작성일 (LocalDateTime)
  final String content;               // 리뷰 내용
  final double sweetness;             // 단맛 평가
  final double menthol;               // 멘솔 평가
  final double throatHit;             // 목긁음 평가
  final double body;                  // 바디감 평가
  final double freshness;             // 상큼함 평가

  final List<String> imageUrls;       // 첨부된 이미지 URL 리스트

  Review({
    required this.nickname,
    required this.createdAt,
    required this.content,
    required this.sweetness,
    required this.menthol,
    required this.throatHit,
    required this.body,
    required this.freshness,
    required this.imageUrls,
  });
}