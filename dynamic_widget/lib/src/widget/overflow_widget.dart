import 'package:flutter/material.dart';

class OverflowSizedWidget extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;

  const OverflowSizedWidget({
    super.key,
    required this.width,
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(Size(width, height)),
      child: CustomMultiChildLayout(
        delegate: _OverflowSizedWidgetDelegate(width: width, height: height),
        children: [LayoutId(id: _id, child: child)],
      ),
    );
  }
}

const _id = 'OverflowSizedWidget';

class _OverflowSizedWidgetDelegate extends MultiChildLayoutDelegate {
  final double width;
  final double height;

  _OverflowSizedWidgetDelegate({required this.width, required this.height});

  @override
  void performLayout(Size size) {
    final width = this.width == double.infinity ? size.width : this.width;
    final height = this.height == double.infinity ? size.height : this.height;

    if (hasChild(_id)) {
      final BoxConstraints constraints =
          BoxConstraints.loose(Size(width, height));
      layoutChild(_id, constraints);
      positionChild(_id, const Offset(0, 0));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => false;
}
