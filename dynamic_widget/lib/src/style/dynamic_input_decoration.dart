import 'package:flutter/material.dart';

class DynamicInputDecoration extends InputDecoration {
  const DynamicInputDecoration.none({
    super.icon,
    super.iconColor,
    super.label,
    super.labelText,
    super.labelStyle,
    super.floatingLabelStyle,
    super.helperText,
    super.helperStyle,
    super.helperMaxLines,
    super.hintText,
    super.hintStyle,
    super.hintTextDirection,
    super.hintMaxLines,
    super.errorText,
    super.errorStyle,
    super.errorMaxLines,
    super.floatingLabelBehavior,
    super.floatingLabelAlignment,
    super.isCollapsed = false,
    super.isDense,
    super.contentPadding,
    super.prefixIcon,
    super.prefixIconConstraints,
    super.prefix,
    super.prefixText,
    super.prefixStyle,
    super.prefixIconColor,
    super.suffixIcon,
    super.suffix,
    super.suffixText,
    super.suffixStyle,
    super.suffixIconColor,
    super.suffixIconConstraints,
    super.counter,
    super.counterText,
    super.counterStyle,
    super.filled,
    super.fillColor,
    super.focusColor,
    super.hoverColor,
    super.enabled = true,
    super.semanticCounterText,
    super.alignLabelWithHint,
    super.constraints,
  }) : super(
          border: InputBorder.none,
          enabledBorder: null,
          focusedBorder: null,
          disabledBorder: null,
          errorBorder: null,
          focusedErrorBorder: null,
        );

  DynamicInputDecoration.outline({
    super.icon,
    super.iconColor,
    super.label,
    super.labelText,
    super.labelStyle,
    super.floatingLabelStyle,
    super.helperText,
    super.helperStyle,
    super.helperMaxLines,
    super.hintText,
    super.hintStyle,
    super.hintTextDirection,
    super.hintMaxLines,
    super.errorText,
    super.errorStyle,
    super.errorMaxLines,
    super.floatingLabelBehavior,
    super.floatingLabelAlignment,
    super.isCollapsed = false,
    super.isDense,
    super.contentPadding,
    super.prefixIcon,
    super.prefixIconConstraints,
    super.prefix,
    super.prefixText,
    super.prefixStyle,
    super.prefixIconColor,
    super.suffixIcon,
    super.suffix,
    super.suffixText,
    super.suffixStyle,
    super.suffixIconColor,
    super.suffixIconConstraints,
    super.counter,
    super.counterText,
    super.counterStyle,
    super.filled,
    super.fillColor,
    super.focusColor,
    super.hoverColor,
    super.enabled = true,
    super.semanticCounterText,
    super.alignLabelWithHint,
    super.constraints,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    Color? errorBorderColor,
    Color? focusedBorderColor,
    Color? focusedErrorBorderColor,
    Color? disabledBorderColor,
    Color? enabledBorderColor,
  }) : super(
          border: OutlineInputBorder(borderRadius: borderRadius),
          enabledBorder:
              colorToOutlineInputBorder(enabledBorderColor, borderRadius),
          focusedBorder:
              colorToOutlineInputBorder(focusedBorderColor, borderRadius),
          disabledBorder:
              colorToOutlineInputBorder(disabledBorderColor, borderRadius),
          errorBorder:
              colorToOutlineInputBorder(errorBorderColor, borderRadius),
          focusedErrorBorder:
              colorToOutlineInputBorder(focusedErrorBorderColor, borderRadius),
        );

  static OutlineInputBorder? colorToOutlineInputBorder(
          Color? color, BorderRadius borderRadius) =>
      color != null
          ? OutlineInputBorder(
              borderSide: BorderSide(color: color), borderRadius: borderRadius)
          : null;
}