import 'package:fitkle/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkle/core/widgets/layout/page_scaffold.dart';
import 'package:fitkle/core/utils/responsive.dart';

class ProfileManageScreen extends ConsumerStatefulWidget {
  const ProfileManageScreen({super.key});

  @override
  ConsumerState<ProfileManageScreen> createState() => _ProfileManageScreenState();
}

class _ProfileManageScreenState extends ConsumerState<ProfileManageScreen> {
  int _selectedTab = 0;
  final _scrollController = ScrollController();
  final _expertInfoKey = GlobalKey();
  final _serviceKey = GlobalKey();
  final _tabBarKey = GlobalKey();
  bool _isTabBarSticky = false;
  double _tabBarHeight = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateTabBarHeight());
  }

  void _updateTabBarHeight() {
    final box = _tabBarKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      setState(() {
        _tabBarHeight = box.size.height;
      });
    }
  }

  void _handleScroll() {
    final tabBarBox = _tabBarKey.currentContext?.findRenderObject() as RenderBox?;
    if (tabBarBox != null) {
      final tabBarOffset = tabBarBox.localToGlobal(Offset.zero).dy;
      final isSticky = tabBarOffset <= kToolbarHeight + 1; // 헤더 아래에 닿으면 고정
      if (_isTabBarSticky != isSticky) {
        setState(() {
          _isTabBarSticky = isSticky;
        });
      }
    }
  }

  void _onTabTap(int index) {
    setState(() => _selectedTab = index);
    final targetKey = index == 0 ? _expertInfoKey : _serviceKey;
    final context = targetKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        alignment: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.getResponsiveHorizontalPadding(context);
    return PageScaffold(
      showHeader: true,
      showFooter: true,
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const _ProfileHeader(),
                      _ProfileTabBar(
                        key: _tabBarKey,
                        selectedTab: _selectedTab,
                        onTap: _onTabTap,
                      ),
                      _ProfileMainContent(key: _expertInfoKey),
                      _ProfileServiceSection(key: _serviceKey),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isTabBarSticky)
            Positioned(
              top: kToolbarHeight + 1, // 헤더 아래에 고정
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: _ProfileTabBar(
                  selectedTab: _selectedTab,
                  onTap: _onTabTap,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F9FB),
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 프로필 이미지
            Container(
              width: 116,
              height: 116,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: const Color(0xFFE5E7EB), width: 2),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/profile_penguin.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 56, color: Color(0xFFBDBDBD)),
                ),
              ),
            ),
            const SizedBox(width: 24),
            // 닉네임, 평점
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '교양있는까치2475',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: Colors.black),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      ...List.generate(5, (i) => const Icon(Icons.star, size: 15, color: Color(0xFFE0E0E0))),
                      const Text('0.0 (0)', style: TextStyle(fontSize: 13, color: Color(0xFFBDBDBD))),
                    ],
                  ),
                ],
              ),
            ),
            // 프로필 등록/수정 버튼
            Column(
              children: [
                const SizedBox(height: 5),
                SizedBox(
                  width: 240,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.limeOlive,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                    ),
                    onPressed: () {},
                    child: const Text('프로필 등록/수정', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTabBar extends StatefulWidget {
  final int selectedTab;
  final void Function(int) onTap;
  const _ProfileTabBar({Key? key, required this.selectedTab, required this.onTap}) : super(key: key);

  @override
  State<_ProfileTabBar> createState() => _ProfileTabBarState();
}

class _ProfileTabBarState extends State<_ProfileTabBar> {
  final List<GlobalKey> _tabKeys = [GlobalKey(), GlobalKey()];
  double _tab0Left = 0;
  double _tab1Left = 0;
  double _tab0Width = 0;
  double _tab1Width = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateTabMetrics();
      setState(() {}); // 최초 렌더 후 강제 갱신
    });
  }

  @override
  void didUpdateWidget(covariant _ProfileTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateTabMetrics());
  }

  void _updateTabMetrics() {
    final box0 = _tabKeys[0].currentContext?.findRenderObject() as RenderBox?;
    final box1 = _tabKeys[1].currentContext?.findRenderObject() as RenderBox?;
    final rowBox = context.findRenderObject() as RenderBox?;
    if (box0 != null && box1 != null && rowBox != null) {
      final rowOffset = rowBox.localToGlobal(Offset.zero);
      final tab0Offset = box0.localToGlobal(Offset.zero);
      final tab1Offset = box1.localToGlobal(Offset.zero);
      setState(() {
        _tab0Left = tab0Offset.dx - rowOffset.dx;
        _tab1Left = tab1Offset.dx - rowOffset.dx;
        _tab0Width = box0.size.width;
        _tab1Width = box1.size.width;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      child: Stack(
        children: [
          // Row(탭들) + 기본 Divider
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ProfileTab(
                    key: _tabKeys[0],
                    text: '전문가 정보',
                    selected: widget.selectedTab == 0,
                    onTap: () => widget.onTap(0),
                  ),
                  _ProfileTab(
                    key: _tabKeys[1],
                    text: '서비스',
                    selected: widget.selectedTab == 1,
                    onTap: () => widget.onTap(1),
                  ),
                ],
              ),
              // 기본 연한 밑줄
              Container(
                height: 2,
                color: const Color(0xFFE5E7EB),
              ),
            ],
          ),
          // 선택된 탭 밑줄
          if (widget.selectedTab == 0 && _tab0Width > 0)
            Positioned(
              left: _tab0Left,
              bottom: 0,
              child: Container(
                width: _tab0Width,
                height: 2,
                color: AppColors.limeOlive,
              ),
            ),
          if (widget.selectedTab == 1 && _tab1Width > 0)
            Positioned(
              left: _tab1Left,
              bottom: 0,
              child: Container(
                width: _tab1Width,
                height: 2,
                color: AppColors.limeOlive,
              ),
            ),
        ],
      ),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback? onTap;
  const _ProfileTab({Key? key, required this.text, required this.selected, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: selected ? FontWeight.bold : FontWeight.w700,
            color: selected ? AppColors.black : const Color(0xFFBDBDBD),
          ),
        ),
      ),
    );
  }
}

