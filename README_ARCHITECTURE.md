# 🏗️ Flutter 프로덕션 레벨 아키텍처

## 📁 폴더 구조

```
lib/
├── app/                          # 앱 레벨 설정
│   ├── app.dart                  # 앱 루트 및 Provider 설정
│   └── router/                   # 라우팅 설정
│       ├── app_router.dart       # 중앙화된 라우터
│       └── route_names.dart      # 라우트 상수
├── core/                         # 핵심 공통 기능
│   ├── providers/                # 상태 관리
│   │   ├── auth_provider.dart    # 인증 상태
│   │   ├── app_provider.dart     # 앱 설정
│   │   ├── error_provider.dart   # 에러 처리
│   │   └── cursor_provider.dart  # 마우스 커서 관리
│   ├── theme/                    # 테마 시스템
│   │   └── app_theme.dart        # 통합 테마
│   ├── widgets/                  # 재사용 가능한 위젯
│   │   ├── buttons/              # 버튼 컴포넌트
│   │   │   └── app_button.dart   # 통합 버튼
│   │   ├── tabs/                 # 탭 컴포넌트
│   │   │   └── app_tab_bar.dart  # 통합 탭바
│   │   └── layout/               # 레이아웃 컴포넌트
│   │       └── app_scaffold.dart # 중앙화된 레이아웃
│   └── utils/                    # 유틸리티
│       └── performance_utils.dart # 성능 최적화
└── features/                     # 기능별 모듈
    ├── auth/                     # 인증 기능
    ├── home/                     # 홈 기능
    ├── profile/                  # 프로필 기능
    ├── search/                   # 검색 기능
    └── tutor/                    # 튜터 기능
```

## 🎯 핵심 설계 원칙

### 1. 중앙화된 마우스 커서 관리
- **CursorProvider**: 전역에서 마우스 커서 상태 관리
- **하위 위젯**: 호버 이벤트만 전송, 커서 직접 설정 금지
- **일관성**: 모든 인터랙티브 요소에서 동일한 커서 동작

### 2. 통합 테마 시스템
- **AppTheme**: 색상, 폰트, 패딩, 그림자 등 모든 디자인 토큰 중앙 관리
- **ThemeData**: Material Design 3 기반 테마
- **일관성**: 모든 컴포넌트에서 동일한 디자인 시스템 사용

### 3. 재사용 가능한 컴포넌트
- **AppButton**: 다양한 스타일과 크기의 버튼
- **AppTabBar**: 표준화된 탭 인터페이스
- **AppScaffold**: 중앙화된 레이아웃 관리

## 🚀 사용법

### 마우스 커서 관리

```dart
// 하위 위젯에서 호버 이벤트만 전송
Consumer<CursorProvider>(
  builder: (context, cursorProvider, _) {
    return MouseRegion(
      cursor: cursorProvider.systemCursor,
      onEnter: (_) => cursorProvider.startHover(CursorType.pointer),
      onExit: (_) => cursorProvider.endHover(),
      child: GestureDetector(
        onTap: () => onPressed(),
        child: YourWidget(),
      ),
    );
  },
);
```

### 버튼 사용

```dart
// 기본 버튼
AppButton(
  text: '클릭하세요',
  onPressed: () => handleClick(),
  type: AppButtonType.primary,
  size: AppButtonSize.medium,
);

// 아이콘 버튼
AppButton.icon(
  icon: Icons.add,
  onPressed: () => handleAdd(),
  type: AppButtonType.secondary,
);

// 텍스트 버튼
AppButton(
  text: '링크',
  type: AppButtonType.text,
  onPressed: () => handleLink(),
);
```

### 탭바 사용

```dart
AppTabBar(
  tabs: ['탭1', '탭2', '탭3'],
  currentIndex: currentIndex,
  onTabChanged: (index) => setState(() => currentIndex = index),
  style: AppTabBarStyle.standard,
);
```

### 레이아웃 사용

```dart
AppScaffold(
  title: '페이지 제목',
  child: YourContent(),
  showHeader: true,
  showFooter: true,
  showBottomNav: true,
);
```

## 🎨 테마 사용

```dart
// 색상 사용
color: AppTheme.primaryColor
color: AppTheme.textSecondary

// 패딩 사용
padding: EdgeInsets.all(AppTheme.paddingM)
margin: EdgeInsets.symmetric(horizontal: AppTheme.marginL)

// 반지름 사용
borderRadius: BorderRadius.circular(AppTheme.radiusM)

// 그림자 사용
boxShadow: AppTheme.shadowM

// 애니메이션 사용
duration: AppTheme.animationNormal
```

## 🔧 상태 관리

### Provider 구조
```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => AppProvider()),
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => ErrorProvider()),
    ChangeNotifierProvider(create: (_) => CursorProvider()),
  ],
  child: MaterialApp(...),
);
```

### 에러 처리
```dart
// 에러 표시
context.read<ErrorProvider>().showErrorSnackBar(context, '에러 메시지');

// 에러 상태 확인
Consumer<ErrorProvider>(
  builder: (context, errorProvider, _) {
    if (errorProvider.hasError) {
      // 에러 처리
    }
    return YourWidget();
  },
);
```

## 📈 성능 최적화

### RepaintBoundary 사용
```dart
PerformanceUtils.optimizeRebuild(
  child: YourWidget(),
  keys: [key1, key2],
);
```

### 이미지 최적화
```dart
PerformanceUtils.getOptimizedImage(
  imageUrl: 'https://example.com/image.jpg',
  width: 200,
  height: 200,
);
```

## 🔄 마이그레이션 가이드

### 기존 코드에서 새 구조로 변경

1. **마우스 커서**: `MouseRegion`을 `CursorProvider`와 함께 사용
2. **버튼**: `ElevatedButton`을 `AppButton`으로 교체
3. **탭**: 커스텀 탭을 `AppTabBar`로 교체
4. **레이아웃**: `PageScaffold`를 `AppScaffold`로 교체
5. **스타일**: 하드코딩된 값을 `AppTheme` 상수로 교체

### 예시 변환

**Before:**
```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF3B63C4),
    padding: EdgeInsets.all(16),
  ),
  onPressed: () {},
  child: Text('버튼'),
)
```

**After:**
```dart
AppButton(
  text: '버튼',
  type: AppButtonType.primary,
  onPressed: () {},
)
```

## 🎯 장점

1. **일관성**: 모든 UI 요소가 동일한 디자인 시스템 사용
2. **유지보수성**: 중앙화된 관리로 변경사항 적용 용이
3. **재사용성**: 컴포넌트 재사용으로 개발 속도 향상
4. **성능**: 최적화된 렌더링과 메모리 관리
5. **확장성**: 새로운 기능 추가 시 기존 구조 활용 가능
6. **테스트**: 표준화된 컴포넌트로 테스트 작성 용이

이 구조는 실제 프로덕션 환경에서 사용되는 Flutter 앱의 베스트 프랙티스를 따르며, 팀 개발과 장기 유지보수에 최적화되어 있습니다. 