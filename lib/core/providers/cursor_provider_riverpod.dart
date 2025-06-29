import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

enum CursorType { defaultCursor, pointer, text, wait, notAllowed }

class CursorState extends Equatable {
  final CursorType cursorType;
  final bool isHovering;
  final String? hoveredElementId;

  const CursorState({
    this.cursorType = CursorType.defaultCursor,
    this.isHovering = false,
    this.hoveredElementId,
  });

  CursorState copyWith({
    CursorType? cursorType,
    bool? isHovering,
    String? hoveredElementId,
  }) {
    return CursorState(
      cursorType: cursorType ?? this.cursorType,
      isHovering: isHovering ?? this.isHovering,
      hoveredElementId: hoveredElementId ?? this.hoveredElementId,
    );
  }

  @override
  List<Object?> get props => [cursorType, isHovering, hoveredElementId];
}

class CursorNotifier extends StateNotifier<CursorState> {
  CursorNotifier() : super(const CursorState());

  void setCursor(CursorType cursorType) {
    state = state.copyWith(cursorType: cursorType);
  }

  void setHovering(bool isHovering, {String? elementId}) {
    state = state.copyWith(
      isHovering: isHovering,
      hoveredElementId: elementId,
    );
  }

  void resetCursor() {
    state = state.copyWith(
      cursorType: CursorType.defaultCursor,
      isHovering: false,
      hoveredElementId: null,
    );
  }

  void setPointerCursor() {
    setCursor(CursorType.pointer);
  }

  void setTextCursor() {
    setCursor(CursorType.text);
  }

  void setWaitCursor() {
    setCursor(CursorType.wait);
  }

  void setNotAllowedCursor() {
    setCursor(CursorType.notAllowed);
  }
}

// Cursor Provider
final cursorProvider = StateNotifierProvider<CursorNotifier, CursorState>((ref) {
  return CursorNotifier();
});

// Cursor 상태별 Selector Providers
final cursorTypeProvider = Provider<CursorType>((ref) {
  return ref.watch(cursorProvider).cursorType;
});

final isHoveringProvider = Provider<bool>((ref) {
  return ref.watch(cursorProvider).isHovering;
});

final hoveredElementIdProvider = Provider<String?>((ref) {
  return ref.watch(cursorProvider).hoveredElementId;
});

// Cursor 유틸리티 Provider
final cursorSystemProvider = Provider<CursorSystem>((ref) {
  return CursorSystem(ref);
});

class CursorSystem {
  final Ref _ref;

  CursorSystem(this._ref);

  void setPointerCursor() {
    _ref.read(cursorProvider.notifier).setPointerCursor();
  }

  void setTextCursor() {
    _ref.read(cursorProvider.notifier).setTextCursor();
  }

  void setWaitCursor() {
    _ref.read(cursorProvider.notifier).setWaitCursor();
  }

  void setNotAllowedCursor() {
    _ref.read(cursorProvider.notifier).setNotAllowedCursor();
  }

  void resetCursor() {
    _ref.read(cursorProvider.notifier).resetCursor();
  }

  void setHovering(bool isHovering, {String? elementId}) {
    _ref.read(cursorProvider.notifier).setHovering(isHovering, elementId: elementId);
  }
} 