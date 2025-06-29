import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/common/tutor.dart';
import '../../domain/repositories/tutor_repository.dart';
import '../../data/repositories/tutor_repository_impl.dart';

enum TutorDetailStatus { initial, loading, success, error }

class TutorDetailState extends Equatable {
  final TutorDetailStatus status;
  final Tutor? tutorDetail;
  final String? errorMessage;
  final bool isFavorite;

  const TutorDetailState({
    this.status = TutorDetailStatus.initial,
    this.tutorDetail,
    this.errorMessage,
    this.isFavorite = false,
  });

  bool get isLoading => status == TutorDetailStatus.loading;
  bool get hasError => status == TutorDetailStatus.error;
  bool get hasData => tutorDetail != null;

  TutorDetailState copyWith({
    TutorDetailStatus? status,
    Tutor? tutorDetail,
    String? errorMessage,
    bool? isFavorite,
  }) {
    return TutorDetailState(
      status: status ?? this.status,
      tutorDetail: tutorDetail ?? this.tutorDetail,
      errorMessage: errorMessage ?? this.errorMessage,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [status, tutorDetail, errorMessage, isFavorite];
}

class TutorDetailNotifier extends StateNotifier<TutorDetailState> {
  final TutorRepository _repository;

  TutorDetailNotifier(this._repository) : super(const TutorDetailState());

  Future<void> loadTutorDetail(String tutorId) async {
    try {
      state = state.copyWith(status: TutorDetailStatus.loading);

      final tutorDetail = await _repository.getTutorById(tutorId);
      
      state = state.copyWith(
        status: TutorDetailStatus.success,
        tutorDetail: tutorDetail,
      );
    } catch (e) {
      state = state.copyWith(
        status: TutorDetailStatus.error,
        errorMessage: '튜터 정보를 불러오는 중 오류가 발생했습니다: $e',
      );
    }
  }

  void toggleFavorite() {
    state = state.copyWith(isFavorite: !state.isFavorite);
  }

  void setFavorite(bool isFavorite) {
    state = state.copyWith(isFavorite: isFavorite);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  void reset() {
    state = const TutorDetailState();
  }
}

// Repository Provider
final tutorRepositoryProvider = Provider<TutorRepository>((ref) {
  return TutorRepositoryImpl();
});

// Tutor Detail Provider
final tutorDetailProvider = StateNotifierProvider<TutorDetailNotifier, TutorDetailState>((ref) {
  final repository = ref.watch(tutorRepositoryProvider);
  return TutorDetailNotifier(repository);
});

// Tutor Detail 상태별 Selector Providers
final tutorDetailDataProvider = Provider<Tutor?>((ref) {
  return ref.watch(tutorDetailProvider).tutorDetail;
});

final tutorDetailStatusProvider = Provider<TutorDetailStatus>((ref) {
  return ref.watch(tutorDetailProvider).status;
});

final tutorDetailErrorProvider = Provider<String?>((ref) {
  return ref.watch(tutorDetailProvider).errorMessage;
});

final isFavoriteProvider = Provider<bool>((ref) {
  return ref.watch(tutorDetailProvider).isFavorite;
});

final isLoadingTutorDetailProvider = Provider<bool>((ref) {
  return ref.watch(tutorDetailProvider).isLoading;
});

final hasTutorDetailDataProvider = Provider<bool>((ref) {
  return ref.watch(tutorDetailProvider).hasData;
});

// Tutor Detail 유틸리티 Provider
final tutorDetailSystemProvider = Provider<TutorDetailSystem>((ref) {
  return TutorDetailSystem(ref);
});

class TutorDetailSystem {
  final Ref _ref;

  TutorDetailSystem(this._ref);

  Future<void> loadTutorDetail(String tutorId) {
    return _ref.read(tutorDetailProvider.notifier).loadTutorDetail(tutorId);
  }

  void toggleFavorite() {
    _ref.read(tutorDetailProvider.notifier).toggleFavorite();
  }

  void setFavorite(bool isFavorite) {
    _ref.read(tutorDetailProvider.notifier).setFavorite(isFavorite);
  }

  void clearError() {
    _ref.read(tutorDetailProvider.notifier).clearError();
  }

  void reset() {
    _ref.read(tutorDetailProvider.notifier).reset();
  }
} 