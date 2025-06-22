import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_point/features/community/data/mock/mock_posts.dart';

class CommunityMobile extends StatelessWidget {
  const CommunityMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      itemCount: mockPosts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final post = mockPosts[index];
        return _PostItem(post: post);
      },
    );
  }
}

class _PostItem extends StatelessWidget {
  final dynamic post;
  const _PostItem({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('${post.author} · ${DateFormat('yyyy.MM.dd').format(post.createdAt)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
