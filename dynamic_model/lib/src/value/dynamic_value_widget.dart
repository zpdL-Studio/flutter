import 'package:dynamic_model/src/value/dynamic_value.dart';
import 'package:flutter/widgets.dart';

abstract class DynamicValueWidget<T extends DynamicValueBase>
    extends StatelessWidget {
  final T snapshot;

  const DynamicValueWidget({super.key, required this.snapshot});

  @override
  DynamicValueElement<T> createElement() => DynamicValueElement<T>(this);
}

class DynamicValueElement<T extends DynamicValueBase> extends StatelessElement {
  DynamicValueElement(DynamicValueWidget<T> super.widget);

  @override
  DynamicValueWidget<T> get widget => super.widget as DynamicValueWidget<T>;

  @override
  void mount(Element? parent, Object? newSlot) {
    widget.snapshot.addListener(markNeedsBuild);
    super.mount(parent, newSlot);
  }

  @override
  void unmount() {
    widget.snapshot.removeListener(markNeedsBuild);
    super.unmount();
  }

  @override
  void update(DynamicValueWidget<T> newWidget) {
    if (widget.snapshot != newWidget.snapshot) {
      widget.snapshot.removeListener(markNeedsBuild);
      newWidget.snapshot.addListener(markNeedsBuild);
    }
    super.update(newWidget);
  }
}

typedef DynamicValueWidgetBuilder<T> = Widget Function(
    BuildContext context, DynamicValue<T> value);
typedef DynamicValueValueBuilder<T> = Widget Function(
    BuildContext context, T value);
typedef DynamicValueErrorBuilder<T> = Widget Function(
    BuildContext context, Object error, T? value);
typedef DynamicValueWaitBuilder<T> = Widget Function(BuildContext context);

class DynamicValueBuilder<T> extends DynamicValueWidget<DynamicValue<T>> {
  final DynamicValueWidgetBuilder<T>? builder;
  final DynamicValueValueBuilder<T>? value;
  final DynamicValueErrorBuilder<T>? error;
  final DynamicValueWaitBuilder<T>? wait;

  const DynamicValueBuilder(
      {super.key,
      required super.snapshot,
      this.builder,
      this.value,
      this.error,
      this.wait});

  @override
  Widget build(BuildContext context) {
    final Widget? child;

    switch (snapshot.state) {
      case DynamicValueState.waiting:
        child = wait?.call(context);
        break;
      case DynamicValueState.active:
      case DynamicValueState.disposed:
        final value = snapshot.valueOrNull;
        final error = snapshot.error;
        if (error != null) {
          child = this.error?.call(context, error, value);
        } else if (value != null) {
          child = this.value?.call(context, value);
        } else {
          child = null;
        }
        break;
    }

    return child ?? builder?.call(context, snapshot) ?? const SizedBox();
  }
}

extension DynamicValueBuild<T> on DynamicValue<T> {
  Widget build({
    DynamicValueWidgetBuilder<T>? builder,
    DynamicValueValueBuilder<T>? value,
    DynamicValueErrorBuilder<T>? error,
    DynamicValueWaitBuilder<T>? wait,
  }) {
    return DynamicValueBuilder(
      snapshot: this,
      builder: builder,
      value: value,
      error: error,
      wait: wait,
    );
  }
}

typedef DynamicNValueWidgetBuilder<T> = Widget Function(
    BuildContext context, DynamicNValue<T> value);
typedef DynamicNValueValueBuilder<T> = Widget Function(
    BuildContext context, T? value);

class DynamicNValueBuilder<T> extends DynamicValueWidget<DynamicNValue<T>> {
  final DynamicNValueWidgetBuilder<T>? builder;
  final DynamicNValueValueBuilder<T>? value;
  final DynamicValueErrorBuilder<T>? error;
  final DynamicValueWaitBuilder<T>? wait;

  const DynamicNValueBuilder(
      {super.key,
      required super.snapshot,
      this.builder,
      this.value,
      this.error,
      this.wait});

  @override
  Widget build(BuildContext context) {
    final Widget? child;

    switch (snapshot.state) {
      case DynamicValueState.waiting:
        child = wait?.call(context);
        break;
      case DynamicValueState.active:
      case DynamicValueState.disposed:
        final error = snapshot.error;
        if (error != null) {
          child = this.error?.call(context, error, snapshot.value);
        } else {
          child = this.value?.call(context, snapshot.value);
        }
        break;
    }

    return child ?? builder?.call(context, snapshot) ?? const SizedBox();
  }
}

extension DynamicNValueBuild<T> on DynamicNValue<T> {
  Widget build({
    DynamicNValueWidgetBuilder<T>? builder,
    DynamicNValueValueBuilder<T>? value,
    DynamicValueErrorBuilder<T>? error,
    DynamicValueWaitBuilder<T>? wait,
  }) {
    return DynamicNValueBuilder(
      snapshot: this,
      builder: builder,
      value: value,
      error: error,
      wait: wait,
    );
  }
}
