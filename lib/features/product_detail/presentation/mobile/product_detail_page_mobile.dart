import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/features/product_detail/data/models/product_detail.dart';
import 'package:one_point/features/product_detail/data/models/review.dart';

class ProductDetailPageMobile extends StatelessWidget {
  final ProductDetail product;

  const ProductDetailPageMobile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProductThumbnail(url: product.thumbnailUrl),
            SizedBox(height: 16.h),
            _ProductBasicInfo(product: product),
            SizedBox(height: 20.h),
            _SellerList(sellers: product.sellers),
            SizedBox(height: 24.h),
            _ReviewSection(reviews: product.reviews, averageReviewInfo: product.averageReviewInfo),
          ],
        ),
      ),
    );
  }
}

class _ProductThumbnail extends StatelessWidget {
  final String url;
  const _ProductThumbnail({required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: double.infinity,
      height: 250.h,
      fit: BoxFit.cover,
    );
  }
}

class _ProductBasicInfo extends StatelessWidget {
  final ProductDetail product;
  const _ProductBasicInfo({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.name, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 6.h),
        Text('맛: ${product.flavor} / 용량: ${product.capacity}'),
        Text('호흡 방식: ${product.inhaleType}'),
        Text('카테고리: ${product.productCategory.name}'),
        SizedBox(height: 12.h),
        Text('⭐ 평균 평점: ${product.averageReviewInfo.rating.toStringAsFixed(1)} '
            '(${product.averageReviewInfo.totalReviewCount}개 리뷰)'),
        Text('당도: ${product.averageReviewInfo.sweetness}, 멘솔: ${product.averageReviewInfo.menthol}, '
            '목긁음: ${product.averageReviewInfo.throatHit}'),
      ],
    );
  }
}

class _SellerList extends StatelessWidget {
  final List sellers;
  const _SellerList({required this.sellers});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('🛒 판매처', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        ...sellers.map((s) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(s.name),
                  Text('${s.price}원 + 배송비 ${s.shippingFee}원'),
                ],
              ),
            )),
      ],
    );
  }
}

class _ReviewSection extends StatelessWidget {
  final List<Review> reviews;
  final dynamic averageReviewInfo;
  const _ReviewSection({required this.reviews, required this.averageReviewInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('💬 리뷰', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        Text('⭐ 평균 평점: ${averageReviewInfo.rating.toStringAsFixed(1)} '
            '(${averageReviewInfo.totalReviewCount}개 리뷰)'),
        Text('당도: ${averageReviewInfo.sweetness}, 멘솔: ${averageReviewInfo.menthol}, '
            '목긁음: ${averageReviewInfo.throatHit}'),
        ...reviews.map((r) => _ReviewItem(review: r)),
      ],
    );
  }
}

class _ReviewItem extends StatelessWidget {
  final Review review;
  const _ReviewItem({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${review.nickname} • ${review.createdAt.toLocal().toString().split(" ").first}',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 6.h),
          Text(review.content),
          SizedBox(height: 8.h),
          Text('당도: ${review.sweetness}, 멘솔: ${review.menthol}, 목긁음: ${review.throatHit}, 바디감: ${review.body}, 상큼함: ${review.freshness}'),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: review.imageUrls
                .map((img) => ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: Image.network(img, width: 80.w, height: 80.w, fit: BoxFit.cover),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}