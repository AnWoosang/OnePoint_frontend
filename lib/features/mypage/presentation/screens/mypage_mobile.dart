import 'package:flutter/material.dart';
import 'package:one_point/core/widgets/layout/page_scaffold.dart';

class MypageMobile extends StatelessWidget {
  const MypageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _UserInfoSection(),
            SizedBox(height: 32),
            _MenuListSection(),
          ],
        ),
      ),
    );
  }
}

class _UserInfoSection extends StatelessWidget {
  const _UserInfoSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, size: 32, color: Colors.white),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('홍길동', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('user@email.com', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}

class _MenuListSection extends StatelessWidget {
  const _MenuListSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.favorite_border),
          title: const Text('찜한 상품'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.shopping_bag_outlined),
          title: const Text('주문 내역'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('로그아웃'),
          onTap: () {},
        ),
      ],
    );
  }
}
