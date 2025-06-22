import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_point/features/community/data/models/post.dart';
import 'package:one_point/core/widgets/layout/page_scaffold.dart';

class PostDetailDesktop extends StatelessWidget {
  final Post post;

  const PostDetailDesktop({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.title,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text('${post.author} · ${DateFormat('yyyy.MM.dd').format(post.createdAt)}',
                  style: const TextStyle(color: Colors.grey)),
              const Divider(height: 40),
              const _PostBody(),
            ],
          ),
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
      '여기는 게시글의 본문 영역입니다.\n\n데스크톱에서는 넓은 공간을 활용해 더 긴 내용을 가독성 좋게 출력할 수 있습니다.',
      style: TextStyle(fontSize: 16, height: 1.5),
    );
  }
}
