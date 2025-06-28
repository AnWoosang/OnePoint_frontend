import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fitkle/core/utils/responsive.dart';
import 'package:fitkle/core/theme/app_text_styles.dart';
import 'package:fitkle/core/widgets/login_modal.dart';

class HeaderWidget extends StatefulWidget {
  final bool isApp;

  const HeaderWidget({
    super.key,
    required this.isApp,
  });

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  bool _isLoggedIn = false; // mock 로그인 상태

  void _mockLogin() async {
    // 로그인 모달 닫고 로그인 상태로 전환
    setState(() {
      _isLoggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.getResponsiveHorizontalPadding(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 24),
      child: Row(
        children: [
          // 로고
          GestureDetector(
            onTap: () {
              // TODO: 홈으로 이동
            },
            child: SvgPicture.asset(
              'assets/logo/FITKLE.svg',
              height: 24, // 로고 높이 조절
            ),
          ),
          const SizedBox(width: 30),

          // 왼쪽 메뉴
          ...['견적요청', '고수찾기', '마켓', '커뮤니티'].map((label) => Padding(
            padding: const EdgeInsets.only(right: 15),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  // TODO: 각 메뉴별 라우팅
                },
                child: Text(label, style: AppTextStyles.headerLeftMenuDesktop),
              ),
            ),
          )),

          Expanded(child: Container()),

          if (!_isLoggedIn) ...[
            // 로그인/튜터등록
            ...['로그인', '튜터등록'].map((label) => Padding(
              padding: const EdgeInsets.only(left: 15),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    if (label == '로그인') {
                      // 로그인 모달 열고, 성공 시 _mockLogin 호출
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return LoginModal(
                            onLoginSuccess: _mockLogin,
                          );
                        },
                      );
                    }
                    // TODO: 튜터등록 라우팅
                  },
                  child: Text(label, style: AppTextStyles.headerRightMenuDesktop),
                ),
              ),
            )),
          ] else ...[
            // 1. 구매관리(텍스트)
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {},
                  child: Text('구매 관리', style: AppTextStyles.headerRightMenuDesktop),
                ),
              ),
            ),
            // 2. 채팅
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {},
                  child: Tooltip(
                    message: '채팅',
                    child: Icon(Icons.chat_bubble_outline, size: 24, color: Colors.black),
                  ),
                ),
              ),
            ),
            // 3. 알림
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {},
                  child: Tooltip(
                    message: '알림',
                    child: Icon(Icons.notifications_none, size: 24, color: Colors.black),
                  ),
                ),
              ),
            ),
            // 4. 좋아요
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {},
                  child: Tooltip(
                    message: '좋아요',
                    child: Icon(Icons.favorite_border, size: 24, color: Colors.black),
                  ),
                ),
              ),
            ),
            // 5. 프로필(아바타 + 드롭다운)
            _ProfileDropdown(),
          ],
        ],
      ),
    );
  }
}

// 프로필 드롭다운 위젯
class _ProfileDropdown extends StatefulWidget {
  @override
  State<_ProfileDropdown> createState() => _ProfileDropdownState();
}

class _ProfileDropdownState extends State<_ProfileDropdown> {
  OverlayEntry? _overlayEntry;
  OverlayEntry? _submenuEntry;
  final LayerLink _layerLink = LayerLink();
  final LayerLink _submenuLink = LayerLink();
  bool _isProfileHovering = false;
  bool _isProfileOverlayHovering = false;
  bool _isInfoOverlayHovering = false;
  bool _isSubmenuTriggerHovering = false;
  bool _submenuOpen = false;

