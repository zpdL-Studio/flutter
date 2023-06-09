import 'package:dynamic_widget/src/widget/dynamic_layout.dart';
import 'package:dynamic_widget/src/widget/edge_insets.dart';
import 'package:flutter/material.dart';

import 'dynamic_alert_dialog.dart';
import 'dynamic_bottom_sheet.dart';

typedef DynamicDialogWidgetBuilder = Widget Function(
    BuildContext context, DynamicLayoutData? dynamicLayout);

Widget Function(BuildContext context,
        List<(dynamic result, String text, ButtonStyle? style)> actions)
    buildDynamicActions = (BuildContext context,
        List<(dynamic result, String text, ButtonStyle? style)> actions) {
  final actionWidget = <Widget>[];
  for (final (result, text, style) in actions) {
    if (actionWidget.isNotEmpty) {
      actionWidget.add(const SizedBox(
        width: 8,
      ));
    }
    actionWidget.add(Expanded(
        child: ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.of(context).pop(result);
            },
            child: Container(
              width: double.infinity,
              height: 48,
              alignment: AlignmentDirectional.center,
              child: Text(text),
            ))));
  }

  return Row(
    children: actionWidget,
  );
};

Future<dynamic> showDynamicDialog({
  required BuildContext context,
  bool isDismissible = true,
  bool isScrollControlled = false,
  DynamicDialogWidgetBuilder? title,
  DynamicDialogWidgetBuilder? content,
  DynamicDialogWidgetBuilder? action,
  List<(dynamic result, String text, ButtonStyle? style)>? actions,
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
        action: actions != null
            ? (_) => Padding(
                  padding: EdgeInsetsDynamic(horizontal: dynamicLayout.padding),
                  child: buildDynamicActions(context, actions),
                )
            : action != null
                ? (_) => action(_, dynamicLayout)
                : null,
      );
    case DynamicDevice.tablet:
    case DynamicDevice.desktop:
      return showDynamicAlertDialog(
        context: context,
        isDismissible: isDismissible,
        title: title != null ? (_) => title(_, null) : null,
        content: content != null ? (_) => content(_, null) : null,
        action: actions != null
            ? (_) => buildDynamicActions(context, actions)
            : action != null
                ? (_) => action(_, null)
                : null,
      );
  }
}

Future<dynamic> showDynamicSimpleDialog({
  required BuildContext context,
  bool isDismissible = true,
  bool isScrollControlled = false,
  String? title,
  String? content,
  double contentPadding = 16,
  List<(dynamic, String, ButtonStyle?)>? actions,
}) {
  return showDynamicDialog(
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      title: showDynamicSimpleTitle(title),
      content: showDynamicSimpleContent(content, contentPadding) ??
          (context, dynamicLayout) => SizedBox(
                height: contentPadding * 2,
              ),
      actions: actions);
}

DynamicDialogWidgetBuilder? showDynamicSimpleTitle(String? title) {
  if (title == null) {
    return null;
  }

  return (context, dynamicLayout) => Container(
        alignment: AlignmentDirectional.centerStart,
        padding: EdgeInsetsDynamic(horizontal: dynamicLayout?.padding),
        child: Text(title),
      );
}

DynamicDialogWidgetBuilder? showDynamicSimpleContent(String? content,
    [double contentPadding = 16]) {
  if (content == null) {
    return null;
  }

  return (context, dynamicLayout) => Container(
        padding: EdgeInsetsDynamic(
            vertical: contentPadding, horizontal: dynamicLayout?.padding),
        child: Text(content),
      );
}

Future<dynamic> showDynamicSelectDialog<T>({
  required BuildContext context,
  bool isDismissible = true,
  bool isScrollControlled = false,
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
      isScrollControlled: isScrollControlled,
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
      actions: actions);
}
