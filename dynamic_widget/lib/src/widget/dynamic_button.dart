import 'package:flutter/material.dart';

enum DynamicButtonType { elevated, outlined }

enum DynamicButtonStyle {
  text,
  primary,
  primaryContainer,
  secondary,
  secondaryContainer,
  tertiary,
  tertiaryContainer,
  error,
  errorContainer,
  outline,
}

class DynamicButton extends StatelessWidget {
  final DynamicButtonType type;
  final DynamicButtonStyle style;
  final VoidCallback? onPressed;
  final Widget child;

  const DynamicButton(
      {super.key,
      required this.type,
      required this.style,
      this.onPressed,
      required this.child});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case DynamicButtonType.elevated:
        return ElevatedButton(
            onPressed: onPressed,
            style: Theme.of(context).getDynamicElevatedButtonStyle(style),
            child: child);
      case DynamicButtonType.outlined:
        return OutlinedButton(
            onPressed: onPressed,
            style: Theme.of(context).getDynamicOutlinedButtonStyle(style),
            child: child);
    }
  }
}

class DynamicAlignBottomButton extends StatelessWidget {
  final DynamicButtonType type;
  final DynamicButtonStyle style;
  final bool visible;
  final Color? backgroundColor;
  final double? gradientHeight;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final Widget child;

  const DynamicAlignBottomButton(
      {super.key,
      required this.type,
      required this.style,
      this.visible = true,
      this.backgroundColor,
      this.gradientHeight,
      this.padding,
      this.onPressed,
      required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final color = backgroundColor ?? theme.scaffoldBackgroundColor;
    final gradientHeight = this.gradientHeight;
    return Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: visible
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (gradientHeight != null)
                      Container(
                        width: double.infinity,
                        height: gradientHeight,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [color.withOpacity(0.0), color],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    Container(
                        padding: padding,
                        color: color,
                        child: DynamicButton(
                          type: type,
                          style: style,
                          onPressed: onPressed,
                          child: child,
                        )),
                  ],
                )
              : Container(),
        ));
  }
}

extension DynamicButtonStyleByTheme on ThemeData {
  Color getForegroundColorColorByDynamicButtonStyle(DynamicButtonStyle style) =>
      switch (style) {
        DynamicButtonStyle.text => colorScheme.surface,
        DynamicButtonStyle.primary => colorScheme.onPrimary,
        DynamicButtonStyle.primaryContainer => colorScheme.onPrimaryContainer,
        DynamicButtonStyle.secondary => colorScheme.onSecondary,
        DynamicButtonStyle.secondaryContainer =>
          colorScheme.onSecondaryContainer,
        DynamicButtonStyle.tertiary => colorScheme.onTertiary,
        DynamicButtonStyle.tertiaryContainer => colorScheme.onTertiaryContainer,
        DynamicButtonStyle.error => colorScheme.onError,
        DynamicButtonStyle.errorContainer => colorScheme.onErrorContainer,
        DynamicButtonStyle.outline => hintColor,
      };

  Color getBackgroundColorByDynamicButtonStyle(DynamicButtonStyle style) =>
      switch (style) {
        DynamicButtonStyle.text => colorScheme.onSurface,
        DynamicButtonStyle.primary => colorScheme.primary,
        DynamicButtonStyle.primaryContainer => colorScheme.primaryContainer,
        DynamicButtonStyle.secondary => colorScheme.secondary,
        DynamicButtonStyle.secondaryContainer => colorScheme.secondaryContainer,
        DynamicButtonStyle.tertiary => colorScheme.tertiary,
        DynamicButtonStyle.tertiaryContainer => colorScheme.tertiaryContainer,
        DynamicButtonStyle.error => colorScheme.error,
        DynamicButtonStyle.errorContainer => colorScheme.errorContainer,
        DynamicButtonStyle.outline => hintColor,
      };

  Color getBorderColorByDynamicButtonStyle(DynamicButtonStyle style) =>
      switch (style) {
        DynamicButtonStyle.text => colorScheme.onSurface,
        DynamicButtonStyle.primary => colorScheme.primary,
        DynamicButtonStyle.primaryContainer => colorScheme.primaryContainer,
        DynamicButtonStyle.secondary => colorScheme.secondary,
        DynamicButtonStyle.secondaryContainer => colorScheme.secondaryContainer,
        DynamicButtonStyle.tertiary => colorScheme.tertiary,
        DynamicButtonStyle.tertiaryContainer => colorScheme.tertiaryContainer,
        DynamicButtonStyle.error => colorScheme.error,
        DynamicButtonStyle.errorContainer => colorScheme.errorContainer,
        DynamicButtonStyle.outline => hintColor,
      };

