import '../models/post.dart';

final List<Post> mockPosts = [
  Post(id: '1', title: '첫 번째 게시글입니다', author: '홍길동', createdAt: DateTime.now().subtract(const Duration(days: 1))),
  Post(id: '2', title: '전자담배 추천 좀요', author: '임꺽정', createdAt: DateTime.now().subtract(const Duration(days: 2))),
  Post(id: '3', title: '멘솔 vs 과일향 비교', author: '이순신', createdAt: DateTime.now().subtract(const Duration(hours: 6))),
];
