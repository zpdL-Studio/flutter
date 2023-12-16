import 'package:flutter/material.dart';

// extension DynamicTextTextStyleByColor on Color {
//   TextStyle w100(
//     double fontSize, {
//     FontStyle? fontStyle,
//     TextDecoration? decoration,
//     Color? decorationColor,
//     TextDecorationStyle? decorationStyle,
//     double? decorationThickness,
//   }) {
//     return TextStyle(
//       fontSize: fontSize,
//       fontStyle: fontStyle,
//       fontWeight: FontWeight.w100,
//       color: this,
//       decoration: decoration,
//       decorationColor: decorationColor,
//       decorationStyle: decorationStyle,
//       decorationThickness: decorationThickness,
//     );
//   }
//
//   TextStyle w200(
//     double fontSize, {
//     FontStyle? fontStyle,
//     TextDecoration? decoration,
//     Color? decorationColor,
//     TextDecorationStyle? decorationStyle,
//     double? decorationThickness,
//   }) {
//     return TextStyle(
//       fontSize: fontSize,
//       fontStyle: fontStyle,
//       fontWeight: FontWeight.w200,
//       color: this,
//       decoration: decoration,
//       decorationColor: decorationColor,
//       decorationStyle: decorationStyle,
//       decorationThickness: decorationThickness,
//     );
//   }
//
//   TextStyle w300(
//     double fontSize, {
//     FontStyle? fontStyle,
//     TextDecoration? decoration,
//     Color? decorationColor,
//     TextDecorationStyle? decorationStyle,
//     double? decorationThickness,
//   }) {
//     return TextStyle(
//       fontSize: fontSize,
//       fontStyle: fontStyle,
//       fontWeight: FontWeight.w300,
//       color: this,
//       decoration: decoration,
//       decorationColor: decorationColor,
//       decorationStyle: decorationStyle,
//       decorationThickness: decorationThickness,
//     );
//   }
//
//   TextStyle w400(
//     double fontSize, {
//     FontStyle? fontStyle,
//     TextDecoration? decoration,
//     Color? decorationColor,
//     TextDecorationStyle? decorationStyle,
//     double? decorationThickness,
//   }) {
//     return TextStyle(
//       fontSize: fontSize,
//       fontStyle: fontStyle,
//       fontWeight: FontWeight.w400,
//       color: this,
//       decoration: decoration,
//       decorationColor: decorationColor,
//       decorationStyle: decorationStyle,
//       decorationThickness: decorationThickness,
//     );
//   }
//
//   TextStyle w500(
//     double fontSize, {
//     FontStyle? fontStyle,
//     TextDecoration? decoration,
//     Color? decorationColor,
//     TextDecorationStyle? decorationStyle,
//     double? decorationThickness,
//   }) {
//     return TextStyle(
//       fontSize: fontSize,
//       fontStyle: fontStyle,
//       fontWeight: FontWeight.w500,
//       color: this,
//       decoration: decoration,
//       decorationColor: decorationColor,
//       decorationStyle: decorationStyle,
//       decorationThickness: decorationThickness,
//     );
//   }
//
//   TextStyle w600(
//     double fontSize, {
//     FontStyle? fontStyle,
//     TextDecoration? decoration,
//     Color? decorationColor,
//     TextDecorationStyle? decorationStyle,
//     double? decorationThickness,
//   }) {
//     return TextStyle(
//       fontSize: fontSize,
//       fontStyle: fontStyle,
//       fontWeight: FontWeight.w600,
//       color: this,
//       decoration: decoration,
//       decorationColor: decorationColor,
//       decorationStyle: decorationStyle,
//       decorationThickness: decorationThickness,
//     );
//   }
//
//   TextStyle w700(
//     double fontSize, {
//     FontStyle? fontStyle,
//     TextDecoration? decoration,
//     Color? decorationColor,
//     TextDecorationStyle? decorationStyle,
//     double? decorationThickness,
//   }) {
//     return TextStyle(
//       fontSize: fontSize,
//       fontStyle: fontStyle,
//       fontWeight: FontWeight.w700,
//       color: this,
//       decoration: decoration,
//       decorationColor: decorationColor,
//       decorationStyle: decorationStyle,
//       decorationThickness: decorationThickness,
//     );
//   }
//
//   TextStyle w800(
//     double fontSize, {
//     FontStyle? fontStyle,
//     TextDecoration? decoration,
//     Color? decorationColor,
//     TextDecorationStyle? decorationStyle,
//     double? decorationThickness,
//   }) {
//     return TextStyle(
//       fontSize: fontSize,
//       fontStyle: fontStyle,
//       fontWeight: FontWeight.w800,
//       color: this,
//       decoration: decoration,
//       decorationColor: decorationColor,
//       decorationStyle: decorationStyle,
//       decorationThickness: decorationThickness,
//     );
//   }
//
//   TextStyle w900(
//     double fontSize, {
//     FontStyle? fontStyle,
//     TextDecoration? decoration,
//     Color? decorationColor,
//     TextDecorationStyle? decorationStyle,
//     double? decorationThickness,
//   }) {
//     return TextStyle(
//       fontSize: fontSize,
//       fontStyle: fontStyle,
//       fontWeight: FontWeight.w900,
//       color: this,
//       decoration: decoration,
//       decorationColor: decorationColor,
//       decorationStyle: decorationStyle,
//       decorationThickness: decorationThickness,
//     );
//   }
//
//   TextStyle normal(
//     double fontSize, {
//     FontStyle? fontStyle,
//     TextDecoration? decoration,
//     Color? decorationColor,
//     TextDecorationStyle? decorationStyle,
//     double? decorationThickness,
//   }) {
//     return w400(
//       fontSize,
//       fontStyle: fontStyle,
//       decoration: decoration,
//       decorationColor: decorationColor,
//       decorationStyle: decorationStyle,
//       decorationThickness: decorationThickness,
//     );
//   }
//
//   TextStyle semiBold(
//     double fontSize, {
//     FontStyle? fontStyle,
//     TextDecoration? decoration,
//     Color? decorationColor,
//     TextDecorationStyle? decorationStyle,
//     double? decorationThickness,
//   }) {
//     return w600(
//       fontSize,
//       fontStyle: fontStyle,
//       decoration: decoration,
//       decorationColor: decorationColor,
//       decorationStyle: decorationStyle,
//       decorationThickness: decorationThickness,
//     );
//   }
//
//   TextStyle bold(
//     double fontSize, {
//     FontStyle? fontStyle,
//     TextDecoration? decoration,
//     Color? decorationColor,
//     TextDecorationStyle? decorationStyle,
//     double? decorationThickness,
//   }) {
//     return w700(
//       fontSize,
//       fontStyle: fontStyle,
//       decoration: decoration,
//       decorationColor: decorationColor,
//       decorationStyle: decorationStyle,
//       decorationThickness: decorationThickness,
//     );
//   }
// }

