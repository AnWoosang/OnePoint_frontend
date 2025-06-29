import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fitkle/core/theme/app_theme.dart';
import 'router/app_router.dart';
import 'package:fitkle/core/providers/auth_provider_riverpod.dart';
import 'package:fitkle/core/providers/app_provider_riverpod.dart';
import 'package:fitkle/core/providers/cursor_provider_riverpod.dart';

class AppRoot extends ConsumerWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'FITKLE',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ref.watch(themeModeProvider),
          locale: ref.watch(localeProvider),
          routerConfig: router,
          builder: (context, child) {
            // 전역 에러 처리
            final authError = ref.watch(authErrorProvider);
            final appError = ref.watch(appErrorProvider);
            
            if (authError != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(authError)),
                );
                ref.read(authProvider.notifier).clearError();
              });
            }
            
            if (appError != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(appError)),
                );
                ref.read(appProvider.notifier).clearError();
              });
            }
            
            return child!;
          },
        );
      },
    );
  }
} 