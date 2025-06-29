// ========================================
// 🚀 Riverpod Providers 통합 Export
// ========================================

// Core Providers
export 'auth_provider_riverpod.dart';
export 'app_provider_riverpod.dart';
export 'cursor_provider_riverpod.dart';
export 'performance_provider_riverpod.dart';
export 'error_provider_riverpod.dart';

// Feature Providers
export '../../features/search/presentation/providers/tutor_search_provider_riverpod.dart' 
  hide isLoadingProvider;
export '../../features/tutor/presentation/providers/tutor_detail_provider_riverpod.dart';

// ========================================
// 📋 Provider 사용 가이드
// ========================================

/*
사용법:

1. ConsumerWidget에서 Provider 사용:
```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final userNickname = ref.watch(userNicknameProvider);
    
    return Text('안녕하세요, $userNickname님!');
  }
}
```

2. 상태 변경:
```dart
final authNotifier = ref.read(authProvider.notifier);
authNotifier.login(nickname: '사용자');
```

3. Selector Provider 사용 (성능 최적화):
```dart
// ❌ 비효율적
final authState = ref.watch(authProvider);

// ✅ 효율적
final isLoggedIn = ref.watch(isLoggedInProvider);
final userNickname = ref.watch(userNicknameProvider);
```

4. 조건부 Provider:
```dart
final conditionalProvider = Provider<String>((ref) {
  final isLoggedIn = ref.watch(isLoggedInProvider);
  return isLoggedIn ? '로그인됨' : '로그인 필요';
});
```

5. 에러 처리:
```dart
final errorSystem = ref.watch(errorSystemProvider);
errorSystem.addNetworkError('네트워크 오류가 발생했습니다');
```

6. 성능 최적화:
```dart
final performanceSystem = ref.watch(performanceSystemProvider);
performanceSystem.optimizeForLowPerformance();
```
*/ 