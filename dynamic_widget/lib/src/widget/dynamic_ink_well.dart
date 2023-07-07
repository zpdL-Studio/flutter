import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';

class DynamicInkWellStyle extends ThemeExtension<DynamicInkWellStyle> {

  const DynamicInkWellStyle({
    this.shape = const RoundedRectangleBorder(side: BorderSide.none),
    this.backgroundColor = Colors.transparent,
    this.foregroundColor = Colors.black,
    this.elevation = 0,
  });

  final ShapeBorder? shape;
  final Color backgroundColor;
  final Color foregroundColor;
  final double elevation;

  @override
  ThemeExtension<DynamicInkWellStyle> copyWith({
    ShapeBorder? shape,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
    double? elevation,
  }) =>
      DynamicInkWellStyle(
        shape: shape ?? this.shape,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        foregroundColor: foregroundColor ?? this.foregroundColor,
        elevation: elevation ?? this.elevation,
      );

  @override
  ThemeExtension<DynamicInkWellStyle> lerp(
      covariant ThemeExtension<DynamicInkWellStyle>? other, double t) {
    return this;
  }
}

class DynamicInkWell extends StatelessWidget {
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDoubleTap;
  final GestureLongPressCallback? onLongPress;
  final GestureTapDownCallback? onTapDown;
  final GestureTapCancelCallback? onTapCancel;
  final ValueChanged<bool>? onHighlightChanged;
  final ValueChanged<bool>? onHover;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final ShapeBorder? shape;
  final double? elevation;
  final bool inkWellIsTop;

  final Widget child;

  const DynamicInkWell({
    super.key,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapCancel,
    this.onHighlightChanged,
    this.onHover,
    this.backgroundColor,
    this.foregroundColor,
    this.shape,
    this.elevation,
    this.inkWellIsTop = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = (theme.extension<DynamicInkWellStyle>() ??
            DynamicInkWellStyle(
                backgroundColor: Colors.transparent,
                foregroundColor: theme.textColor))
        .copyWith(
      shape: shape,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
    ) as DynamicInkWellStyle;

    return Material(
      color: style.backgroundColor,
      shape: style.shape,
      clipBehavior: style.shape != null ? Clip.hardEdge : Clip.none,
      elevation: style.elevation,
      child: inkWellIsTop
          ? Stack(
              children: [
                child,
                Positioned.fill(
                  child: _buildInkWell(style, null),
                )
              ],
            )
          : _buildInkWell(style, child),
    );
  }

  Widget _buildInkWell(DynamicInkWellStyle style, Widget? child) {
    return InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onTapDown: onTapDown,
      onTapCancel: onTapCancel,
      onHighlightChanged: onHighlightChanged,
      onHover: onHover,
      hoverColor: style.foregroundColor.withOpacity(0.04),
      splashColor: style.foregroundColor.withOpacity(0.12),
      highlightColor: style.foregroundColor.withOpacity(0.12),
      child: child,
    );
  }
}
