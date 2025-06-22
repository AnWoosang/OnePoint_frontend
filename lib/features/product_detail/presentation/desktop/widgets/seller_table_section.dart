import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/core/theme/app_text_styles.dart';
import 'package:one_point/features/product_detail/data/models/seller_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:one_point/core/utils/format.dart';

class SellerTableSection extends StatelessWidget {
  final List<SellerInfo> sellers;
  final bool includeShipping;
  final ValueChanged<bool> onToggleIncludeShipping;

  const SellerTableSection({
    super.key,
    required this.sellers,
    required this.includeShipping,
    required this.onToggleIncludeShipping,
  });

  void _launchSellerUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  List<SellerInfo> _sortedSellers() {
    final sorted = [...sellers];
    if (includeShipping) {
      sorted.sort((a, b) => (a.price + a.shippingFee).compareTo(b.price + b.shippingFee));
    } else {
      sorted.sort((a, b) => a.price.compareTo(b.price));
    }
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final sortedSellers = _sortedSellers();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('최저가순', style: AppTextStyles.sellerBoxTextStyleDesktop),
            Row(
              children: [
                Text('배송비 포함', style: AppTextStyles.sellerBoxTextStyleDesktop),
                SizedBox(width: 2.w),

                GestureDetector(
                  onTap: () => onToggleIncludeShipping(!includeShipping),
                  child: Container(
                    width: 13.w, // ✅ 가로 길이 늘리기
                    height: 20.h, // ✅ 세로 길이 줄이기
                    decoration: BoxDecoration(
                      color: includeShipping ? AppColors.primary : AppColors.gray,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedAlign(
                          duration: Duration(milliseconds: 200),
                          alignment: includeShipping ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            width: 2.w,
                            height: 20.h,
                            margin: EdgeInsets.symmetric(horizontal: 2.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            includeShipping ? 'ON' : 'OFF',
                            style: TextStyle(
                              fontSize: 2.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 25.h),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.divider),
          ),
          child: Column(
            children: [
              Container(
                color: AppColors.grayLighter,
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Align(alignment: Alignment.centerLeft, child: Text('판매처', style: AppTextStyles.sellerBoxTextStyleDesktop))),
                    Expanded(flex: 2, child: Align(alignment: Alignment.center, child: Text(includeShipping ? '배송비 포함가' : '판매가', style: AppTextStyles.sellerBoxTextStyleDesktop))),
                    Expanded(flex: 2, child: Align(alignment: Alignment.center, child: Text('배송비', style: AppTextStyles.sellerBoxTextStyleDesktop))),
                    Expanded(flex: 2, child: Align(alignment: Alignment.center, child: Text('구매', style: AppTextStyles.sellerBoxTextStyleDesktop))),
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 300.h),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: sortedSellers.length,
                  itemBuilder: (context, index) {
                    final seller = sortedSellers[index];
                    final isLowest = index == 0;
                    final priceText = includeShipping
                        ? '${formatPrice(seller.price + seller.shippingFee)}원'
                        : '${formatPrice(seller.price)}원';

                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
                      decoration: const BoxDecoration(
                        border: Border(top: BorderSide(color: AppColors.divider, width: 0.5)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () => _launchSellerUrl(seller.url),
                                  child: Text(
                                    seller.name,
                                    style: AppTextStyles.sellerBoxTextStyleDesktop.copyWith(
                                      decoration: TextDecoration.none, // ✅ 밑줄 제거
                                      color: AppColors.black, // 선택적으로 강조 색상 지정 가능
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2, 
                            child: Align(
                              alignment: Alignment.center, 
                              child: Text(
                                  isLowest ? '최저 $priceText' : priceText,
                                  style: AppTextStyles.sellerBoxTextStyleDesktop.copyWith(color: isLowest ? AppColors.red : AppColors.black)
                              )
                            )
                          ),
                          Expanded(
                            flex: 2, 
                            child: Align(
                              alignment: Alignment.center, 
                              child: Text(
                                seller.shippingFee == 0 ? '무료' : '${formatPrice(seller.shippingFee)}원', 
                                style: AppTextStyles.sellerBoxTextStyleDesktop
                              )
                            )
                          ),
                          Expanded(
                            flex: 2, 
                            child: Align(
                              alignment: Alignment.center, 
                              child: ElevatedButton(
                                onPressed: () => _launchSellerUrl(seller.url), 
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.grayLighter, 
                                  foregroundColor: AppColors.gray, padding: 
                                  EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h), 
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide( // ✅ 테두리 설정
                                      color: AppColors.divider,
                                      width: 1.0,
                                    ),
                                    
                                  ),
                                  elevation: 0,
                                ), 
                                child: Text(
                                  '사러가기', style: AppTextStyles.sellerBoxTextStyleDesktop.copyWith(
                                    fontSize: 2.5.sp
                                  )
                                )
                              )
                            )
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}