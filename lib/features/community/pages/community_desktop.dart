import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_point/features/community/data/mock/mock_posts.dart';

class CommunityDesktop extends StatelessWidget {
  const CommunityDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('커뮤니티 게시판', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            _PostList(),
          ],
        ),
      ),
    );
  }
}

class _PostList extends StatelessWidget {
  const _PostList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...mockPosts.map((post) => Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                title: Text(post.title),
                subtitle: Text('${post.author} · ${DateFormat('yyyy.MM.dd').format(post.createdAt)}'),
                onTap: () {
                  // TODO: 상세 보기 이동
                },
              ),
            )),
      ],
    );
  }
}
