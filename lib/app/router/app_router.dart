import 'package:go_router/go_router.dart';

import 'package:fitkle/core/utils/responsive.dart';
import 'package:fitkle/app/router/route_names.dart';

import 'package:fitkle/features/home/presentation/screens/home_screen.dart';
import 'package:fitkle/features/auth/presentation/screens/signup_page.dart';
import 'package:fitkle/features/auth/presentation/screens/login_page.dart';
import 'package:fitkle/features/mypage/presentation/screens/mypage_desktop.dart';
import 'package:fitkle/features/mypage/presentation/screens/mypage_mobile.dart';
import 'package:fitkle/features/auth/presentation/screens/email_signup_page.dart';
import 'package:fitkle/features/auth/presentation/screens/client_email_register_page.dart';
import 'package:fitkle/features/auth/presentation/screens/identity_verification_page.dart';
import 'package:fitkle/features/recommendation/presentation/screens/recommendation_complete_page.dart';
import 'package:fitkle/features/recommendation/presentation/screens/service_recommendation_survey_page.dart';

import 'package:fitkle/features/search/presentation/screens/tutor_search_screen.dart';
import 'package:fitkle/features/tutor/presentation/screens/tutor_detail_screen.dart';

final router = GoRouter(
  initialLocation: RouteNames.home,
  // initialLocation: RouteNames.search,
  routes: [
    GoRoute(
      path: RouteNames.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouteNames.search,
      builder: (context, state) => const TutorSearchScreen(),
    ),
    GoRoute(path: RouteNames.signup, builder: (context, state) => const SignupPage()),
    GoRoute(path: '/signup/email', builder: (context, state) => const EmailSignupPage()),
    GoRoute(path: '/signup/email/client', builder: (context, state) => const ClientEmailRegisterPage()),
    GoRoute(path: RouteNames.login, builder: (context, state) => const LoginPage()),
    GoRoute(
      path: RouteNames.mypage,
      builder: (context, state) {
        return Responsive.isMobile(context) ? const MypageMobile() : const MypageDesktop();
      },
    ),
    GoRoute(path: '/identity-verification', builder: (context, state) => const IdentityVerificationPage()),
    GoRoute(path: '/recommendation-complete', builder: (context, state) => const RecommendationCompletePage()),
    GoRoute(path: '/service-recommendation-survey', builder: (context, state) => const ServiceRecommendationSurveyPage()),
    GoRoute(
      path: '/tutor/:id',
      name: RouteNames.tutorDetail,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return TutorDetailScreen(tutorId: id);
      },
    ),
  ],
); 