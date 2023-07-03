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
    final text = this.text;
    final child = this.child ??
        (text != null
            ? Text(
                text,
                style: textStyle,
              )
            : null);

    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: decoration ?? const InputDecoration(),
        isEmpty: child == null,
        child: child,
      ),
    );
  }
}
