import 'package:flutter/material.dart';

class ReadOnlyTextField extends StatelessWidget {
  final InputDecoration? decoration;
  final String? text;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final Widget? child;

  const ReadOnlyTextField({
    super.key,
    this.decoration,
    this.text,
    this.textStyle,
    this.onPressed,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final text = this.text;
    final textStyle = this.textStyle ??
        theme.textTheme.bodyLarge ??
        const TextStyle();
    final child = this.child ??
        (text != null
            ? Text(
                text,
                style: textStyle,
              )
            : null);
    final inputDecoration = (decoration ?? const InputDecoration())
        .applyDefaults(theme.inputDecorationTheme);

    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: inputDecoration,
        isEmpty: child == null,
        child: child != null
            ? DefaultTextStyle(style: textStyle, child: child)
            : null,
      ),
    );
  }
}
