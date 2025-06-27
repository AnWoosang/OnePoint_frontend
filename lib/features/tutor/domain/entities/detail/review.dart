class Review {
  final String id;
  final String reviewer;
  final String reviewerProfileImageUrl;
  final String comment;
  final int rating;
  final DateTime date;
  final String? imageUrl;
  final List<String> tags;

  Review({
    required this.id,
    required this.reviewer,
    required this.reviewerProfileImageUrl,
    required this.comment,
    required this.rating,
    required this.date,
    this.imageUrl,
    this.tags = const [],
  });
} 