import 'dart:ui';

class DynamicLayoutScaleUtil {
  static DynamicLayoutScaleValue getCenterInside(
      {required Size layout, required Size content}) {
    double layoutRatio = layout.width / layout.height;
    double contentRatio = content.width / content.height;

    if (layoutRatio > contentRatio) {
      double scale = layout.height / content.height;
      double width = content.width * scale;
      double height = layout.height;
      return DynamicLayoutScaleValue(
          size: Size(width, height),
          scale: scale,
          offset: Offset((layout.width - width) / 2, 0));
    } else {
      double scale = layout.width / content.width;
      double width = layout.width;
      double height = content.height * scale;
      return DynamicLayoutScaleValue(
          size: Size(width, height),
          scale: scale,
          offset: Offset(0, (layout.height - height) / 2));
    }
  }
}

class DynamicLayoutScaleValue {
  final Size size;
  final double scale;
  final Offset offset;

  const DynamicLayoutScaleValue(
      {required this.size, required this.scale, required this.offset});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DynamicLayoutScaleValue &&
          runtimeType == other.runtimeType &&
          size == other.size &&
          scale == other.scale &&
          offset == other.offset;

  @override
  int get hashCode => size.hashCode ^ scale.hashCode ^ offset.hashCode;

  @override
  String toString() {
    return 'DynamicLayoutScaleValue{size: $size, scale: $scale, offset: $offset}';
  }
}
