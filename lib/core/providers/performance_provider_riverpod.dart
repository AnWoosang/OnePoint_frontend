import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

class PerformanceState extends Equatable {
  final bool isLowPerformanceMode;
  final bool enableAnimations;
  final bool enableImageCaching;
  final int maxCacheSize;
  final bool enableLazyLoading;

  const PerformanceState({
    this.isLowPerformanceMode = false,
    this.enableAnimations = true,
    this.enableImageCaching = true,
    this.maxCacheSize = 100,
    this.enableLazyLoading = true,
  });

  PerformanceState copyWith({
    bool? isLowPerformanceMode,
    bool? enableAnimations,
    bool? enableImageCaching,
    int? maxCacheSize,
    bool? enableLazyLoading,
  }) {
    return PerformanceState(
      isLowPerformanceMode: isLowPerformanceMode ?? this.isLowPerformanceMode,
      enableAnimations: enableAnimations ?? this.enableAnimations,
      enableImageCaching: enableImageCaching ?? this.enableImageCaching,
      maxCacheSize: maxCacheSize ?? this.maxCacheSize,
      enableLazyLoading: enableLazyLoading ?? this.enableLazyLoading,
    );
  }

  @override
  List<Object?> get props => [
    isLowPerformanceMode,
    enableAnimations,
    enableImageCaching,
    maxCacheSize,
    enableLazyLoading,
  ];
}

class PerformanceNotifier extends StateNotifier<PerformanceState> {
  PerformanceNotifier() : super(const PerformanceState());

  void setLowPerformanceMode(bool enabled) {
    state = state.copyWith(isLowPerformanceMode: enabled);
  }

  void toggleAnimations() {
    state = state.copyWith(enableAnimations: !state.enableAnimations);
  }

  void setImageCaching(bool enabled) {
    state = state.copyWith(enableImageCaching: enabled);
  }

  void setMaxCacheSize(int size) {
    state = state.copyWith(maxCacheSize: size);
  }

  void setLazyLoading(bool enabled) {
    state = state.copyWith(enableLazyLoading: enabled);
  }

  void optimizeForLowPerformance() {
    state = state.copyWith(
      isLowPerformanceMode: true,
      enableAnimations: false,
      enableImageCaching: true,
      maxCacheSize: 50,
      enableLazyLoading: true,
    );
  }

  void resetToDefault() {
    state = const PerformanceState();
  }
}

// Performance Provider
final performanceProvider = StateNotifierProvider<PerformanceNotifier, PerformanceState>((ref) {
  return PerformanceNotifier();
});

// Performance 상태별 Selector Providers
final isLowPerformanceModeProvider = Provider<bool>((ref) {
  return ref.watch(performanceProvider).isLowPerformanceMode;
});

final enableAnimationsProvider = Provider<bool>((ref) {
  return ref.watch(performanceProvider).enableAnimations;
});

final enableImageCachingProvider = Provider<bool>((ref) {
  return ref.watch(performanceProvider).enableImageCaching;
});

final maxCacheSizeProvider = Provider<int>((ref) {
  return ref.watch(performanceProvider).maxCacheSize;
});

final enableLazyLoadingProvider = Provider<bool>((ref) {
  return ref.watch(performanceProvider).enableLazyLoading;
});

// Performance 유틸리티 Provider
final performanceSystemProvider = Provider<PerformanceSystem>((ref) {
  return PerformanceSystem(ref);
});

class PerformanceSystem {
  final Ref _ref;

  PerformanceSystem(this._ref);

  void setLowPerformanceMode(bool enabled) {
    _ref.read(performanceProvider.notifier).setLowPerformanceMode(enabled);
  }

  void toggleAnimations() {
    _ref.read(performanceProvider.notifier).toggleAnimations();
  }

  void setImageCaching(bool enabled) {
    _ref.read(performanceProvider.notifier).setImageCaching(enabled);
  }

  void setMaxCacheSize(int size) {
    _ref.read(performanceProvider.notifier).setMaxCacheSize(size);
  }

  void setLazyLoading(bool enabled) {
    _ref.read(performanceProvider.notifier).setLazyLoading(enabled);
  }

  void optimizeForLowPerformance() {
    _ref.read(performanceProvider.notifier).optimizeForLowPerformance();
  }

  void resetToDefault() {
    _ref.read(performanceProvider.notifier).resetToDefault();
  }
} 