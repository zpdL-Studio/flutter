import 'package:flutter/material.dart';

class DynamicLabelStyle extends ThemeExtension<DynamicLabelStyle> {
  static const BorderRadiusGeometry defaultBorderRadius = BorderRadius.all(
      Radius.circular(4));
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.symmetric(
      vertical: 4, horizontal: 8);

  const DynamicLabelStyle({
    this.borderRadius = defaultBorderRadius,
    this.side = BorderSide.none,
    required this.backgroundColor,
    required this.foregroundColor,
    this.padding = defaultPadding,
    this.textStyle = const TextStyle(),

  });

  final BorderRadiusGeometry borderRadius;
  final BorderSide side;
  final Color backgroundColor;
  final Color foregroundColor;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;

  @override
  ThemeExtension<DynamicLabelStyle> copyWith({
    BorderRadiusGeometry? borderRadius,
    BorderSide? side,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
  }) =>
      DynamicLabelStyle(
        borderRadius: borderRadius ?? this.borderRadius,
        side: side ?? this.side,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        foregroundColor:
        foregroundColor ?? this.foregroundColor,
        padding:
        padding ?? this.padding,
        textStyle:
        textStyle ?? this.textStyle,
      );

  @override
  ThemeExtension<DynamicLabelStyle> lerp(
      covariant ThemeExtension<DynamicLabelStyle>? other, double t) {
    return this;
  }
}

class DynamicLabel extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final BorderSide? side;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final VoidCallback? onTap;
  final Widget child;

  const DynamicLabel({
    super.key,
    this.borderRadius,
    this.side,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.textStyle,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = (theme.extension<DynamicLabelStyle>() ??
            DynamicLabelStyle(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary))
        .copyWith(
      borderRadius: borderRadius,
      side: side,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: padding,
      textStyle: textStyle,
    ) as DynamicLabelStyle;

    return Material(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: style.borderRadius,
        side: style.side,
      ),
      color: style.backgroundColor,
      child: InkWell(
        onTap: onTap,
        hoverColor: style.foregroundColor.withOpacity(0.04),
        splashColor: style.foregroundColor.withOpacity(0.12),
        highlightColor: style.foregroundColor.withOpacity(0.12),
        child: Padding(
          padding: style.padding,
          child: DefaultTextStyle(
            style: style.textStyle.copyWith(color: style.foregroundColor),
            child: child,
          ),
        ),
      ),
    );
  }
}

class DynamicCircleLabel extends StatelessWidget {
  final BorderSide? side;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final VoidCallback? onTap;
  final Widget child;

  const DynamicCircleLabel({
    super.key,
    this.side,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.textStyle,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = (theme.extension<DynamicLabelStyle>() ??
        DynamicLabelStyle(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary))
        .copyWith(
      side: side,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: padding,
      textStyle: textStyle,
    ) as DynamicLabelStyle;

    return Material(
      clipBehavior: Clip.hardEdge,
      shape: CircleBorder(
        side: style.side,
      ),
      color: style.backgroundColor,
      child: InkWell(
        onTap: onTap,
        hoverColor: style.foregroundColor.withOpacity(0.04),
        splashColor: style.foregroundColor.withOpacity(0.12),
        highlightColor: style.foregroundColor.withOpacity(0.12),
        child: Padding(
          padding: style.padding,
          child: DefaultTextStyle(
            style: style.textStyle.copyWith(color: style.foregroundColor),
            child: child,
          ),
        ),
      ),
    );
  }
}
