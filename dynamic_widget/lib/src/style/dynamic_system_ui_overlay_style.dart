import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DynamicSystemUiOverlayStyle {
  static SystemUiOverlayStyle get dark {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
    }
    return SystemUiOverlayStyle.dark;
  }

  static SystemUiOverlayStyle get light {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
    }
    return SystemUiOverlayStyle.light;
  }
}
