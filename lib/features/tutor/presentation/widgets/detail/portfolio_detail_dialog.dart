import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fitkle/core/theme/app_colors.dart';
import 'package:fitkle/core/theme/app_text_styles.dart';
import 'package:fitkle/features/tutor/domain/entities/tutor_models.dart';

class PortfolioDetailDialog extends StatefulWidget {
  final PortfolioItem portfolioItem;

  const PortfolioDetailDialog({super.key, required this.portfolioItem});

  @override
  State<PortfolioDetailDialog> createState() => _PortfolioDetailDialogState();
}

class _PortfolioDetailDialogState extends State<PortfolioDetailDialog> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: isMobile ? 16.0 : 40.0, vertical: 24.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: isMobile
            ? const BoxConstraints(maxWidth: 600, maxHeight: 800)
            : const BoxConstraints(maxWidth: 1000, maxHeight: 600),
        child: Stack(
          children: [
            isMobile
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 이미지 컨테이너 고정 높이 (비율 유지)
                      SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: _buildImageCarousel(),
                      ),
                      Expanded(child: _buildDetailsPanel()),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: _buildImageCarousel()),
                      Expanded(flex: 4, child: _buildDetailsPanel()),
                    ],
                  ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.black87),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.grayLighter,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.portfolioItem.imageUrls.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: Image.network(
                  widget.portfolioItem.imageUrls[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          if (widget.portfolioItem.imageUrls.length > 1)
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          if (widget.portfolioItem.imageUrls.length > 1)
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                onPressed: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailsPanel() {
    final item = widget.portfolioItem;
    final currencyFormat = NumberFormat.currency(locale: 'ko_KR', symbol: '₩');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.title, style: AppTextStyles.sliderSectionTitleStyleDesktop),
          const SizedBox(height: 24),
          if (item.serviceType != null)
            _buildInfoRow('서비스 종류', item.serviceType!),
          if (item.region != null)
            _buildInfoRow('지역 정보', item.region!),
          if (item.price != null)
            _buildInfoRow('가격대', currencyFormat.format(item.price)),
          if (item.duration != null)
            _buildInfoRow('작업 소요 시간', item.duration!),
          if (item.year != null)
            _buildInfoRow('작업 년도', item.year.toString()),
          const SizedBox(height: 16),
          const Divider(color: AppColors.grayLight),
          const SizedBox(height: 16),
          if (item.description != null)
            Text(
              item.description!,
              style: AppTextStyles.productNameStyleDesktop.copyWith(color: AppColors.grayDark),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTextStyles.productNameStyleDesktop.copyWith(color: AppColors.gray),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.productNameStyleDesktop.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
} 