  void _showOverlay() {
    if (_overlayEntry != null) return;
    _overlayEntry = _buildOverlay();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _hideSubmenu();
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isProfileOverlayHovering = false;
      _isSubmenuTriggerHovering = false;
    });
  }

  void _tryHideProfileOverlay() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!_isProfileHovering && !_isProfileOverlayHovering && !_isInfoOverlayHovering && !_isSubmenuTriggerHovering) {
        _hideOverlay();
      }
    });
  }

  void _tryHideInfoOverlay() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!_isInfoOverlayHovering && !_isSubmenuTriggerHovering) {
        _hideSubmenu();
      }
    });
  }

  void _forceHideAllOverlays() {
    _hideOverlay();
  }

  void _showSubmenu(Offset parentOffset, double parentHeight) {
    if (_submenuEntry != null) {
      _submenuEntry!.remove();
      _submenuEntry = null;
    }
    _submenuEntry = _buildSubmenu(parentOffset, parentHeight);
    Overlay.of(context).insert(_submenuEntry!);
    setState(() {
      _submenuOpen = true;
    });
  }

  void _hideSubmenu() {
    _submenuEntry?.remove();
    _submenuEntry = null;
    setState(() { 
      _submenuOpen = false;
      _isInfoOverlayHovering = false;
    });
  }

  OverlayEntry _buildOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 8,
        child: MouseRegion(
          onEnter: (_) {
            setState(() => _isProfileOverlayHovering = true);
          },
          onExit: (_) {
            setState(() => _isProfileOverlayHovering = false);
            // 메인 오버레이를 벗어날 때 짧은 지연 후 모든 오버레이 닫기
            Future.delayed(const Duration(milliseconds: 50), () {
              if (!_isProfileHovering && !_isProfileOverlayHovering && !_isInfoOverlayHovering && !_isSubmenuTriggerHovering) {
                _forceHideAllOverlays();
              }
            });
          },
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 180,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildMenuItem('프로필 관리'),
                  _buildMenuItemWithSubmenu('내 정보 관리'),
                  _buildMenuItem('친구 초대'),
                  _buildMenuItem('고객센터'),
                  _buildMenuItem('전문가 등록'),
                  _buildMenuItem('비즈계정 신청'),
                  Divider(height: 16, thickness: 1, color: Colors.grey[200]),
                  _buildMenuItem('로그아웃'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String text, {IconData? trailing}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _isSubmenuTriggerHovering = false;
        });
        if (_submenuOpen) {
          _hideSubmenu();
        }
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          hoverColor: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text, style: TextStyle(fontSize: 15, color: Colors.black)),
                if (trailing != null) Icon(trailing, size: 18, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItemWithSubmenu(String text) {
    return StatefulBuilder(
      builder: (context, setStateSB) {
        return MouseRegion(
          onEnter: (_) {
            setState(() {
              _isSubmenuTriggerHovering = true;
              _isInfoOverlayHovering = true;
            });
            setStateSB(() {});
            RenderBox? itemBox = context.findRenderObject() as RenderBox?;
            if (itemBox != null) {
              final itemOffset = itemBox.localToGlobal(Offset.zero);
              final itemHeight = itemBox.size.height;
              _showSubmenu(itemOffset, itemHeight);
            }
          },
          onExit: (_) {
            setState(() {
              _isSubmenuTriggerHovering = false;
            });
            // 서브메뉴 트리거를 벗어날 때 상태 확인
            Future.delayed(const Duration(milliseconds: 50), () {
              if (!_isInfoOverlayHovering && !_isSubmenuTriggerHovering) {
                _hideSubmenu();
              }
              if (!_isProfileHovering && !_isProfileOverlayHovering && !_isInfoOverlayHovering && !_isSubmenuTriggerHovering) {
                _forceHideAllOverlays();
              }
            });
          },
          child: InkWell(
            onTap: () {},
            hoverColor: const Color(0xFFF5F6F8),
            borderRadius: BorderRadius.zero,
            child: Container(
              color: _submenuOpen ? const Color(0xFFF5F6F8) : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(text, style: TextStyle(fontSize: 15, color: Colors.black)),
                    Text('›', style: TextStyle(fontSize: 22, color: Color(0xFFB0B0B0))),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  OverlayEntry _buildSubmenu(Offset parentOffset, double parentHeight) {
    const double overlayWidth = 150;
    const double overlayGap = 8; // 부모 오버레이와의 간격
    
    return OverlayEntry(
      builder: (context) => Positioned(
        left: parentOffset.dx + 180 + overlayGap, // 부모 오버레이 오른쪽에 바로 배치
        top: parentOffset.dy - 8, // 부모 메뉴 항목과 정렬
        child: MouseRegion(
          onEnter: (_) => setState(() => _isInfoOverlayHovering = true),
          onExit: (_) {
            setState(() => _isInfoOverlayHovering = false);
            // 서브메뉴를 벗어날 때 짧은 지연 후 상태 확인하여 모든 오버레이 닫기
            Future.delayed(const Duration(milliseconds: 50), () {
              if (!_isProfileHovering && !_isProfileOverlayHovering && !_isInfoOverlayHovering && !_isSubmenuTriggerHovering) {
                _forceHideAllOverlays();
              } else if (!_isInfoOverlayHovering && !_isSubmenuTriggerHovering) {
                _hideSubmenu();
              }
            });
          },
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: overlayWidth,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSubmenuItem('내 정보'),
                  _buildSubmenuItem('전문가 정보'),
                  _buildSubmenuItem('알림 설정'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmenuItem(String text) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          hoverColor: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.zero,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Text(text, style: TextStyle(fontSize: 15, color: Colors.black)),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 2),
      child: CompositedTransformTarget(
        link: _layerLink,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) {
            setState(() => _isProfileHovering = true);
            _showOverlay();
          },
          onExit: (_) {
            setState(() => _isProfileHovering = false);
            // 프로필 아바타를 벗어날 때 상태 확인
            Future.delayed(const Duration(milliseconds: 50), () {
              if (!_isProfileHovering && !_isProfileOverlayHovering && !_isInfoOverlayHovering && !_isSubmenuTriggerHovering) {
                _forceHideAllOverlays();
              }
            });
          },
          child: GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 6),
                const Text('›', style: TextStyle(fontSize: 22, color: Color(0xFFB0B0B0))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}