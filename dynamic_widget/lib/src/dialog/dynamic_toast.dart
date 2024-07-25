import 'dart:async';

import 'package:flutter/material.dart';

class DynamicToastStyle extends ThemeExtension<DynamicToastStyle> {
  const DynamicToastStyle({
    this.duration = const Duration(seconds: 3),
    this.useSafeArea = true,
    this.alignment = Alignment.center,
    this.animationType = DynamicToastAnimationType.opacity,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeOutBack,
    this.margin = const EdgeInsets.all(16),
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    this.elevation = 0,
    this.shape = const RoundedRectangleBorder(),
    this.titleTextStyle,
    this.messageTextStyle,
    this.titleMessageSpace,
    this.backgroundColor,
  });

  final Duration duration;

  final bool useSafeArea;

  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final ShapeBorder shape;

  final DynamicToastAnimationType animationType;
  final Duration animationDuration;
  final Curve animationCurve;

  final TextStyle? titleTextStyle;
  final TextStyle? messageTextStyle;
  final double? titleMessageSpace;
  final Color? backgroundColor;


  @override
  ThemeExtension<DynamicToastStyle> copyWith({
    Duration? duration,
    bool? useSafeArea,
    AlignmentGeometry? alignment,
    DynamicToastAnimationType? animationType,
    Duration? animationDuration,
    Curve? animationCurve,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? elevation,
    ShapeBorder? shape,
    TextStyle? titleTextStyle,
    TextStyle? messageTextStyle,
    double? titleMessageSpace,
    Color? backgroundColor,
    bool? containerUseBlur,
  }) =>
      DynamicToastStyle(
        duration: duration ?? this.duration,
        useSafeArea: useSafeArea ?? this.useSafeArea,
        alignment: alignment ?? this.alignment,
        animationType: animationType ?? this.animationType,
        animationDuration: animationDuration ?? this.animationDuration,
        animationCurve: animationCurve ?? this.animationCurve,
        margin: margin ?? this.margin,
        padding: padding ?? this.padding,
        elevation: elevation ?? this.elevation,
        shape: shape ?? this.shape,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        messageTextStyle: messageTextStyle ?? this.messageTextStyle,
        titleMessageSpace: titleMessageSpace ?? this.titleMessageSpace,
        backgroundColor: backgroundColor ?? this.backgroundColor,
      );

  @override
  ThemeExtension<DynamicToastStyle> lerp(
      covariant ThemeExtension<DynamicToastStyle>? other, double t) {
    if (other is! DynamicToastStyle) {
      return this;
    }

    return t < 0 ? this : other;
  }
}

enum DynamicToastAnimationType {
  opacity,
  leftToRight,
  rightToLeft,
  topToBottom,
  bottomToTop
}

class DynamicToast {
  final DynamicToastStyle? style;
  OverlayEntry? _overlayEntry;

  DynamicToast({
    this.style,
  });

  Future<void> show(BuildContext context, WidgetBuilder builder) {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
    }

    final c = Completer();
    _overlayEntry =
        OverlayEntry(builder: (context) => _buildToast(context, builder));

