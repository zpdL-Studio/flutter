import 'package:flutter/widgets.dart';

class DynamicGridWidget extends StatelessWidget {
  final double rowSpacing;
  final double columnSpacing;
  final int rowCount;
  final List<Widget> children;

  const DynamicGridWidget({
    super.key,
    required this.rowCount,
    this.rowSpacing = 0.0,
    this.columnSpacing = 0.0,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: listToGrid(
          rowCount: rowCount,
          rowSpacing: rowSpacing,
          columnSpacing: columnSpacing,
          children: children),
    );
  }

  static List<Widget> listToGrid(
      {required int rowCount,
      required double rowSpacing,
      required double columnSpacing,
      required List<Widget> children}) {
    final columChildren = <Widget>[];

    for (int i = 0; i < children.length; i = i + rowCount) {
      final rowChildren = <Widget>[];
      for (int j = 0; j < rowCount; j++) {
        final child = _dynamicGet(children, i + j);
        if (j > 0 && rowSpacing > 0) {
          rowChildren.add(SizedBox(width: rowSpacing));
        }
        rowChildren.add(Expanded(child: child ?? const SizedBox()));
      }

      if (i > 0 && columnSpacing > 0) {
        columChildren.add(SizedBox(
          height: columnSpacing,
        ));
      }
      columChildren.add(Row(
        children: rowChildren,
      ));
    }

    return columChildren;
  }

  static T? _dynamicGet<T>(List<T> list, int? index) {
    if (index == null) {
      return null;
    }

    if (index >= 0 && index < list.length) {
      return list[index];
    }
    return null;
  }
}

class DynamicSliverGrid extends SliverList {
  DynamicSliverGrid(
      {super.key,
      required int rowCount,
      double rowSpacing = 0,
      double columnSpacing = 0,
      required List<Widget> children})
      : super.list(
            children: DynamicGridWidget.listToGrid(
                rowCount: rowCount,
                rowSpacing: rowSpacing,
                columnSpacing: columnSpacing,
                children: children));
}
