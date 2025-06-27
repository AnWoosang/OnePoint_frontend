class PortfolioItem {
  final String id;
  final String title;
  final List<String> imageUrls;
  final String? serviceType;
  final String? region;
  final int? price;
  final String? duration;
  final int? year;
  final String? description;

  PortfolioItem({
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
} 