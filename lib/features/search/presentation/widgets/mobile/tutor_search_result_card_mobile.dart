import 'package:flutter/material.dart';
import '../../../data/models/tutor_search_result_item.dart';

/// 모바일용 튜터 검색 결과 카드
class TutorSearchResultCardMobile extends StatelessWidget {
  final TutorSearchResultItem tutor;
  
  const TutorSearchResultCardMobile({
    super.key,
    required this.tutor,
  });

  @override
  Widget build(BuildContext context) {
    // 모바일용 태그/뱃지 (더 작은 크기)
    final List<Widget> badges = [
      if (tutor.rating >= 4.8) _buildBadge('고평점', Colors.blue),
      if (tutor.employmentCount > 200) _buildBadge('인기', Colors.green),
      if (tutor.careerYears >= 10) _buildBadge('베테랑', Colors.orange),
    ];
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단: 프로필 이미지 + 기본 정보
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 프로필 이미지 (모바일용 작은 크기)
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _buildProfileImage(tutor.profileImageUrl),
                ),
              ),
              
              const SizedBox(width: 12),
              
              // 이름과 통계 정보
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 이름과 뱃지 (한 줄에 표시, 오버플로우 방지)
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            tutor.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        ...badges.take(1), // 모바일에서는 뱃지 1개만 표시
                      ],
                    ),
                    
                    const SizedBox(height: 6),
                    
                    // 평점과 통계 정보 (컴팩트하게)
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        _buildCompactStatChip(
                          icon: Icons.star,
                          label: '${tutor.rating.toStringAsFixed(1)} (${tutor.ratingCount})',
                          color: Colors.amber,
                        ),
                        _buildCompactStatChip(
                          icon: Icons.work_outline,
                          label: '${tutor.employmentCount}회',
                          color: Colors.blue,
                        ),
                        _buildCompactStatChip(
                          icon: Icons.schedule,
                          label: '경력 ${tutor.careerYears}년',
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // 설명 (모바일 최적화)
          Text(
            tutor.description,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        border: Border.all(color: color.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildCompactStatChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage(String url) {
    final placeholder = Container(
      color: Colors.grey[100],
      child: Icon(Icons.person, size: 30, color: Colors.grey[400]),
    );

    if (url.startsWith('http')) {
      return Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => placeholder,
      );
    } else {
      return Image.asset(
        url,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => placeholder,
      );
    }
  }
} 