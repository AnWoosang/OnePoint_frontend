import 'package:flutter/material.dart';
import 'package:one_point/core/theme/app_text_styles.dart';

class CommunitySection extends StatelessWidget {
  const CommunitySection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: 실제 Post 모델 및 데이터로 교체해야 합니다.
    final List<Map<String, dynamic>> posts = List.generate(3, (index) => {
      'category': '질문 & 답변',
      'title': '이런 질문에 답변해주실 수 있나요? ${index + 1}',
      'content': '내용입니다. 커뮤니티 게시글의 내용이 여기에 표시됩니다. 길어질 경우 여러 줄로 표시될 수 있습니다.',
      'likes': (index + 1) * 5,
      'comments': (index + 1) * 2,
      'image_url': 'https://picsum.photos/seed/post${index}/100/100',
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '핏클 커뮤니티에 들어보세요',
                style: AppTextStyles.sliderSectionTitleStyleDesktop,
              ),
              TextButton(
                onPressed: () {
                  // TODO: 커뮤니티 전체보기 페이지로 이동
                },
                child: Text(
                  '전체보기 >',
                  style: AppTextStyles.productNameStyleDesktop.copyWith(color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: posts.length,
            separatorBuilder: (context, index) => const Divider(height: 32),
            itemBuilder: (context, index) {
              final post = posts[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('[${post['category']}]', style: AppTextStyles.productPriceStyleDesktop.copyWith(color: Colors.blue)),
                        const SizedBox(height: 8),
                        Text(post['title'].toString(), style: AppTextStyles.sliderSectionTitleStyleDesktop.copyWith(fontSize: 18)),
                        const SizedBox(height: 8),
                        Text(post['content'].toString(), style: AppTextStyles.productNameStyleDesktop, maxLines: 2, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Text('좋아요 ${post['likes']}'),
                            const SizedBox(width: 8),
                            Text('댓글 ${post['comments']}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  if (post['image_url'] != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        post['image_url'].toString(),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
} 