import 'package:flutter/material.dart';
import 'package:one_point/core/widgets/layout/page_scaffold.dart';

class MypageDesktop extends StatelessWidget {
  const MypageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      child: Center(
        child: Container(
          width: 600,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('마이페이지', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 32),
              _UserInfoSection(),
              SizedBox(height: 40),
              _MenuListSection(),
            ],
          ),
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
          radius: 35,
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, size: 36, color: Colors.white),
        ),
        const SizedBox(width: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('홍길동', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
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
          leading: const Icon(Icons.favorite),
          title: const Text('찜한 상품'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.receipt_long),
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
