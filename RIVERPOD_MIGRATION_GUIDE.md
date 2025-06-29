# 🚀 Riverpod 마이그레이션 가이드

## 📋 개요

이 프로젝트는 Provider에서 Riverpod으로 완전히 마이그레이션되었습니다. Riverpod은 더 나은 상태 관리, 의존성 주입, 성능 최적화를 제공합니다.

## 🔄 주요 변경사항

### 1. Provider → Riverpod 변경

#### 기존 Provider 코드:
```dart
class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  
  bool get isLoggedIn => _isLoggedIn;
  
  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }
}

// 사용
ChangeNotifierProvider(create: (_) => AuthProvider())
```

#### 새로운 Riverpod 코드:
```dart
class AuthState extends Equatable {
  final bool isLoggedIn;
  final AuthStatus status;
  
  const AuthState({
    this.isLoggedIn = false,
    this.status = AuthStatus.initial,
  });
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());
  
  void login() {
    state = state.copyWith(
      isLoggedIn: true,
      status: AuthStatus.authenticated,
    );
  }
}

// Provider 정의
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

// Selector Provider
final isLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isLoggedIn;
});
```

### 2. ConsumerWidget 사용

#### 기존 코드:
```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Text('로그인 상태: ${authProvider.isLoggedIn}');
      },
    );
  }
}
```

#### 새로운 코드:
```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    return Text('로그인 상태: $isLoggedIn');
  }
}
```

## 🏗️ 새로운 아키텍처

### 1. 상태 관리 계층

```
┌─────────────────────────────────────┐
│           UI Layer                  │
│     (ConsumerWidget)                │
└─────────────────┬───────────────────┘
                  │
┌─────────────────▼───────────────────┐
│        Selector Providers           │
│   (상태별 세분화된 Provider)        │
└─────────────────┬───────────────────┘
                  │
┌─────────────────▼───────────────────┐
│        StateNotifierProvider        │
│      (메인 상태 관리)               │
└─────────────────┬───────────────────┘
                  │
┌─────────────────▼───────────────────┐
│        Repository Layer             │
│      (데이터 접근)                  │
└─────────────────────────────────────┘
```

### 2. Provider 구조

#### Core Providers:
- `authProvider` - 인증 상태 관리
- `appProvider` - 앱 설정 관리
- `cursorProvider` - 마우스 커서 관리
- `performanceProvider` - 성능 최적화
- `errorProvider` - 에러 처리

#### Feature Providers:
- `searchProvider` - 검색 기능
- `tutorDetailProvider` - 튜터 상세 정보

### 3. Selector Provider 패턴

성능 최적화를 위해 상태별로 세분화된 Selector Provider를 사용:

```dart
// 메인 Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

// Selector Providers
final isLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isLoggedIn;
});

final userNicknameProvider = Provider<String?>((ref) {
  return ref.watch(authProvider).userNickname;
});

final authStatusProvider = Provider<AuthStatus>((ref) {
  return ref.watch(authProvider).status;
});
```

## 🎯 사용법

### 1. Provider 사용

```dart
class MyScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태 읽기
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final userNickname = ref.watch(userNicknameProvider);
    
    // 상태 변경
    final authNotifier = ref.read(authProvider.notifier);
    
    return Scaffold(
      body: Column(
        children: [
          Text('로그인 상태: $isLoggedIn'),
          Text('닉네임: $userNickname'),
          ElevatedButton(
            onPressed: () => authNotifier.login(),
            child: Text('로그인'),
          ),
        ],
      ),
    );
  }
}
```

### 2. 조건부 Provider

```dart
final conditionalProvider = Provider<String>((ref) {
  final isLoggedIn = ref.watch(isLoggedInProvider);
  
  if (isLoggedIn) {
    return '로그인됨';
  } else {
    return '로그인 필요';
  }
});
```

### 3. Provider 조합

```dart
final combinedProvider = Provider<Map<String, dynamic>>((ref) {
  final isLoggedIn = ref.watch(isLoggedInProvider);
  final userNickname = ref.watch(userNicknameProvider);
  final themeMode = ref.watch(themeModeProvider);
  
  return {
    'isLoggedIn': isLoggedIn,
    'userNickname': userNickname,
    'themeMode': themeMode,
  };
});
```

## 🔧 성능 최적화

### 1. Selector Provider 사용

```dart
// ❌ 비효율적 - 전체 상태가 변경될 때마다 리빌드
final authState = ref.watch(authProvider);

// ✅ 효율적 - 특정 상태만 변경될 때 리빌드
final isLoggedIn = ref.watch(isLoggedInProvider);
final userNickname = ref.watch(userNicknameProvider);
```

### 2. AutoDispose 사용 (필요시)

```dart
final temporaryProvider = AutoDisposeProvider<String>((ref) {
  // 자동으로 dispose됨
  return '임시 데이터';
});
```

### 3. Family Provider 사용

```dart
final userProvider = FutureProvider.family<User, String>((ref, userId) async {
  return await userRepository.getUser(userId);
});
```

## 🚨 주의사항

### 1. Provider 순환 참조 방지

```dart
// ❌ 순환 참조
final providerA = Provider<A>((ref) {
  final b = ref.watch(providerB); // 순환 참조!
  return A(b);
});

final providerB = Provider<B>((ref) {
  final a = ref.watch(providerA); // 순환 참조!
  return B(a);
});

// ✅ 올바른 방법
final providerA = Provider<A>((ref) {
  return A();
});

final providerB = Provider<B>((ref) {
  final a = ref.watch(providerA);
  return B(a);
});
```

### 2. 메모리 누수 방지

```dart
// ❌ 메모리 누수 가능성
final heavyProvider = Provider<HeavyObject>((ref) {
  return HeavyObject();
});

// ✅ AutoDispose 사용
final heavyProvider = AutoDisposeProvider<HeavyObject>((ref) {
  return HeavyObject();
});
```

## 📚 추가 리소스

- [Riverpod 공식 문서](https://riverpod.dev/)
- [Riverpod GitHub](https://github.com/rrousselGit/riverpod)
- [Flutter Riverpod 예제](https://github.com/rrousselGit/riverpod/tree/master/examples)

## 🔄 마이그레이션 체크리스트

- [x] Provider → StateNotifierProvider 변경
- [x] ChangeNotifier → StateNotifier 변경
- [x] Consumer → ConsumerWidget 변경
- [x] Selector Provider 생성
- [x] 의존성 주입 설정
- [x] 에러 처리 개선
- [x] 성능 최적화 적용
- [x] 테스트 코드 업데이트
- [x] 문서화 완료

## 🎉 결론

Riverpod으로의 마이그레이션을 통해 다음과 같은 이점을 얻었습니다:

1. **더 나은 상태 관리**: 불변성과 예측 가능한 상태 변경
2. **성능 최적화**: Selector Provider를 통한 정확한 리빌드
3. **의존성 주입**: 자동 의존성 관리와 테스트 용이성
4. **타입 안전성**: 컴파일 타임 에러 검출
5. **개발자 경험**: 더 나은 디버깅과 코드 구조

이제 프로젝트는 프로덕션 레벨의 상태 관리 시스템을 갖추게 되었습니다! 🚀 