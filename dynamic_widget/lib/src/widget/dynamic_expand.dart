import 'package:flutter/material.dart';

class DynamicExpand extends StatefulWidget {
  final bool isExpanded;
  final Duration duration;
  final Curve curve;
  final Widget child;

  const DynamicExpand({
    super.key,
    this.isExpanded = true,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.fastOutSlowIn,
    required this.child,
  });

  @override
  State<DynamicExpand> createState() => _DynamicExpandState();
}

class _DynamicExpandState extends State<DynamicExpand>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.value = widget.isExpanded ? 1.0 : 0.0;
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _animation.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DynamicExpand oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0, sizeFactor: _animation, child: widget.child);
  }
}
