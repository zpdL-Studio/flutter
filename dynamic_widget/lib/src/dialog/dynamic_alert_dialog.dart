import 'package:flutter/material.dart';

Future<dynamic> showDynamicAlertDialog({
  required BuildContext context,
  bool isDismissible = true,
  WidgetBuilder? title,
  WidgetBuilder? content,
  WidgetBuilder? action,
}) {
  return showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) {
        final actionWidget = action?.call(context);
        final contentWidget = content?.call(context);

        return AlertDialog(
          title: title?.call(context),
          content: contentWidget != null ? SingleChildScrollView(child: contentWidget,) : null,
          actions: actionWidget != null ? [actionWidget] : null,
        );
      });
}
