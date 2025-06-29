import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../providers/cursor_provider_riverpod.dart';

enum AppButtonType { primary, secondary, outline, text }

enum AppButtonSize { small, medium, large }

class AppButton extends ConsumerWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final Widget? icon;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.width,
    this.height,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cursorSystem = ref.watch(cursorSystemProvider);
    
    return MouseRegion(
      onEnter: (_) => cursorSystem.setPointerCursor(),
      onExit: (_) => cursorSystem.resetCursor(),
      child: SizedBox(
        width: width,
        height: height ?? _getHeight(),
        child: ElevatedButton(
          onPressed: (isDisabled || isLoading) ? null : onPressed,
          style: _getButtonStyle(),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return SizedBox(
        width: _getIconSize(),
        height: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(_getTextColor()),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          SizedBox(width: _getSpacing()),
          Text(text, style: _getTextStyle()),
        ],
      );
    }

    return Text(text, style: _getTextStyle());
  }

  ButtonStyle _getButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: _getBackgroundColor(),
      foregroundColor: _getTextColor(),
      elevation: _getElevation(),
      shadowColor: _getShadowColor(),
      side: _getBorderSide(),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(_getBorderRadius()),
      ),
      padding: padding ?? EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(),
        vertical: _getVerticalPadding(),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (isDisabled) {
      return Colors.grey[300]!;
    }

    switch (type) {
      case AppButtonType.primary:
        return AppColors.primary;
      case AppButtonType.secondary:
        return Colors.blue;
      case AppButtonType.outline:
      case AppButtonType.text:
        return Colors.transparent;
    }
  }

  Color _getTextColor() {
    if (isDisabled) {
      return Colors.grey[500]!;
    }

    switch (type) {
      case AppButtonType.primary:
      case AppButtonType.secondary:
        return Colors.white;
      case AppButtonType.outline:
        return AppColors.primary;
      case AppButtonType.text:
        return AppColors.primary;
    }
  }

  double _getElevation() {
    if (isDisabled) return 0;
    
    switch (type) {
      case AppButtonType.primary:
      case AppButtonType.secondary:
        return 2;
      case AppButtonType.outline:
      case AppButtonType.text:
        return 0;
    }
  }

  Color? _getShadowColor() {
    if (isDisabled) return null;
    
    switch (type) {
      case AppButtonType.primary:
        return AppColors.primary.withOpacity(0.3);
      case AppButtonType.secondary:
        return Colors.blue.withOpacity(0.3);
      case AppButtonType.outline:
      case AppButtonType.text:
        return null;
    }
  }

  BorderSide? _getBorderSide() {
    if (isDisabled) return null;
    
    switch (type) {
      case AppButtonType.primary:
      case AppButtonType.secondary:
      case AppButtonType.text:
        return null;
      case AppButtonType.outline:
        return BorderSide(color: AppColors.primary, width: 1.5);
    }
  }

  double _getBorderRadius() {
    switch (size) {
      case AppButtonSize.small:
        return 6;
      case AppButtonSize.medium:
        return 8;
      case AppButtonSize.large:
        return 12;
    }
  }

  double _getHeight() {
    switch (size) {
      case AppButtonSize.small:
        return 32;
      case AppButtonSize.medium:
        return 40;
      case AppButtonSize.large:
        return 48;
    }
  }

  double _getHorizontalPadding() {
    switch (size) {
      case AppButtonSize.small:
        return 12;
      case AppButtonSize.medium:
        return 16;
      case AppButtonSize.large:
        return 24;
    }
  }

  double _getVerticalPadding() {
    switch (size) {
      case AppButtonSize.small:
        return 6;
      case AppButtonSize.medium:
        return 8;
      case AppButtonSize.large:
        return 12;
    }
  }

  double _getSpacing() {
    switch (size) {
      case AppButtonSize.small:
        return 6;
      case AppButtonSize.medium:
        return 8;
      case AppButtonSize.large:
        return 12;
    }
  }

  double _getIconSize() {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case AppButtonSize.small:
        return AppTextStyles.caption.copyWith(color: _getTextColor());
      case AppButtonSize.medium:
        return AppTextStyles.body2.copyWith(color: _getTextColor());
      case AppButtonSize.large:
        return AppTextStyles.body1.copyWith(color: _getTextColor());
    }
  }
} 