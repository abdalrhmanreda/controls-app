import 'package:flutter/material.dart';
import 'package:control_app/core/helpers/responsive_text.dart';

enum AppButtonType { elevated, outlined, text }

enum AppButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  // Button content
  final String text;
  final Widget? icon;
  final bool iconOnRight;

  // Button type and style
  final AppButtonType type;
  final AppButtonSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? borderWidth;

  // Layout and spacing
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double? elevation;
  final double iconSpacing;

  // State
  final bool isLoading;
  final bool isDisabled;
  final VoidCallback? onPressed;

  // Text style
  final TextStyle? textStyle;
  final double? fontSize;
  final FontWeight? fontWeight;

  // Additional properties
  final Widget? loadingWidget;
  final AlignmentGeometry? alignment;
  final Gradient? gradient;

  const AppButton({
    super.key,
    required this.text,
    this.icon,
    this.iconOnRight = false,
    this.type = AppButtonType.elevated,
    this.size = AppButtonSize.medium,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.elevation,
    this.iconSpacing = 8.0,
    this.isLoading = false,
    this.isDisabled = false,
    this.onPressed,
    this.textStyle,
    this.fontSize,
    this.fontWeight,
    this.loadingWidget,
    this.alignment,
    this.gradient,
  });

  // Factory constructors for common button types
  factory AppButton.primary({
    required String text,
    Widget? icon,
    bool iconOnRight = false,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    VoidCallback? onPressed,
    double? width,
  }) {
    return AppButton(
      text: text,
      icon: icon,
      iconOnRight: iconOnRight,
      type: AppButtonType.elevated,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      onPressed: onPressed,
      width: width,
    );
  }

  factory AppButton.secondary({
    required String text,
    Widget? icon,
    bool iconOnRight = false,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    VoidCallback? onPressed,
    double? width,
  }) {
    return AppButton(
      text: text,
      icon: icon,
      iconOnRight: iconOnRight,
      type: AppButtonType.outlined,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      onPressed: onPressed,
      width: width,
    );
  }

  factory AppButton.text({
    required String text,
    Widget? icon,
    bool iconOnRight = false,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    VoidCallback? onPressed,
    double? width,
  }) {
    return AppButton(
      text: text,
      icon: icon,
      iconOnRight: iconOnRight,
      type: AppButtonType.text,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      onPressed: onPressed,
      width: width,
    );
  }

  // Get button dimensions based on size
  EdgeInsetsGeometry _getPadding() {
    if (padding != null) return padding!;

    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }

  double _getFontSize(context) {
    if (fontSize != null) return fontSize!;

    switch (size) {
      case AppButtonSize.small:
        return getResponsiveFontSize(context, fontSize: 12);
      case AppButtonSize.medium:
        return getResponsiveFontSize(context, fontSize: 14);
      case AppButtonSize.large:
        return getResponsiveFontSize(context, fontSize: 16);
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

  // Build button content (text + icon)
  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return loadingWidget ??
          SizedBox(
            width: _getIconSize(),
            height: _getIconSize(),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          );
    }

    final textWidget = Text(
      text,
      style:
          textStyle ??
          TextStyle(
            fontSize: _getFontSize(context),
            fontWeight: fontWeight ?? FontWeight.w600,
          ),
    );

    if (icon == null) {
      return textWidget;
    }

    // Icon with text
    final iconWidget = IconTheme(
      data: IconThemeData(size: _getIconSize(), color: foregroundColor),
      child: icon!,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: iconOnRight
          ? [textWidget, SizedBox(width: iconSpacing), iconWidget]
          : [iconWidget, SizedBox(width: iconSpacing), textWidget],
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = _buildContent(context);
    final isEnabled = !isDisabled && !isLoading && onPressed != null;
    final buttonBorderRadius = borderRadius ?? 12.0;

    Widget button;

    switch (type) {
      case AppButtonType.elevated:
        button = ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: gradient != null
                ? Colors.transparent
                : backgroundColor,
            foregroundColor: foregroundColor,
            shadowColor: gradient != null ? Colors.transparent : null,
            disabledBackgroundColor: backgroundColor,
            disabledForegroundColor: foregroundColor?.withValues(alpha: 0.4),
            padding: _getPadding(),
            elevation: gradient != null ? 0 : elevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonBorderRadius),
            ),
            minimumSize: height != null ? Size.fromHeight(height!) : null,
            alignment: alignment,
          ),
          child: content,
        );

        if (gradient != null) {
          button = Container(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(buttonBorderRadius),
            ),
            child: button,
          );
        }
        break;

      case AppButtonType.outlined:
        button = OutlinedButton(
          onPressed: isEnabled ? onPressed : null,
          style: OutlinedButton.styleFrom(
            foregroundColor: foregroundColor,
            disabledForegroundColor: foregroundColor?.withValues(alpha: 0.4),
            padding: _getPadding(),
            side: BorderSide(
              color:
                  borderColor ??
                  foregroundColor ??
                  Theme.of(context).colorScheme.primary,
              width: borderWidth ?? 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonBorderRadius),
            ),
            minimumSize: height != null ? Size.fromHeight(height!) : null,
            alignment: alignment,
          ),
          child: content,
        );
        break;

      case AppButtonType.text:
        button = TextButton(
          onPressed: isEnabled ? onPressed : null,
          style: TextButton.styleFrom(
            foregroundColor: foregroundColor,
            disabledForegroundColor: foregroundColor?.withValues(alpha: 0.4),
            padding: _getPadding(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonBorderRadius),
            ),
            minimumSize: height != null ? Size.fromHeight(height!) : null,
            alignment: alignment,
          ),
          child: content,
        );
        break;
    }

    if (width != null) {
      return SizedBox(width: width, child: button);
    }

    return button;
  }
}

// Example Usage:
/*
// Simple text button
AppButton(
  text: 'Click Me',
  onPressed: () => print('Clicked'),
)

// Button with icon on left
AppButton(
  text: 'Save',
  icon: Icon(Icons.save),
  onPressed: () => print('Saved'),
)

// Button with icon on right
AppButton(
  text: 'Next',
  icon: Icon(Icons.arrow_forward),
  iconOnRight: true,
  onPressed: () => print('Next'),
)

// Loading button
AppButton(
  text: 'Submit',
  isLoading: true,
  onPressed: () {},
)

// Using factory constructors
AppButton.primary(
  text: 'Primary Button',
  icon: Icon(Icons.check),
  size: AppButtonSize.large,
  onPressed: () {},
)

AppButton.secondary(
  text: 'Secondary Button',
  icon: Icon(Icons.info),
  onPressed: () {},
)

AppButton.text(
  text: 'Text Button',
  onPressed: () {},
)

// Custom styled button
AppButton(
  text: 'Custom',
  icon: Icon(Icons.star),
  type: AppButtonType.elevated,
  size: AppButtonSize.large,
  backgroundColor: Colors.purple,
  foregroundColor: Colors.white,
  borderRadius: 20,
  width: double.infinity,
  onPressed: () {},
)
*/
