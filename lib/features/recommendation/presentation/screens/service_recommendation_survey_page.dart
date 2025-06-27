import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkle/core/theme/app_colors.dart';

class ServiceRecommendationSurveyPage extends StatefulWidget {
  const ServiceRecommendationSurveyPage({super.key});

  @override
  State<ServiceRecommendationSurveyPage> createState() => _ServiceRecommendationSurveyPageState();
}

class _ServiceRecommendationSurveyPageState extends State<ServiceRecommendationSurveyPage> {
  int currentStep = 1;
  String? selectedCategory;
  String? selectedDetail;

  final Map<String, List<String>> detailServices = {
    '디자인': [
      '로고 디자인', '패키지', '웹 UI·UX', '3D 공간 모델링',
      '3D 제품모델링·렌더링', '앱·모바일 UI·UX', '책표지·내지', '템플릿형 홈페이지',
    ],
    '마케팅': [
      'SNS 마케팅', '검색광고', '바이럴', '콘텐츠 마케팅',
      '오프라인 마케팅', '마케팅 전략', '이벤트/프로모션', '기타',
    ],
    '번역·통역': [
      '영한 번역', '한영 번역', '일한 번역', '중한 번역',
      '통역', '기타',
    ],
    '문서·글쓰기': [
      '기획서 작성', '보고서 작성', '이력서/자소서', '논문/학술', '카피라이팅', '기타',
    ],
    'IT·프로그래밍': [
      '웹 개발', '앱 개발', 'AI/머신러닝', '데이터 분석', '서버/클라우드', '기타',
    ],
    '영상·사진·음향': [
      '영상 편집', '촬영', '음향/녹음', '사진 보정', '기타',
    ],
    '세무·법무·노무': [
      '세무 상담', '법률 상담', '노무 상담', '계약서 작성', '기타',
    ],
    '전자책': [
      '전자책 제작', '전자책 유통', '기타',
    ],
  };

  static const double kDialogWidth = 340;
  static const double kMainWidth = 500;
  static const double kButtonHeight = 70;
  static const double kButtonWidth = 500;
  static const double kSurveyCardHeight = 200;

