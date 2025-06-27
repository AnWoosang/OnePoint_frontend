class ReviewSummary {
  final double averageRating;
  final int totalReviews;
  final Map<int, int> ratingDistribution;
  final List<String> tags;

  ReviewSummary({
    this.averageRating = 0.0,
    this.totalReviews = 0,
    this.ratingDistribution = const {},
    this.tags = const [],
  });
} 