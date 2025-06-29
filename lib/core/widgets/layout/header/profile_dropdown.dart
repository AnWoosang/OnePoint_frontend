import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileDropdown extends StatefulWidget {
  final VoidCallback onLogout;
  const ProfileDropdown({required this.onLogout, super.key});

  @override
  State<ProfileDropdown> createState() => _ProfileDropdownState();
}

class _ProfileDropdownState extends State<ProfileDropdown> {
  OverlayEntry? _overlayEntry;
  OverlayEntry? _submenuEntry;
  final LayerLink _layerLink = LayerLink();
  final LayerLink _submenuLink = LayerLink();
  bool _isProfileHovering = false;
  bool _isProfileOverlayHovering = false;
  bool _isInfoOverlayHovering = false;
  bool _isSubmenuTriggerHovering = false;
  bool _submenuOpen = false;
  final GlobalKey _arrowKey = GlobalKey();

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
    const double overlayWidth = 150;
    const double overlayGap = 16;
    // 화살표 위치 계산
    RenderBox? arrowBox = _arrowKey.currentContext?.findRenderObject() as RenderBox?;
    Offset arrowOffset = Offset.zero;
    double arrowWidth = 0;
    double arrowHeight = 0;
    if (arrowBox != null) {
      arrowOffset = arrowBox.localToGlobal(Offset.zero);
      arrowWidth = arrowBox.size.width;
      arrowHeight = arrowBox.size.height;
    }
    return OverlayEntry(
      builder: (context) => Positioned(
        left: arrowOffset.dx - overlayWidth + arrowWidth,
        top: arrowOffset.dy + arrowHeight + overlayGap,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
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
          mouseCursor: SystemMouseCursors.click,
          onTap: () {
            if (text == '프로필 관리') {
              context.go('/profile/user');
              _hideOverlay();
            } else if (text == '로그아웃') {
              widget.onLogout();
              _hideOverlay();
            }
          },
          hoverColor: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.zero,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text, style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600)),
                if (trailing != null) Icon(trailing, size: 16, color: Colors.grey),
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
          cursor: SystemMouseCursors.click,
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
            mouseCursor: SystemMouseCursors.click,
            onTap: () {},
            hoverColor: const Color(0xFFF5F6F8),
            borderRadius: BorderRadius.zero,
            child: Container(
              width: double.infinity,
              color: _submenuOpen ? const Color(0xFFF5F6F8) : null,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(text, style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600)),
                  const Icon(Icons.keyboard_arrow_right, size: 16, color: Color(0xFFB0B0B0)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  OverlayEntry _buildSubmenu(Offset parentOffset, double parentHeight) {
    const double overlayWidth = 150;
    const double parentOverlayWidth = 150; // 부모 오버레이 width와 동일하게 맞춤
    const double overlayGap = 6; // 부모 오버레이와의 간격
    
    return OverlayEntry(
      builder: (context) => Positioned(
        left: parentOffset.dx + parentOverlayWidth + overlayGap, // 부모 오버레이 오른쪽에 gap만큼 띄워서 배치
        top: parentOffset.dy, // 부모 메뉴 항목과 정확히 수평 정렬
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
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
          mouseCursor: SystemMouseCursors.click,
          onTap: () {},
          hoverColor: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.zero,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Text(text, style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w500)),
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
                Icon(Icons.keyboard_arrow_down, key: _arrowKey, size: 18, color: Color(0xFFB0B0B0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 