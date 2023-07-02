import 'package:flutter/material.dart';

enum DynamicDevice {
  mobile,
  tablet,
  desktop,
}

class DynamicLayoutData {
  final Size layoutSize;
  final DynamicDevice device;
  final double layoutWidth;
  final double layoutPadding;
  final double contentPadding;
  final bool shownKeyboard;

  double get padding => layoutPadding + contentPadding;

  DynamicLayoutData({
    required this.layoutSize,
    required this.device,
    required this.layoutWidth,
    required this.layoutPadding,
    required this.contentPadding,
    required this.shownKeyboard,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DynamicLayoutData &&
          runtimeType == other.runtimeType &&
          layoutSize == other.layoutSize &&
          device == other.device &&
          layoutWidth == other.layoutWidth &&
          layoutPadding == other.layoutPadding &&
          contentPadding == other.contentPadding &&
          shownKeyboard == other.shownKeyboard;

  @override
  int get hashCode =>
      layoutSize.hashCode ^
      device.hashCode ^
      layoutWidth.hashCode ^
      layoutPadding.hashCode ^
      contentPadding.hashCode ^
      shownKeyboard.hashCode;

  @override
  String toString() {
    return 'DynamicLayoutData{layoutSize: $layoutSize, device: $device, layoutWidth: $layoutWidth, layoutPadding: $layoutPadding, contentPadding: $contentPadding, shownKeyboard: $shownKeyboard}';
  }
}

class DynamicLayoutStyle extends ThemeExtension<DynamicLayoutStyle> {
  static const double defaultMobileMaxWidth = 600;
  static const double defaultTabletMaxWidth = 840;

  const DynamicLayoutStyle({
    this.mobileMaxWidth = defaultMobileMaxWidth,
    this.tabletMaxWidth = defaultTabletMaxWidth,
    this.mobileConstraintWidth = double.infinity,
    this.tabletConstraintWidth = double.infinity,
    this.desktopConstraintWidth = double.infinity,
    double minPadding = 0,
    double maxPadding = 0,
    double? mobileMinPadding,
    double? mobileMaxPadding,
    double? tabletMinPadding,
    double? tabletMaxPadding,
    double? desktopMinPadding,
    double? desktopMaxPadding,
  })  : mobileMinPadding = mobileMinPadding ?? minPadding,
        mobileMaxPadding = mobileMaxPadding ?? maxPadding,
        tabletMinPadding = tabletMinPadding ?? minPadding,
        tabletMaxPadding = tabletMaxPadding ?? maxPadding,
        desktopMinPadding = desktopMinPadding ?? minPadding,
        desktopMaxPadding = desktopMaxPadding ?? maxPadding;

  final double mobileMaxWidth;
  final double tabletMaxWidth;

  final double mobileConstraintWidth;
  final double tabletConstraintWidth;
  final double desktopConstraintWidth;

  final double mobileMinPadding;
  final double mobileMaxPadding;
  final double tabletMinPadding;
  final double tabletMaxPadding;
  final double desktopMinPadding;
  final double desktopMaxPadding;

  @override
  ThemeExtension<DynamicLayoutStyle> copyWith({
    double? mobileMaxWidth,
    double? tabletMaxWidth,
    double? mobileConstraintWidth,
    double? tabletConstraintWidth,
    double? desktopConstraintWidth,
    double? mobileMinPadding,
    double? mobileMaxPadding,
    double? tabletMinPadding,
    double? tabletMaxPadding,
    double? desktopMinPadding,
    double? desktopMaxPadding,
  }) =>
      DynamicLayoutStyle(
        mobileMaxWidth: mobileMaxWidth ?? this.mobileMaxWidth,
        tabletMaxWidth: tabletMaxWidth ?? this.tabletMaxWidth,
        mobileConstraintWidth:
            mobileConstraintWidth ?? this.mobileConstraintWidth,
        tabletConstraintWidth:
            tabletConstraintWidth ?? this.tabletConstraintWidth,
        desktopConstraintWidth:
            desktopConstraintWidth ?? this.desktopConstraintWidth,
        mobileMinPadding: mobileMinPadding ?? this.mobileMinPadding,
        mobileMaxPadding: mobileMaxPadding ?? this.mobileMaxPadding,
        tabletMinPadding: tabletMinPadding ?? this.tabletMinPadding,
        tabletMaxPadding: tabletMaxPadding ?? this.tabletMaxPadding,
        desktopMinPadding: desktopMinPadding ?? this.desktopMinPadding,
        desktopMaxPadding: desktopMaxPadding ?? this.desktopMaxPadding,
      );

  @override
  ThemeExtension<DynamicLayoutStyle> lerp(
      covariant ThemeExtension<DynamicLayoutStyle>? other, double t) {
    return this;
  }

  DynamicLayoutData getDynamicLayoutData({
    required Size layout,
    bool shownKeyboard = false,
  }) {
    switch (getDevice(layout.width, mobileMaxWidth, tabletMaxWidth)) {
      case DynamicDevice.mobile:
        final (minPadding, maxPadding) = _getMinMaxPadding(
          mobileMinPadding,
          mobileMaxPadding,
        );
        final (layoutWidth, layoutPadding, contentPadding) = _getConstraint(
            layout.width, mobileConstraintWidth, minPadding, maxPadding);
        double padding = layoutPadding + contentPadding;
        if (padding > maxPadding) {
          padding = maxPadding;
        }

        return DynamicLayoutData(
          layoutSize: layout,
          device: DynamicDevice.mobile,
          layoutWidth: layoutWidth,
          layoutPadding: 0,
          contentPadding: padding,
          shownKeyboard: shownKeyboard,
        );
      case DynamicDevice.tablet:
        final (minPadding, maxPadding) = _getMinMaxPadding(
          tabletMinPadding,
          tabletMaxPadding,
        );
        final (layoutWidth, layoutPadding, contentPadding) = _getConstraint(
            layout.width, tabletConstraintWidth, minPadding, maxPadding);

        return DynamicLayoutData(
          layoutSize: layout,
          device: DynamicDevice.tablet,
          layoutWidth: layoutWidth,
          layoutPadding: layoutPadding,
          contentPadding: contentPadding,
          shownKeyboard: shownKeyboard,
        );
      case DynamicDevice.desktop:
        final (minPadding, maxPadding) =
            _getMinMaxPadding(desktopMinPadding, desktopMaxPadding);
        final (layoutWidth, layoutPadding, contentPadding) = _getConstraint(
            layout.width, desktopConstraintWidth, minPadding, maxPadding);

        return DynamicLayoutData(
          layoutSize: layout,
          device: DynamicDevice.desktop,
          layoutWidth: layoutWidth,
          layoutPadding: layoutPadding,
          contentPadding: contentPadding,
          shownKeyboard: shownKeyboard,
        );
    }
  }

  static DynamicDevice getDevice(
      double width, double maxMobile, double maxTablet) {
    if (width < maxMobile) {
      return DynamicDevice.mobile;
    } else if (width < maxTablet) {
      return DynamicDevice.tablet;
    } else {
      return DynamicDevice.desktop;
    }
  }

  /// minPadding, maxPadding
  static (double, double) _getMinMaxPadding(
      double minPadding, double maxPadding) {
    final min = minPadding > 0 ? minPadding : 0.0;
    final max = maxPadding > min ? maxPadding : min;
    return (min, max);
  }

  /// layout width, layout padding, content padding,
  static (double, double, double) _getConstraint(double width,
      double constraintWidth, double minPadding, double maxPadding) {
    if (width < constraintWidth) {
      return (width, 0, minPadding);
    } else {
      final hPadding = (width - constraintWidth) / 2;
      if (hPadding > maxPadding) {
        return (constraintWidth, hPadding - maxPadding, maxPadding);
      } else if (hPadding > minPadding) {
        return (constraintWidth, hPadding - minPadding, minPadding);
      } else {
        return (constraintWidth, 0, minPadding);
      }
    }
  }
}

typedef DynamicLayoutWidgetBuilder = Widget Function(
    BuildContext context, DynamicLayoutData dynamicLayout);

class DynamicLayout extends StatelessWidget {
  static DynamicLayoutData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<_DynamicLayout>();
    if (widget != null) {
      return widget.data;
    }

    return byMediaQuery(context);
  }

  static DynamicLayoutData byMediaQuery(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final style = Theme.of(context).extension<DynamicLayoutStyle>() ??
        const DynamicLayoutStyle();
    return style.getDynamicLayoutData(
        layout: mediaQuery.size,
        shownKeyboard: mediaQuery.viewInsets.bottom > 0);
  }

  final double? mobileMaxWidth;
  final double? tabletMaxWidth;

  final double? mobileConstraintWidth;
  final double? tabletConstraintWidth;
  final double? desktopConstraintWidth;

  final double? minPadding;
  final double? maxPadding;
  final double? mobileMinPadding;
  final double? mobileMaxPadding;
  final double? tabletMinPadding;
  final double? tabletMaxPadding;
  final double? desktopMinPadding;
  final double? desktopMaxPadding;
  final DynamicLayoutWidgetBuilder builder;

  const DynamicLayout({
    super.key,
    this.mobileMaxWidth,
    this.tabletMaxWidth,
    this.mobileConstraintWidth,
    this.tabletConstraintWidth,
    this.desktopConstraintWidth,
    this.minPadding,
    this.maxPadding,
    this.mobileMinPadding,
    this.mobileMaxPadding,
    this.tabletMinPadding,
    this.tabletMaxPadding,
    this.desktopMinPadding,
    this.desktopMaxPadding,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final shownKeyboard = MediaQuery.of(context).viewInsets.bottom > 0;
    final style = (Theme.of(context).extension<DynamicLayoutStyle>() ??
            const DynamicLayoutStyle())
        .copyWith(
      mobileMaxWidth: mobileMaxWidth,
      tabletMaxWidth: tabletMaxWidth,
      mobileConstraintWidth: mobileConstraintWidth,
      tabletConstraintWidth: tabletConstraintWidth,
      desktopConstraintWidth: desktopConstraintWidth,
      mobileMinPadding: mobileMinPadding ?? minPadding,
      mobileMaxPadding: mobileMaxPadding ?? maxPadding,
      tabletMinPadding: tabletMinPadding ?? minPadding,
      tabletMaxPadding: tabletMaxPadding ?? maxPadding,
      desktopMinPadding: desktopMinPadding ?? minPadding,
      desktopMaxPadding: desktopMaxPadding ?? maxPadding,
    );

    return LayoutBuilder(builder: (context, constraints) {
      return _DynamicLayout(
        data: (style as DynamicLayoutStyle).getDynamicLayoutData(
            layout: Size(constraints.maxWidth, constraints.maxHeight),
            shownKeyboard: shownKeyboard),
        child: Builder(builder: (context) {
          return builder(context, DynamicLayout.of(context));
        }),
      );
    });
  }
}

class _DynamicLayout extends InheritedWidget {
  final DynamicLayoutData data;

  const _DynamicLayout({required this.data, required super.child});

  @override
  bool updateShouldNotify(covariant _DynamicLayout oldWidget) {
    return data != oldWidget.data;
  }
}

class DynamicLayoutPreferredSizeWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final DynamicLayoutData dynamicLayout;
  final bool useContentPadding;
  final PreferredSizeWidget child;

  const DynamicLayoutPreferredSizeWidget({
    super.key,
    required this.dynamicLayout,
    this.useContentPadding = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: useContentPadding
              ? dynamicLayout.padding
              : dynamicLayout.layoutPadding),
      child: child,
    );
  }

  @override
  Size get preferredSize => child.preferredSize;
}
