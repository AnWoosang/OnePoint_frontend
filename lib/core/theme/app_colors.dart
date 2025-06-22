import 'package:flutter/material.dart';

class AppColors {
  // ✅ 기본 색상
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color red = Color(0xFFFF3B30);

  // ✅ 브랜드 색상
  static const Color primary = Color(0xFF7C3AED); // 예: 보라색 (Tailwind violet-600 기준)
  static const Color primaryLight = Color(0xFFEDE9FE); // 보라빛 연한 배경
  static const Color primaryDark = Color(0xFF5B21B6);

  // ✅ 중립 계열 (Gray Scale)
  static const Color grayDark = Color(0xFF4B5563);   // 제목 등
  static const Color gray = Color(0xFF6B7280);       // 일반 텍스트
  static const Color grayLight = Color(0xFFD1D5DB);  
  static const Color gray2 = Color.fromARGB(255, 171, 172, 175);  
  static const Color grayLighter = Color(0xFFF3F4F6); // 배경
  static const Color grayBackground = Color(0xFFFAFAFA); // 아주 연한 배경

  // ✅ 상태 색상 (선택사항)
  static const Color success = Color(0xFF10B981); // 초록
  static const Color warning = Color(0xFFF59E0B); // 주황
  static const Color error = Color(0xFFEF4444);   // 빨강

  // ✅ 텍스트 컬러
  static const Color textDefault = gray;
  static const Color textMuted = grayLight;
  static const Color textHeading = black;

  // ✅ Divider, Border
  static const Color divider = grayLight;
  static const Color dividerGray = gray;

  // 🏠 Home / KeywordTrendWidget
  static const Color keywordChipBackground = Color(0xFFF3E8FF); // Colors.purple.shade50

  // 🏠 Home / BrandSectionWidget
  static const Color brandChipBackground = Color(0xFFF3F4F6); // Colors.grey.shade100

  // 🏠 Home / AdBannerWidget
  static const Color adBannerBackground = Color(0xFFE0E0E0); // = Colors.grey[300]

  // 🧩 Overlay / ProductOverlay
  static const Color grayBorderLight = Color(0xFFD4D1D1); // 버튼 테두리용
}