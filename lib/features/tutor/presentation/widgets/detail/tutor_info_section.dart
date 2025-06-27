import 'package:flutter/material.dart';
import 'package:fitkle/core/theme/app_colors.dart';
import 'package:fitkle/core/theme/app_text_styles.dart';
import 'package:fitkle/features/tutor/domain/entities/tutor_models.dart';
import 'package:fitkle/features/tutor/presentation/widgets/detail/image_viewer_dialog.dart';

class TutorInfoSection extends StatelessWidget {
  final Tutor tutor;

  const TutorInfoSection({super.key, required this.tutor});

  IconData? _getIconFromString(String? iconString) {
    switch (iconString) {
      case 'star':
        return Icons.star_border;
      case 'person_outline':
        return Icons.person_outline;
      case 'access_time':
        return Icons.access_time;
      case 'business_center_outlined':
        return Icons.business_center_outlined;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (tutor.infoItems.isNotEmpty) ...[
            _buildSectionTitle('기본 정보'),
            const SizedBox(height: 16.0),
            _buildInfoItems(tutor.infoItems),
            const SizedBox(height: 40.0),
          ],
          if (tutor.features.isNotEmpty) ...[
            _buildSectionTitle('서비스 특징'),
            const SizedBox(height: 16.0),
            _buildFeaturesList(tutor.features),
            const SizedBox(height: 40.0),
          ],
          _buildSectionTitle(tutor.descriptionTitle),
          const SizedBox(height: 16.0),
          Text(
            tutor.descriptionText,
            style: AppTextStyles.productNameStyleDesktop
                .copyWith(color: Colors.black87, height: 1.6),
          ),
          const SizedBox(height: 40.0),
          if (tutor.services.isNotEmpty) ...[
            _buildSectionTitle('제공 서비스'),
            const SizedBox(height: 16.0),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: tutor.services.map((s) {
                final service = s;
                return Chip(
                  label: Text(service.name),
                  labelStyle: AppTextStyles.keywordChipTextStyleMobile.copyWith(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                  backgroundColor: Colors.grey[200],
                  side: BorderSide.none,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 4.0),
                );
              }).toList(),
            ),
            const SizedBox(height: 40.0),
          ],
          if (tutor.careers.isNotEmpty) ...[
            _buildSectionTitle('경력'),
            const SizedBox(height: 20.0),
            _buildCareerTimeline(tutor.careers),
            const SizedBox(height: 20.0),
          ],
          if (tutor.certificateImageUrls.isNotEmpty) ...[
            _buildSectionTitle(tutor.certificateTitle),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 120.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tutor.certificateImageUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: () => showImageViewerDialog(
                        context,
                        tutor.certificateImageUrls,
                        index,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          tutor.certificateImageUrls[index],
                          width: 120.0,
                          height: 120.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40.0),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: AppTextStyles.sliderSectionTitleStyleDesktop);
  }

  Widget _buildInfoItems(List<dynamic> infoItems) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: infoItems.map((item) {
          final info = item as InfoItem;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Icon(info.icon, color: AppColors.grayDark, size: 20.0),
                const SizedBox(width: 16.0),
                SizedBox(
                  width: 80.0,
                  child: Text(info.label,
                      style: AppTextStyles.productNameStyleMobile
                          .copyWith(color: AppColors.grayDark)),
                ),
                Expanded(
                  child: Text(info.value,
                      style: AppTextStyles.productNameStyleDesktop
                          .copyWith(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFeaturesList(List<dynamic> features) {
    return Column(
      children: features.map((item) {
        final feature = item as FeatureItem;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            children: [
              Icon(_getIconFromString(feature.icon),
                  color: Colors.blue[600], size: 22.0),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(feature.description,
                    style: AppTextStyles.productNameStyleDesktop),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCareerTimeline(List<dynamic> careers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(careers.length, (index) {
        final career = careers[index] as CareerItem;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 14.0,
                    height: 14.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue[600]!, width: 3.0),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 2.0,
                      color: index == careers.length - 1
                          ? Colors.transparent
                          : Colors.grey[300],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(career.title,
                            style: AppTextStyles.productNameStyleDesktop
                                .copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4.0),
                        Text(_formatCareerPeriod(career),
                            style: AppTextStyles.productNameStyleMobile
                                .copyWith(color: Colors.black54)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  String _formatCareerPeriod(CareerItem career) {
    if (career.startDate == null) return '';
    final start = _parseYearMonth(career.startDate!);
    final end = career.endDate != null ? _parseYearMonth(career.endDate!) : DateTime.now();
    final diff = _yearMonthDiff(start, end);
    final startStr = '${start.year}년 ${start.month}월';
    final endStr = career.endDate != null ? '${end.year}년 ${end.month}월' : '현재';
    String durationStr = '';
    if (diff['years'] != 0) durationStr += '${diff['years']}년';
    if (diff['months'] != 0) {
      if (durationStr.isNotEmpty) durationStr += ' ';
      durationStr += '${diff['months']}개월';
    }
    final re = career.endDate == null ? ' · 재직중' : '';
    return '$startStr ~ $endStr · $durationStr$re';
  }

  DateTime _parseYearMonth(String ym) {
    final parts = ym.split('-');
    return DateTime(int.parse(parts[0]), int.parse(parts[1]));
  }

  Map<String, int> _yearMonthDiff(DateTime start, DateTime end) {
    int years = end.year - start.year;
    int months = end.month - start.month;
    if (months < 0) {
      years -= 1;
      months += 12;
    }
    return {'years': years, 'months': months};
  }
}