    Overlay.of(context).insert(_overlayEntry!);
    return c.future;
  }

  Widget _buildToast(BuildContext context, WidgetBuilder builder) {
    final style = this.style ??
        Theme.of(context).extension<DynamicToastStyle>() ??
        const DynamicToastStyle();
    var margin = style.margin;
    if (style.useSafeArea) {
      final data = MediaQuery.of(context);
      margin = margin.add(data.padding);
    }

    final child = _ToastOverlayWidget(
      onDispose: () {
        _overlayEntry?.remove();
        _overlayEntry = null;
      },
      duration: style.duration,
      animationType: style.animationType,
      animationDuration: style.animationDuration,
      animationCurve: style.animationCurve,
      child: builder(context),
    );

    return Align(
        alignment: style.alignment,
        child: Padding(padding: margin, child: child));
  }

  static void showToast({required BuildContext context,
    DynamicToastStyle? style,
    required WidgetBuilder builder}) {
    DynamicToast(
      style: style,
    ).show(context, builder);
  }

  static void showToastText({
    required BuildContext context,
    DynamicToastStyle? style,
    WidgetBuilder? titleWidget,
    String? titleText,
    TextStyle? titleTextStyle,
    WidgetBuilder? messageWidget,
    TextStyle? messageTextStyle,
    String? messageText,
    double? titleMessageSpace,
  }) {
    return showToast(
        context: context,
        style: style,
        builder: (context) {
          final theme = Theme.of(context);
          final toastStyle = theme.extension<DynamicToastStyle>();
          final titleStyle = titleTextStyle ??
              style?.titleTextStyle ??
              toastStyle?.titleTextStyle ??
              Theme.of(context).textTheme.titleMedium ??
              const TextStyle();

          Widget? title;
          if (titleWidget != null) {
            title = DefaultTextStyle(
                style: titleStyle, child: titleWidget(context));
          } else if (titleText != null) {
            title = Text(
              titleText,
              style: titleStyle,
            );
          }

          final messageStyle = messageTextStyle ??
              style?.messageTextStyle ??
              toastStyle?.messageTextStyle ??
              Theme.of(context).textTheme.bodyMedium ??
              const TextStyle();

          Widget? message;
          if (messageWidget != null) {
            message = DefaultTextStyle(
                style: messageStyle, child: messageWidget(context));
          } else if (messageText != null) {
            message = Text(
              messageText,
              style: messageStyle,
            );
          }

          double space = titleMessageSpace ??
              style?.titleMessageSpace ??
              toastStyle?.titleMessageSpace ??
              4;

          return ToastContainer(
            style: style,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null) title,
                if (title != null && message != null)
                  SizedBox(
                    width: double.infinity,
                    height: space,
                  ),
                if (message != null) message,
              ],
            ),
          );
        });
  }
}

class _ToastOverlayWidget extends StatefulWidget {
  final VoidCallback onDispose;

  final Duration duration;

  final DynamicToastAnimationType animationType;
  final Duration animationDuration;
  final Curve animationCurve;

  final Widget child;

  const _ToastOverlayWidget({
    required this.onDispose,
    required this.duration,
    required this.animationType,
    required this.animationDuration,
    required this.animationCurve,
    required this.child,
  });

  @override
  _ToastOverlayState createState() => _ToastOverlayState();
}

class _ToastOverlayState extends State<_ToastOverlayWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  bool finishStatus = false;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: widget.animationDuration, vsync: this);
    _animation =
        CurvedAnimation(parent: _controller, curve: widget.animationCurve)
          ..addListener(_animationUpdate);

    _controller.forward();

    Future.delayed(widget.duration).then((value) {
      if (mounted && !finishStatus) {
        finishStatus = true;
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animation.removeListener(_animationUpdate);
    _controller.dispose();
    widget.onDispose();

    super.dispose();
  }

  void _animationUpdate() {
    if (!mounted) {
      return;
    }

    if (finishStatus && !_controller.isAnimating) {
      widget.onDispose();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (mounted && !finishStatus) {
          finishStatus = true;
          _controller.reverse();
        }
      },
      child: _build(context),
    );
  }

  Widget _build(BuildContext context) {
    switch (widget.animationType) {
      case DynamicToastAnimationType.opacity:
        final value = _animation.value < 0
            ? 0.0
            : _animation.value > 1.0
            ? 1.0
            : _animation.value;
        return Opacity(
          opacity: value,
          child: widget.child,
        );
      case DynamicToastAnimationType.leftToRight:
        final value = _animation.value - 1;
        return FractionalTranslation(
          translation: Offset(value, 0.0),
          child: widget.child,
        );
      case DynamicToastAnimationType.rightToLeft:
        final value = 1 - _animation.value;
        return FractionalTranslation(
          translation: Offset(value, 0.0),
          child: widget.child,
        );
      case DynamicToastAnimationType.topToBottom:
        final value = _animation.value - 1;
        return FractionalTranslation(
          translation: Offset(0.0, value),
          child: widget.child,
        );

      case DynamicToastAnimationType.bottomToTop:
        final value = 1 - _animation.value;
        return FractionalTranslation(
          translation: Offset(0.0, value),
          child: widget.child,
        );
    }
  }
}

class ToastContainer extends StatelessWidget {
  final DynamicToastStyle? style;
  final Widget child;

  const ToastContainer({
    super.key,
    this.style,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = this.style ?? theme.extension<DynamicToastStyle>() ??
        const DynamicToastStyle();
    return Material(
        elevation: style.elevation,
        shape: style.shape,
        color: style.backgroundColor,
        clipBehavior: Clip.hardEdge,
        child: Container(
          width: double.infinity,
          padding: style.padding,
          child: child,
        ));
  }
}
