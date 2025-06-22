import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:one_point/core/utils/responsive.dart';
import 'package:one_point/core/router/route_names.dart';

import 'package:one_point/features/home/presentation/screens/home_screen.dart';
import 'package:one_point/features/search/presentation/screens/mobile/search_page.dart';
import 'package:one_point/features/product_detail/data/mock/product_detail_mock.dart';
import 'package:one_point/features/product_detail/presentation/desktop/product_detail_page_desktop.dart';
import 'package:one_point/features/product_detail/presentation/mobile/product_detail_page_mobile.dart';
import 'package:one_point/features/search/presentation/screens/desktop/product_search_page_desktop.dart';
import 'package:one_point/features/search/presentation/screens/mobile/product_search_page_mobile.dart';
import 'package:one_point/features/pages/signup_page.dart';
import 'package:one_point/features/pages/login_page.dart';
import 'package:one_point/features/pages/mypage_desktop.dart';
import 'package:one_point/features/pages/mypage_mobile.dart';
import 'package:one_point/features/community/pages/community_mobile.dart';
import 'package:one_point/features/community/pages/community_desktop.dart';
import 'package:one_point/features/community/pages/post_detail_mobile.dart';
import 'package:one_point/features/community/pages/post_detail_desktop.dart';


import 'package:one_point/features/community/data/mock/mock_posts.dart';

final router = GoRouter(
  initialLocation: RouteNames.home,
  routes: [
    //메인
    GoRoute(
      path: RouteNames.home,
      builder: (context, state) => const HomeScreen(),
    ),
    //검색창
    GoRoute(
      path: RouteNames.search,
      builder: (context, state) => const SearchPage(),
    ),
    //상품상세
    GoRoute(
      path: RouteNames.productDetail,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final product = mockProductDetails.firstWhere((p) => p.id == id);

        return Responsive.isDesktop(context)
            ? ProductDetailPageDesktop(product: product)
            : ProductDetailPageMobile(product: product);
      },
    ),
    //상품검색결과
    GoRoute(
      path: RouteNames.productSearch,
      builder: (context, state) {
        final keyword = state.uri.queryParameters['keyword'];
        final category = state.uri.queryParameters['category'];

        if (Responsive.isMobile(context)) {
          return ProductSearchPageMobile(
            keyword: keyword,
            category: category,
          );
        } else {
          return ProductSearchPageDesktop(
            keyword: keyword,
            category: category,
          );
        }
      },
    ),
    //회원가입
    GoRoute(
      path: RouteNames.signup,
      builder: (context, state) => const SignupPage(),
    ),
    //로그인
    GoRoute(
      path: RouteNames.login,
      builder: (context, state) => const LoginPage(),
    ),
    //마이페이지
    GoRoute(
      path: RouteNames.mypage,
      builder: (context, state) {
        return Responsive.isMobile(context)
            ? const MypageMobile()
            : const MypageDesktop();
      },
    ),
    GoRoute(
      path: RouteNames.community,
      builder: (context, state) {
        return Responsive.isMobile(context)
            ? const CommunityMobile()
            : const CommunityDesktop();
      },
    ),
    GoRoute(
      path: RouteNames.communityPost,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final post = mockPosts.firstWhere((p) => p.id == id, orElse: () => throw Exception('Post not found'));

        return Responsive.isMobile(context)
            ? PostDetailMobile(post: post)
            : PostDetailDesktop(post: post);
      },
    ),
  ],
);