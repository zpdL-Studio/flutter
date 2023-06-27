import 'package:flutter/widgets.dart';

class OutSideUnFocus extends StatelessWidget {
  final Widget child;

  const OutSideUnFocus({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        unFocus(context);
      },
      child: child,
    );
  }

  static void unFocus(BuildContext context) {
    final focusScopeNode = FocusScope.of(context);
    if (!focusScopeNode.hasPrimaryFocus && focusScopeNode.hasFocus) {
      focusScopeNode.unfocus();
    }
  }
}
