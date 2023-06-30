import 'package:dynamic_widget/src/widget/dynamic_layout.dart';
import 'package:dynamic_widget/src/widget/edge_insets.dart';
import 'package:flutter/material.dart';

import 'dynamic_alert_dialog.dart';
import 'dynamic_bottom_sheet.dart';

typedef DynamicDialogWidgetBuilder = Widget Function(
    BuildContext context, DynamicLayoutData? dynamicLayout);

Future<dynamic> showDynamicDialog({
  required BuildContext context,
  bool isDismissible = true,
  bool isScrollControlled = false,
  DynamicDialogWidgetBuilder? title,
  DynamicDialogWidgetBuilder? content,
  DynamicDialogWidgetBuilder? action,
}) {
  final dynamicLayout = DynamicLayout.byMediaQuery(context);

  switch (dynamicLayout.device) {
    case DynamicDevice.mobile:
      return showDynamicBottomSheet(
        context: context,
        isDismissible: isDismissible,
        isScrollControlled: isScrollControlled,
        title: title != null ? (_) => title(_, dynamicLayout) : null,
        content: content != null ? (_) => content(_, dynamicLayout) : null,
        action: action != null ? (_) => action(_, dynamicLayout) : null,
      );
    case DynamicDevice.tablet:
    case DynamicDevice.desktop:
      return showDynamicAlertDialog(
        context: context,
        isDismissible: isDismissible,
        title: title != null ? (_) => title(_, null) : null,
        content: content != null ? (_) => content(_, null) : null,
        action: action != null ? (_) => action(_, null) : null,
      );
  }
}

Widget Function(
        BuildContext context, dynamic result, String text, ButtonStyle? style)
    buildDynamicAction =
    (BuildContext context, dynamic result, String text, ButtonStyle? style) {
  return ElevatedButton(
      style: style,
      onPressed: () {
        Navigator.of(context).pop(result);
      },
      child: Container(
        width: double.infinity,
        height: 48,
        alignment: AlignmentDirectional.center,
        child: Text(text),
      ));
};

Future<dynamic> showDynamicSimpleDialog({
  required BuildContext context,
  bool isDismissible = true,
  String? title,
  String? content,
  List<(dynamic, String, ButtonStyle?)>? actions,
}) {
  return showDynamicDialog(
      context: context,
      isDismissible: isDismissible,
      title: title != null
          ? (context, dynamicLayout) => Container(
                alignment: AlignmentDirectional.centerStart,
                padding: EdgeInsetsDynamic(horizontal: dynamicLayout?.padding),
                child: Text(title),
              )
          : null,
      content: (context, dynamicLayout) => content != null
          ? Container(
              padding: EdgeInsetsDynamic(
                  vertical: 16, horizontal: dynamicLayout?.padding),
              child: Text(content),
            )
          : const SizedBox(
              height: 32,
            ),
      action: actions != null
          ? (context, dynamicLayout) {
              final actionWidget = <Widget>[];
              for (final (result, text, style) in actions) {
                if (actionWidget.isNotEmpty) {
                  actionWidget.add(const SizedBox(
                    width: 8,
                  ));
                }
                actionWidget.add(Expanded(
                    child: buildDynamicAction(context, result, text, style)));
              }

              return Padding(
                  padding:
                      EdgeInsetsDynamic(horizontal: dynamicLayout?.padding),
                  child: Row(
                    children: actionWidget,
                  ));
            }
          : null);
}

Future<dynamic> showDynamicSelectDialog<T>({
  required BuildContext context,
  bool isDismissible = true,
  WidgetBuilder? title,
  required Iterable<T> items,
  required Widget Function(
          BuildContext context, DynamicLayoutData? dynamicLayout, T item)
      itemBuilder,
  List<(dynamic, String, ButtonStyle?)>? actions,
}) {
  return showDynamicDialog(
      context: context,
      isDismissible: isDismissible,
      title: title != null
          ? (context, dynamicLayout) => Padding(
              padding: EdgeInsetsDynamic(horizontal: dynamicLayout?.padding),
              child: title(context))
          : null,
      content: (context, dynamicLayout) {
        final children =
            items.map((e) => itemBuilder(context, dynamicLayout, e));
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: children.toList(),
        );
      },
      action: actions != null
          ? (context, dynamicLayout) {
              final actionWidget = <Widget>[];
              for (final (result, text, style) in actions) {
                if (actionWidget.isNotEmpty) {
                  actionWidget.add(const SizedBox(
                    width: 8,
                  ));
                }
                actionWidget.add(Expanded(
                    child: buildDynamicAction(context, result, text, style)));
              }

              return Padding(
                  padding:
                      EdgeInsetsDynamic(horizontal: dynamicLayout?.padding),
                  child: Row(
                    children: actionWidget,
                  ));
            }
          : null);
}
