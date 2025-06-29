import 'package:flutter/material.dart';

class PerformanceUtils {
  /// 위젯의 rebuild를 최적화하기 위한 유틸리티
  static Widget optimizeRebuild({
    required Widget child,
    required List<Object?> keys,
  }) {
    return RepaintBoundary(
      child: child,
    );
  }

  /// 이미지 캐싱을 위한 유틸리티
  static void precacheImages(BuildContext context, List<String> imageUrls) {
    for (final url in imageUrls) {
      precacheImage(NetworkImage(url), context);
    }
  }

  /// 메모리 사용량 모니터링
  static void logMemoryUsage(String tag) {
    // Flutter에서는 직접적인 메모리 사용량 측정이 제한적이므로
    // 개발 중에만 사용하는 로그
    debugPrint('Memory Usage [$tag]: ${DateTime.now()}');
  }

  /// 위젯 트리 최적화를 위한 키 생성
  static Key generateKey(String prefix, String identifier) {
    return ValueKey('${prefix}_$identifier');
  }

  /// 스크롤 성능 최적화
  static ScrollPhysics getOptimizedScrollPhysics() {
    return const ClampingScrollPhysics();
  }

  /// 애니메이션 성능 최적화
  static Duration getOptimizedAnimationDuration() {
    return const Duration(milliseconds: 300);
  }

  /// 이미지 로딩 최적화
  static Widget getOptimizedImage({
    required String imageUrl,
    required double width,
    required double height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(Icons.error),
        );
      },
    );
  }
} 