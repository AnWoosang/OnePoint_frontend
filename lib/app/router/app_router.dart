import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fitkle/core/utils/responsive.dart';
import 'package:fitkle/app/router/route_names.dart';
import 'package:fitkle/core/providers/auth_provider_riverpod.dart';

import 'package:fitkle/features/home/presentation/screens/home_screen.dart';
import 'package:fitkle/features/auth/presentation/screens/signup_page.dart';
import 'package:fitkle/features/auth/presentation/screens/login_page.dart';
import 'package:fitkle/features/auth/presentation/screens/email_signup_page.dart';
import 'package:fitkle/features/auth/presentation/screens/client_email_register_page.dart';
import 'package:fitkle/features/auth/presentation/screens/identity_verification_page.dart';
import 'package:fitkle/features/recommendation/presentation/screens/recommendation_complete_page.dart';
import 'package:fitkle/features/recommendation/presentation/screens/service_recommendation_survey_page.dart';
import 'package:fitkle/features/auth/presentation/screens/expert_register_complete_page.dart';
import 'package:fitkle/features/profile/presentation/screens/profile_manage_screen.dart';

import 'package:fitkle/features/search/presentation/screens/tutor_search_screen.dart';
import 'package:fitkle/features/tutor/presentation/screens/tutor_detail_screen.dart';

final router = GoRouter(
  initialLocation: RouteNames.home,
  redirect: (context, state) {
    // Riverpod을 사용하여 인증 상태 확인
    final container = ProviderScope.containerOf(context);
    final isLoggedIn = container.read(isLoggedInProvider);
    
    // 로그인이 필요한 페이지들
    final requiresAuth = [
      RouteNames.profileManage,
    ];
    
    if (requiresAuth.contains(state.matchedLocation) && !isLoggedIn) {
      return RouteNames.login;
    }
    
    return null;
  },
  errorBuilder: (context, state) => _ErrorScreen(error: state.error),
  routes: [
    GoRoute(
      path: RouteNames.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouteNames.search,
      builder: (context, state) => const TutorSearchScreen(),
    ),
    GoRoute(
      path: RouteNames.signup, 
      builder: (context, state) => const SignupPage()
    ),
    GoRoute(
      path: '/signup/email', 
      builder: (context, state) => const EmailSignupPage()
    ),
    GoRoute(
      path: '/signup/email/client', 
      builder: (context, state) => const ClientEmailRegisterPage()
    ),
    GoRoute(
      path: '/signup/email/tutor', 
      builder: (context, state) => const ExpertRegisterCompletePage()
    ),
    GoRoute(
      path: RouteNames.login, 
      builder: (context, state) => const LoginPage()
    ),
    GoRoute(
      path: '/identity-verification', 
      builder: (context, state) => const IdentityVerificationPage()
    ),
    GoRoute(
      path: '/recommendation-complete', 
      builder: (context, state) => const RecommendationCompletePage()
    ),
    GoRoute(
      path: '/service-recommendation-survey', 
      builder: (context, state) => const ServiceRecommendationSurveyPage()
    ),
    GoRoute(
      path: '/tutor/:id',
      name: RouteNames.tutorDetail,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return TutorDetailScreen(tutorId: id);
      },
    ),
    GoRoute(
      path: RouteNames.profileManage,
      name: RouteNames.profileManage,
      builder: (context, state) {
        return ProfileManageScreen();
      },
    ),
    GoRoute(
      path: '/expert-register-complete', 
      builder: (context, state) => const ExpertRegisterCompletePage()
    ),
  ],
);

class _ErrorScreen extends StatelessWidget {
  final Exception? error;

  const _ErrorScreen({this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('오류'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              '페이지를 찾을 수 없습니다',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              error?.toString() ?? '알 수 없는 오류가 발생했습니다',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(RouteNames.home),
              child: const Text('홈으로 돌아가기'),
            ),
          ],
        ),
      ),
    );
  }
} 