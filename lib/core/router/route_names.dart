/// 모든 라우트 경로를 상수로 정의
class RouteNames {
  static const home = '/';
  static const search = '/search';
  static const productDetail = '/product/:id';
  static const productSearch = '/search/products';
  static const signup = '/signup';
  static const login = '/login';
  static const mypage = '/mypage';
  static const community = '/community';
  static const communityPost = '/community/:id';
}

class RoutePaths {
  static String productDetail(String id) => '/product/$id';
  static String communityPost(String id) => '/community/$id';
}