class _ProfileMainContent extends StatelessWidget {
  const _ProfileMainContent({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(
            flex: 2,
            child: _ExpertInfoSection(),
          ),
          SizedBox(width: 40),
          _ActivityExpertInfoCard(),
        ],
      ),
    );
  }
}

class _ProfileServiceSection extends StatelessWidget {
  const _ProfileServiceSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('서비스', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: const Color(0xFF1A90FF)),
              child: const Text('광고 신청 >', style: TextStyle(fontWeight: FontWeight.w500)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.web_asset, size: 48, color: Color(0xFFE0E0E0)),
                const SizedBox(height: 16),
                const Text('서비스를 등록하여 수익을 얻어보세요!', style: TextStyle(fontSize: 16, color: Color(0xFFBDBDBD))),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(foregroundColor: const Color(0xFF1A90FF)),
                  child: const Text('+ 서비스 등록하기', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _ExpertInfoSection extends StatelessWidget {
  const _ExpertInfoSection();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('전문가 정보', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 48),
        Center(
          child: Column(
            children: const [
              Icon(Icons.description, size: 64, color: Color(0xFFE0E0E0)),
              SizedBox(height: 16),
              Text('자기소개를 준비중입니다.', style: TextStyle(fontSize: 18, color: Color(0xFFBDBDBD))),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActivityExpertInfoCard extends StatelessWidget {
  const _ActivityExpertInfoCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('활동 정보', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 16),
          _ProfileInfoRow(label: '총 작업 수', value: '0개'),
          _ProfileInfoRow(label: '만족도', value: '0%'),
          _ProfileInfoRow(label: '평균 응답 시간', value: '아직 몰라요'),
          SizedBox(height: 32),
          Text('전문가 정보', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 16),
          _ProfileInfoRow(label: '회원구분', value: '개인회원'),
          _ProfileInfoRow(label: '연락 가능 시간', value: '10시 ~ 18시'),
          _ProfileInfoRow(label: '지역', value: '미입력'),
        ],
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _ProfileInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 15, color: Color(0xFF757575))),
          Text(value, style: const TextStyle(fontSize: 15, color: Colors.black)),
        ],
      ),
    );
  }
}