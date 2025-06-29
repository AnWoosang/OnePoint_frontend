/// 모든 라우트 경로를 상수로 정의
class RouteNames {
  static const home = '/';
  static const search = '/search';
  static const message = '/message';
  static const signup = '/signup';
  static const login = '/login';
  static const mypage = '/mypage';
  static const tutorDetail = '/tutor/:id';
  static const productSearch = '/search/products';
  static const profileManage = '/profile/:nickname';
}

class RoutePaths {
  static String tutorDetail(String id) => '/tutor/$id';
  static String profileManage(String nickname) => '/profile/$nickname';
} 