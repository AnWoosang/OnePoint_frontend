import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final bool isLoggedIn;
  final String? errorMessage;
  final String? userNickname;
  final String? userId;

  const AuthState({
    this.status = AuthStatus.initial,
    this.isLoggedIn = false,
    this.errorMessage,
    this.userNickname,
    this.userId,
  });

  bool get isLoading => status == AuthStatus.loading;

  AuthState copyWith({
    AuthStatus? status,
    bool? isLoggedIn,
    String? errorMessage,
    String? userNickname,
    String? userId,
  }) {
    return AuthState(
      status: status ?? this.status,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      errorMessage: errorMessage ?? this.errorMessage,
      userNickname: userNickname ?? this.userNickname,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [status, isLoggedIn, errorMessage, userNickname, userId];
}

class AuthNotifier extends StateNotifier<AuthState> {
  final SharedPreferences _prefs;

  AuthNotifier(this._prefs) : super(const AuthState()) {
    _loadLoginState();
  }

  Future<void> _loadLoginState() async {
    try {
      state = state.copyWith(status: AuthStatus.loading);
      
      final isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;
      final userNickname = _prefs.getString('userNickname');
      final userId = _prefs.getString('userId');

      state = state.copyWith(
        status: isLoggedIn ? AuthStatus.authenticated : AuthStatus.unauthenticated,
        isLoggedIn: isLoggedIn,
        userNickname: userNickname,
        userId: userId,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: '로그인 상태 로드 중 오류가 발생했습니다: $e',
      );
    }
  }

  Future<void> login({String? nickname, String? userId}) async {
    try {
      state = state.copyWith(status: AuthStatus.loading);
      
      await _prefs.setBool('isLoggedIn', true);
      if (nickname != null) {
        await _prefs.setString('userNickname', nickname);
      }
      if (userId != null) {
        await _prefs.setString('userId', userId);
      }

      state = state.copyWith(
        status: AuthStatus.authenticated,
        isLoggedIn: true,
        userNickname: nickname ?? state.userNickname,
        userId: userId ?? state.userId,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: '로그인 중 오류가 발생했습니다: $e',
      );
    }
  }

  Future<void> logout() async {
    try {
      state = state.copyWith(status: AuthStatus.loading);
      
      await _prefs.setBool('isLoggedIn', false);
      await _prefs.remove('userNickname');
      await _prefs.remove('userId');

      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isLoggedIn: false,
        userNickname: null,
        userId: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: '로그아웃 중 오류가 발생했습니다: $e',
      );
    }
  }

  Future<void> updateNickname(String nickname) async {
    try {
      await _prefs.setString('userNickname', nickname);
      state = state.copyWith(userNickname: nickname);
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: '닉네임 업데이트 중 오류가 발생했습니다: $e',
      );
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

// SharedPreferences Provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be overridden');
});

// Auth Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AuthNotifier(prefs);
});

// Auth 상태별 Selector Providers
final isLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isLoggedIn;
});

final userNicknameProvider = Provider<String?>((ref) {
  return ref.watch(authProvider).userNickname;
});

final authStatusProvider = Provider<AuthStatus>((ref) {
  return ref.watch(authProvider).status;
});

final authErrorProvider = Provider<String?>((ref) {
  return ref.watch(authProvider).errorMessage;
});

final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isLoading;
}); 