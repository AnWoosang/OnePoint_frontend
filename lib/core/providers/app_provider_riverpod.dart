import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'auth_provider_riverpod.dart';

class AppState extends Equatable {
  final ThemeMode themeMode;
  final Locale locale;
  final bool isFirstLaunch;
  final String? errorMessage;

  const AppState({
    this.themeMode = ThemeMode.light,
    this.locale = const Locale('ko', 'KR'),
    this.isFirstLaunch = true,
    this.errorMessage,
  });

  bool get isDarkMode => themeMode == ThemeMode.dark;

  AppState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    bool? isFirstLaunch,
    String? errorMessage,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [themeMode, locale, isFirstLaunch, errorMessage];
}

class AppNotifier extends StateNotifier<AppState> {
  final SharedPreferences _prefs;

  AppNotifier(this._prefs) : super(const AppState()) {
    _loadAppSettings();
  }

  Future<void> _loadAppSettings() async {
    try {
      // 테마 설정 로드
      final themeIndex = _prefs.getInt('themeMode') ?? 0;
      final themeMode = ThemeMode.values[themeIndex];
      
      // 언어 설정 로드
      final languageCode = _prefs.getString('languageCode') ?? 'ko';
      final countryCode = _prefs.getString('countryCode') ?? 'KR';
      final locale = Locale(languageCode, countryCode);
      
      // 첫 실행 여부 확인
      final isFirstLaunch = _prefs.getBool('isFirstLaunch') ?? true;
      
      state = state.copyWith(
        themeMode: themeMode,
        locale: locale,
        isFirstLaunch: isFirstLaunch,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: '앱 설정 로드 중 오류가 발생했습니다: $e',
      );
    }
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    try {
      await _prefs.setInt('themeMode', themeMode.index);
      state = state.copyWith(themeMode: themeMode);
    } catch (e) {
      state = state.copyWith(
        errorMessage: '테마 설정 저장 중 오류가 발생했습니다: $e',
      );
    }
  }

  Future<void> setLocale(Locale locale) async {
    try {
      await _prefs.setString('languageCode', locale.languageCode);
      await _prefs.setString('countryCode', locale.countryCode ?? '');
      state = state.copyWith(locale: locale);
    } catch (e) {
      state = state.copyWith(
        errorMessage: '언어 설정 저장 중 오류가 발생했습니다: $e',
      );
    }
  }

  Future<void> setFirstLaunchComplete() async {
    try {
      await _prefs.setBool('isFirstLaunch', false);
      state = state.copyWith(isFirstLaunch: false);
    } catch (e) {
      state = state.copyWith(
        errorMessage: '첫 실행 설정 저장 중 오류가 발생했습니다: $e',
      );
    }
  }

  void toggleTheme() {
    final newThemeMode = state.themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    setThemeMode(newThemeMode);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

// App Provider
final appProvider = StateNotifierProvider<AppNotifier, AppState>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AppNotifier(prefs);
});

// App 상태별 Selector Providers
final themeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(appProvider).themeMode;
});

final localeProvider = Provider<Locale>((ref) {
  return ref.watch(appProvider).locale;
});

final isFirstLaunchProvider = Provider<bool>((ref) {
  return ref.watch(appProvider).isFirstLaunch;
});

final isDarkModeProvider = Provider<bool>((ref) {
  return ref.watch(appProvider).isDarkMode;
});

final appErrorProvider = Provider<String?>((ref) {
  return ref.watch(appProvider).errorMessage;
}); 