extension DynamicTextTextStyleByTheme on ThemeData {
  Color get textColor => colorScheme.onSurface;

  Color get primaryTextColor => colorScheme.onPrimary;

  Color get secondTextColor => colorScheme.onSecondary;

  Color get tertiaryTextColor => colorScheme.onTertiary;

  Color get errorTextColor => colorScheme.onError;

  Color get outlineColor => colorScheme.outline;

  TextStyle get defaultTextStyle => textTheme.bodyMedium ?? const TextStyle();

  TextStyle w100(
    double fontSize, {
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) {
    return defaultTextStyle.copyWith(
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: FontWeight.w100,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }

  TextStyle wThin(
    double fontSize, {
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) =>
      w100(
        fontSize,
        color: color,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  TextStyle w200(
    double fontSize, {
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) {
    return defaultTextStyle.copyWith(
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: FontWeight.w200,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }

  TextStyle wExtraLight(
    double fontSize, {
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) =>
      w200(
        fontSize,
        color: color,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  TextStyle w300(
    double fontSize, {
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) {
    return defaultTextStyle.copyWith(
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: FontWeight.w300,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }

  TextStyle wLight(
    double fontSize, {
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) =>
      w300(
        fontSize,
        color: color,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  TextStyle w400(
    double fontSize, {
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) {
    return defaultTextStyle.copyWith(
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: FontWeight.w400,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }

  TextStyle wRegular(
    double fontSize, {
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) =>
      w400(
        fontSize,
        color: color,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  TextStyle w500(
    double fontSize, {
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) {
    return defaultTextStyle.copyWith(
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: FontWeight.w500,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }

  TextStyle wMedium(
    double fontSize, {
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) =>
      w500(
        fontSize,
        color: color,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  TextStyle w600(
    double fontSize, {
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) {
    return defaultTextStyle.copyWith(
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: FontWeight.w600,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }

  TextStyle wSemiBold(
    double fontSize, {
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) =>
      w600(
        fontSize,
        color: color,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  TextStyle w700(
    double fontSize, {
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) {
    return defaultTextStyle.copyWith(
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: FontWeight.w700,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }

  TextStyle wBold(
    double fontSize, {
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) =>
      w700(
        fontSize,
        color: color,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  TextStyle w800(
    double fontSize, {
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) {
    return defaultTextStyle.copyWith(
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: FontWeight.w800,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }

  TextStyle wExtraBold(
    double fontSize, {
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) =>
      w800(
        fontSize,
        color: color,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  TextStyle w900(
    double fontSize, {
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) {
    return defaultTextStyle.copyWith(
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: FontWeight.w900,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }

  TextStyle wBlack(
    double fontSize, {
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) =>
      w900(
        fontSize,
        color: color,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );
}
