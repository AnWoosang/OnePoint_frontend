import 'package:flutter/material.dart';

class ProfileSubmenu extends StatelessWidget {
  final Function(String) onSubmenuTap;
  const ProfileSubmenu({required this.onSubmenuTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 150,
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
            // 서브 메뉴 항목들: onSubmenuTap으로 콜백 전달
          ],
        ),
      ),
    );
  }
} 