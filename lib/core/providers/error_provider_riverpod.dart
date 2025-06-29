import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

enum ErrorType { network, validation, authentication, server, unknown }

class AppError {
  final String message;
  final ErrorType type;
  final String? code;
  final DateTime timestamp;
  final StackTrace? stackTrace;

  const AppError({
    required this.message,
    required this.type,
    this.code,
    required this.timestamp,
    this.stackTrace,
  });

  bool get isNetworkError => type == ErrorType.network;
  bool get isValidationError => type == ErrorType.validation;
  bool get isAuthenticationError => type == ErrorType.authentication;
  bool get isServerError => type == ErrorType.server;

  @override
  String toString() => 'AppError($type): $message';
}

class ErrorState extends Equatable {
  final List<AppError> errors;
  final AppError? currentError;
  final bool showErrorSnackBar;

  const ErrorState({
    this.errors = const [],
    this.currentError,
    this.showErrorSnackBar = false,
  });

  bool get hasErrors => errors.isNotEmpty;
  bool get hasCurrentError => currentError != null;

  ErrorState copyWith({
    List<AppError>? errors,
    AppError? currentError,
    bool? showErrorSnackBar,
  }) {
    return ErrorState(
      errors: errors ?? this.errors,
      currentError: currentError ?? this.currentError,
      showErrorSnackBar: showErrorSnackBar ?? this.showErrorSnackBar,
    );
  }

  @override
  List<Object?> get props => [errors, currentError, showErrorSnackBar];
}

class ErrorNotifier extends StateNotifier<ErrorState> {
  ErrorNotifier() : super(const ErrorState());

  void addError(AppError error) {
    final newErrors = [...state.errors, error];
    state = state.copyWith(
      errors: newErrors,
      currentError: error,
      showErrorSnackBar: true,
    );
  }

  void addNetworkError(String message) {
    addError(AppError(
      message: message,
      type: ErrorType.network,
      timestamp: DateTime.now(),
    ));
  }

  void addValidationError(String message, {String? code}) {
    addError(AppError(
      message: message,
      type: ErrorType.validation,
      code: code,
      timestamp: DateTime.now(),
    ));
  }

  void addAuthenticationError(String message) {
    addError(AppError(
      message: message,
      type: ErrorType.authentication,
      timestamp: DateTime.now(),
    ));
  }

  void addServerError(String message) {
    addError(AppError(
      message: message,
      type: ErrorType.server,
      timestamp: DateTime.now(),
    ));
  }

  void addUnknownError(String message, [StackTrace? stackTrace]) {
    addError(AppError(
      message: message,
      type: ErrorType.unknown,
      timestamp: DateTime.now(),
      stackTrace: stackTrace,
    ));
  }

  void clearCurrentError() {
    state = state.copyWith(
      currentError: null,
      showErrorSnackBar: false,
    );
  }

  void clearAllErrors() {
    state = const ErrorState();
  }

  void removeError(AppError error) {
    final newErrors = state.errors.where((e) => e != error).toList();
    state = state.copyWith(errors: newErrors);
  }

  void clearErrorsByType(ErrorType type) {
    final newErrors = state.errors.where((e) => e.type != type).toList();
    state = state.copyWith(errors: newErrors);
  }

  void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: '닫기',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: '닫기',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}

// Error Provider
final errorProvider = StateNotifierProvider<ErrorNotifier, ErrorState>((ref) {
  return ErrorNotifier();
});

// Error 상태별 Selector Providers
final currentErrorProvider = Provider<AppError?>((ref) {
  return ref.watch(errorProvider).currentError;
});

final hasErrorsProvider = Provider<bool>((ref) {
  return ref.watch(errorProvider).hasErrors;
});

final hasCurrentErrorProvider = Provider<bool>((ref) {
  return ref.watch(errorProvider).hasCurrentError;
});

final showErrorSnackBarProvider = Provider<bool>((ref) {
  return ref.watch(errorProvider).showErrorSnackBar;
});

final errorsListProvider = Provider<List<AppError>>((ref) {
  return ref.watch(errorProvider).errors;
});

// Error 유틸리티 Provider
final errorSystemProvider = Provider<ErrorSystem>((ref) {
  return ErrorSystem(ref);
});

class ErrorSystem {
  final Ref _ref;

  ErrorSystem(this._ref);

  void addError(AppError error) {
    _ref.read(errorProvider.notifier).addError(error);
  }

  void addNetworkError(String message) {
    _ref.read(errorProvider.notifier).addNetworkError(message);
  }

  void addValidationError(String message, {String? code}) {
    _ref.read(errorProvider.notifier).addValidationError(message, code: code);
  }

  void addAuthenticationError(String message) {
    _ref.read(errorProvider.notifier).addAuthenticationError(message);
  }

  void addServerError(String message) {
    _ref.read(errorProvider.notifier).addServerError(message);
  }

  void addUnknownError(String message, [StackTrace? stackTrace]) {
    _ref.read(errorProvider.notifier).addUnknownError(message, stackTrace);
  }

  void clearCurrentError() {
    _ref.read(errorProvider.notifier).clearCurrentError();
  }

  void clearAllErrors() {
    _ref.read(errorProvider.notifier).clearAllErrors();
  }

  void removeError(AppError error) {
    _ref.read(errorProvider.notifier).removeError(error);
  }

  void clearErrorsByType(ErrorType type) {
    _ref.read(errorProvider.notifier).clearErrorsByType(type);
  }

  void showErrorSnackBar(BuildContext context, String message) {
    _ref.read(errorProvider.notifier).showErrorSnackBar(context, message);
  }

  void showSuccessSnackBar(BuildContext context, String message) {
    _ref.read(errorProvider.notifier).showSuccessSnackBar(context, message);
  }
} 