import 'package:flutter/material.dart';

typedef DynamicAspectDpWidgetBuilder = Widget Function(
    BuildContext context, double dp);

class DynamicAspectDpWidget extends StatelessWidget {
  final double width;
  final double height;
  final DynamicAspectDpWidgetBuilder builder;

  const DynamicAspectDpWidget({
    super.key,
    required this.width,
    required this.height,
    required this.builder,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: width / height,
        child: LayoutBuilder(builder: (context, constraints) {
          return builder(
            context,
            constraints.maxWidth / width,
          );
        }));
  }
}