  ButtonStyle getDynamicOutlinedButtonStyle(DynamicButtonStyle style) =>
      switch (style) {
        DynamicButtonStyle.text => OutlinedButton.styleFrom(
            foregroundColor: colorScheme.onSurface,
            side: BorderSide(color: colorScheme.onSurface)),
        DynamicButtonStyle.primary => OutlinedButton.styleFrom(
            foregroundColor: colorScheme.primary,
            side: BorderSide(color: colorScheme.primary)),
        DynamicButtonStyle.primaryContainer => OutlinedButton.styleFrom(
            foregroundColor: colorScheme.primaryContainer,
            side: BorderSide(color: colorScheme.primaryContainer)),
        DynamicButtonStyle.secondary => OutlinedButton.styleFrom(
            foregroundColor: colorScheme.secondary,
            side: BorderSide(color: colorScheme.secondary)),
        DynamicButtonStyle.secondaryContainer => OutlinedButton.styleFrom(
            foregroundColor: colorScheme.secondaryContainer,
            side: BorderSide(color: colorScheme.secondaryContainer)),
        DynamicButtonStyle.tertiary => OutlinedButton.styleFrom(
            foregroundColor: colorScheme.tertiary,
            side: BorderSide(color: colorScheme.tertiary)),
        DynamicButtonStyle.tertiaryContainer => OutlinedButton.styleFrom(
            foregroundColor: colorScheme.tertiaryContainer,
            side: BorderSide(color: colorScheme.tertiaryContainer)),
        DynamicButtonStyle.error => OutlinedButton.styleFrom(
            foregroundColor: colorScheme.error,
            side: BorderSide(color: colorScheme.error)),
        DynamicButtonStyle.errorContainer => OutlinedButton.styleFrom(
            foregroundColor: colorScheme.errorContainer,
            side: BorderSide(color: colorScheme.errorContainer)),
        DynamicButtonStyle.outline => OutlinedButton.styleFrom(
            foregroundColor: colorScheme.outline,
            side: BorderSide(color: colorScheme.outline)),
      };

  ButtonStyle getDynamicElevatedButtonStyle(DynamicButtonStyle style) =>
      switch (style) {
        DynamicButtonStyle.text => ElevatedButton.styleFrom(
            foregroundColor: colorScheme.surface,
            backgroundColor: colorScheme.onSurface),
        DynamicButtonStyle.primary => ElevatedButton.styleFrom(
            foregroundColor: colorScheme.onPrimary,
            backgroundColor: colorScheme.primary),
        DynamicButtonStyle.primaryContainer => ElevatedButton.styleFrom(
            foregroundColor: colorScheme.onPrimaryContainer,
            backgroundColor: colorScheme.primaryContainer),
        DynamicButtonStyle.secondary => ElevatedButton.styleFrom(
            foregroundColor: colorScheme.onSecondary,
            backgroundColor: colorScheme.secondary),
        DynamicButtonStyle.secondaryContainer => ElevatedButton.styleFrom(
            foregroundColor: colorScheme.onSecondaryContainer,
            backgroundColor: colorScheme.secondaryContainer),
        DynamicButtonStyle.tertiary => ElevatedButton.styleFrom(
            foregroundColor: colorScheme.onTertiary,
            backgroundColor: colorScheme.tertiary),
        DynamicButtonStyle.tertiaryContainer => ElevatedButton.styleFrom(
            foregroundColor: colorScheme.onTertiaryContainer,
            backgroundColor: colorScheme.tertiaryContainer),
        DynamicButtonStyle.error => ElevatedButton.styleFrom(
            foregroundColor: colorScheme.onError,
            backgroundColor: colorScheme.error),
        DynamicButtonStyle.errorContainer => ElevatedButton.styleFrom(
            foregroundColor: colorScheme.onErrorContainer,
            backgroundColor: colorScheme.errorContainer),
        DynamicButtonStyle.outline => ElevatedButton.styleFrom(
            foregroundColor: hintColor,
            backgroundColor: colorScheme.outline),
      };
}