  void showRecommendationDialog(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.40;
    final verticalPadding = size.height * 0.26;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Center(
          child: SizedBox(
            width: kDialogWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 0,
                        child: Icon(Icons.celebration, color: AppColors.limeOlive, size: 60),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 24),
                        child: CircleAvatar(
                          radius: 36,
                          backgroundColor: Color(0xFF2563EB),
                          child: Icon(Icons.star, color: Colors.white, size: 40),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    '관심정보가 저장됐어요!',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '알려주신 내용을 바탕으로\n회원님께 딱 맞는 서비스를 추천해드릴게요!',
                    style: TextStyle(fontSize: 15, color: Colors.black, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.limeOlive,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                        textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      onPressed: () => GoRouter.of(context).go('/'),
                      child: Text('확인'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStep1(List<String> options, void Function(int) onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: kMainWidth,
          child: Text(
            '어떤 근무 형태로\n일하고 있나요?',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24, color: Colors.black, height: 1.3),
          ),
        ),
        const SizedBox(height: 32),
        GridView.count(
          crossAxisCount: 1,
          shrinkWrap: true,
          mainAxisSpacing: 16,
          childAspectRatio: 6.0,
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(options.length, (i) =>
            _SurveyCard(
              onTap: () => onTap(i),
              child: Center(
                child: Text(
                  options[i],
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (currentStep == 1) {
      final options = [
        '사업자', '직장인', '예비창업자', '대학(원)생', '프리랜서', '기타'
      ];
      content = buildStep1(options, (i) => setState(() => currentStep = 2));
    } else if (currentStep == 2) {
      final items = [
        ['요식업', Icons.restaurant, Color(0xFF222222)],
        ['도소매/제조업', Icons.inventory, Color(0xFF00C853)],
        ['학원/교육', Icons.menu_book, Color(0xFFFF9800)],
        ['세무/법무/변리', Icons.account_balance, Color(0xFF2962FF)],
        ['병의원/제약', Icons.medical_services, Color(0xFF00C853)],
        ['대행사/에이전시', Icons.campaign, Color(0xFFD50000)],
        ['IT 솔루션', Icons.code, Color(0xFFFFD600)],
        ['헬스/스포츠', Icons.fitness_center, Color(0xFF8E24AA)],
        ['뷰티/미용', Icons.content_cut, Color(0xFFE040FB)],
        ['기타', Icons.apps, Color(0xFF757575)],
      ];
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('현재 하고 있는 일이나', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black, height: 1.3)),
                  Text('예정인 분야를 알려주세요', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black, height: 1.3)),
                ],
              ),
              TextButton.icon(
                onPressed: () => setState(() => currentStep = 1),
                icon: const Icon(Icons.arrow_back, size: 20, color: Color(0xFF9CA3AF)),
                label: const Text('이전으로', style: TextStyle(color: Color(0xFF9CA3AF))),
              ),
            ],
          ),
          const SizedBox(height: 32),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 2.2,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(items.length, (i) {
              return _SurveyCard(
                onTap: () => setState(() => currentStep = 3),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          items[i][0] as String,
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Icon(items[i][1] as IconData, color: items[i][2] as Color, size: 32),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      );
    } else if (currentStep == 3) {
      final items = [
        ['온라인으로\n고객을 만나요', Icons.computer, Color(0xFF00C853)],
        ['대면으로\n직접 고객을 만나요', Icons.apartment, Color(0xFF2962FF)],
        ['온라인과 대면으로\n모두 만나고 있어요', Icons.devices, Color(0xFF00C853)],
      ];
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('주로 어떻게 고객을 만나거나', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black, height: 1.3)),
                  Text('만날 예정인가요?', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black, height: 1.3)),
                ],
              ),
              TextButton.icon(
                onPressed: () => setState(() => currentStep = 2),
                icon: const Icon(Icons.arrow_back, size: 20, color: Color(0xFF9CA3AF)),
                label: const Text('이전으로', style: TextStyle(color: Color(0xFF9CA3AF))),
              ),
            ],
          ),
          const SizedBox(height: 32),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.8,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(items.length, (i) {
              return _SurveyCard(
                onTap: () => setState(() => currentStep = 4),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          items[i][0] as String,
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Icon(items[i][1] as IconData, color: items[i][2] as Color, size: 32),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      );
    } else {
      content = Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (selectedCategory == null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('오늘 핏클에는', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black, height: 1.3)),
                        Text('어떤 서비스를 찾으러 오셨나요?', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black, height: 1.3)),
                      ],
                    ),
                    TextButton.icon(
                      onPressed: () => setState(() => currentStep = 3),
                      icon: const Icon(Icons.arrow_back, size: 20, color: Color(0xFF9CA3AF)),
                      label: const Text('이전으로', style: TextStyle(color: Color(0xFF9CA3AF))),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2.5,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(detailServices.keys.length, (i) =>
                    _SurveyCard(
                      onTap: () => setState(() => selectedCategory = detailServices.keys.elementAt(i)),
                      child: Center(
                        child: Text(
                          detailServices.keys.elementAt(i),
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: selectedCategory,
                                style: const TextStyle(color: AppColors.limeOlive, fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                              const TextSpan(
                                text: '에서',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                            ],
                          ),
                        ),
                        const Text('필요한 서비스를 선택해주세요', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                      ],
                    ),
                    TextButton.icon(
                      onPressed: () => setState(() {
                        selectedCategory = null;
                        selectedDetail = null;
                      }),
                      icon: const Icon(Icons.arrow_back, size: 20, color: Color(0xFF9CA3AF)),
                      label: const Text('이전으로', style: TextStyle(color: Color(0xFF9CA3AF))),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2.8,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(detailServices[selectedCategory!]!.length, (i) =>
                    _SurveyCard(
                      onTap: () => setState(() => selectedDetail = detailServices[selectedCategory!]![i]),
                      selected: selectedDetail == detailServices[selectedCategory!]![i],
                      child: Center(
                        child: Text(
                          detailServices[selectedCategory!]![i],
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 32),
              const Text('찾는게 없다면?', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 15, fontWeight: FontWeight.w900)),
              const SizedBox(height: 32),
              GridView.count(
                crossAxisCount: 1,
                shrinkWrap: true,
                mainAxisSpacing: 8,
                childAspectRatio: 6.0,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _SurveyCard(
                    onTap: () {},
                    child: Center(
                      child: Text('내가 직접 찾을게요', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 48, bottom: 32),
        child: Center(
          child: SizedBox(
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => GoRouter.of(context).go('/'),
                      child: SvgPicture.asset('assets/logo/FITKLE.svg', height: 48),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 500,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(height: 4, color: currentStep >= 1 ? Colors.black : const Color(0xFFF3F4F6), margin: const EdgeInsets.only(right: 4)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(height: 4, color: currentStep >= 2 ? Colors.black : const Color(0xFFF3F4F6), margin: const EdgeInsets.only(right: 4)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(height: 4, color: currentStep >= 3 ? Colors.black : const Color(0xFFF3F4F6), margin: const EdgeInsets.only(right: 4)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(height: 4, color: currentStep >= 4 ? Colors.black : const Color(0xFFF3F4F6)),
                      ),
                      const SizedBox(width: 12),
                      Text('$currentStep/4', style: const TextStyle(color: Color(0xFFD1D5DB), fontWeight: FontWeight.w700, fontSize: 18)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '회원님께 딱 맞는 서비스를 추천해 드릴게요',
                  style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 48),
                content,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: (selectedDetail != null && currentStep == 4)
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(height: 1, thickness: 1, color: Color(0xFFF3F4F6)),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Center(
                  child: SizedBox(
                    width: 500,
                    height: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.limeOlive,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                        textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      onPressed: () => showRecommendationDialog(context),
                      child: Text('서비스 추천 받기'),
                    ),
                  ),
                ),
              ),
            ],
          )
        : null,
    );
  }
}

class _SurveyCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final bool selected;
  const _SurveyCard({required this.child, required this.onTap, this.selected = false});

  @override
  State<_SurveyCard> createState() => _SurveyCardState();
}

class _SurveyCardState extends State<_SurveyCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: _hover ? Color(0xFFF3F4F6) : Color(0xFFF9FAFB),
            border: Border.all(
              color: widget.selected
                ? AppColors.limeOlive
                : (_hover ? AppColors.black : Color(0xFFF3F4F6)),
              width: widget.selected ? 2.5 : 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: widget.child,
        ),
      ),
    );
  }
} 