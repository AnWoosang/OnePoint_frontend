class SellerInfo {
  final String name;
  final int price;
  final int shippingFee; // ✅ 추가
  final String url;

  SellerInfo({
    required this.name,
    required this.price,
    required this.shippingFee, // ✅ 필수
    required this.url,
  });
}