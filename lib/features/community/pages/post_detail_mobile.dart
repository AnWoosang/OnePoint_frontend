import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_point/features/community/data/models/post.dart';
import 'package:one_point/core/widgets/layout/page_scaffold.dart';

class PostDetailMobile extends StatelessWidget {
  final Post post;

  const PostDetailMobile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('${post.author} · ${DateFormat('yyyy.MM.dd').format(post.createdAt)}',
                style: const TextStyle(color: Colors.grey)),
            const Divider(height: 32),
            const _PostBody(),
          ],
        ),
      ),
    );
  }
}

class _PostBody extends StatelessWidget {
  const _PostBody();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '여기는 게시글 본문입니다.\n\n모바일에 맞게 가독성이 좋은 폰트 사이즈로 출력할 수 있어요.',
      style: TextStyle(fontSize: 15),
    );
  }
}
