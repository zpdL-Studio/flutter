import 'package:flutter/material.dart';

Future<dynamic> showDynamicBottomSheet({
  required BuildContext context,
  bool isDismissible = true,
  bool isScrollControlled = false,
  WidgetBuilder? title,
  WidgetBuilder? content,
  WidgetBuilder? action,
}) {
  return showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      enableDrag: isDismissible,
      useSafeArea: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: DynamicBottomSheetWidget(
              title: title?.call(context),
              content: content?.call(context),
              action: action?.call(context),
            ),
          ),
        );
      });
}

class DynamicBottomSheetWidget extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final Widget? action;

  const DynamicBottomSheetWidget(
      {super.key, this.title, this.content, this.action});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = this.title;
    final titleTextStyle = theme.dialogTheme.titleTextStyle;

    final content = this.content;
    final contentTextStyle = theme.dialogTheme.contentTextStyle;

    final action = this.action;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          width: double.infinity,
          alignment: AlignmentDirectional.center,
          child: Container(
            width: 49,
            height: 3,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(14)),
                color: theme.colorScheme.outline),
          ),
        ),
        if (title != null)
          titleTextStyle != null
              ? DefaultTextStyle(style: titleTextStyle, child: title)
              : title,
        if (content != null)
          Flexible(
              child: contentTextStyle != null
                  ? DefaultTextStyle(
                      style: contentTextStyle,
                      child: SingleChildScrollView(
                        child: content,
                      ),
                    )
                  : content),
        if (action != null)
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: action,
          )
        else
          const SizedBox(
            height: 8,
          ),
      ],
    );
  }
}
