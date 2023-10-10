import 'package:flutter/material.dart';

typedef DynamicAsyncWorkerData<T> = void Function(T data);
typedef DynamicAsyncWorkerError = void Function(Object e);

typedef DynamicAsyncWorkerLoadingBuilder = Widget Function(
    BuildContext context, bool loading);

class DynamicAsyncWorker {
  final _asyncWorking = ValueNotifier(false);
  int _workerCount = 0;

  void showLoading() {
    _workerCount++;
    _updateWorkerState();
  }

  void hideLoading() {
    _workerCount--;
    _updateWorkerState();
  }

  void _updateWorkerState() {
    final working = _workerCount > 0;
    if (_asyncWorking.value != working) {
      _asyncWorking.value = working;
    }
  }

  void asyncWorker<T>(Future<T> Function() worker,
      {DynamicAsyncWorkerData<T>? onData,
      DynamicAsyncWorkerError? onError}) async {
    showLoading();
    try {
      final T result = await worker();
      onData?.call(result);
    } catch (e) {
      onError?.call(e);
    } finally {
      hideLoading();
    }
  }

  void dispose() {
    _asyncWorking.dispose();
  }
}

class DynamicAsyncWorkerWidget extends StatelessWidget {
  final DynamicAsyncWorker worker;

  final Duration? showDuration;
  final Duration? hideDuration;
  final Curve? curve;
  final DynamicAsyncWorkerLoadingBuilder? loadingBuilder;

  final Widget? child;

  const DynamicAsyncWorkerWidget({
    super.key,
    required this.worker,
    this.showDuration,
    this.hideDuration,
    this.curve,
    this.loadingBuilder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final child = this.child;
    final style =
        (Theme.of(context).extension<DynamicAsyncAsyncWorkerStyle>() ??
                const DynamicAsyncAsyncWorkerStyle())
            .copyWith(
      showDuration: showDuration,
      hideDuration: hideDuration,
      curve: curve,
      loadingBuilder: loadingBuilder,
    ) as DynamicAsyncAsyncWorkerStyle;

    return Stack(children: [
      if (child != null) child,
      ValueListenableBuilder(
          valueListenable: worker._asyncWorking,
          builder: (BuildContext context, bool value, Widget? child) {
            return _AsyncWorkerWidget(loading: value, style: style);
          })
    ]);
  }
}

class _AsyncWorkerWidget extends StatefulWidget {
  final bool loading;
  final DynamicAsyncAsyncWorkerStyle style;

  const _AsyncWorkerWidget({required this.loading, required this.style});

  @override
  State<_AsyncWorkerWidget> createState() => _AsyncWorkerWidgetState();
}

class _AsyncWorkerWidgetState extends State<_AsyncWorkerWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: widget.style.showDuration,
        reverseDuration: widget.style.hideDuration);
    _animation = CurvedAnimation(parent: _controller, curve: widget.style.curve)
      ..addListener(_animationListener);
    if (widget.loading) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _animation.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _AsyncWorkerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.loading != oldWidget.loading) {
      if (widget.loading) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  void _animationListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final value = _animation.value;
    if (!widget.loading && value <= 0) {
      return const SizedBox();
    }

    return Opacity(
      opacity: value,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        alignment: AlignmentDirectional.center,
        child: widget.style.loadingBuilder(context, widget.loading),
      ),
    );
  }
}

class DynamicAsyncAsyncWorkerStyle
    extends ThemeExtension<DynamicAsyncAsyncWorkerStyle> {
  static const int defaultShowDelayMs = 500;
  static const int defaultHideDelayMs = 300;

  static Widget defaultLoadingBuilder(BuildContext context, bool loading) =>
      const CircularProgressIndicator.adaptive();

  static void defaultErrorBuilder(BuildContext context, Object e) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
          ),
          content: Text(e.toString()),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'))
          ],
        );
      });

  const DynamicAsyncAsyncWorkerStyle(
      {this.showDuration = const Duration(milliseconds: defaultShowDelayMs),
      this.hideDuration = const Duration(milliseconds: defaultHideDelayMs),
      this.curve = Curves.easeInOut,
      this.loadingBuilder = defaultLoadingBuilder});

  final Duration showDuration;
  final Duration hideDuration;
  final Curve curve;

  final DynamicAsyncWorkerLoadingBuilder loadingBuilder;

  @override
  ThemeExtension<DynamicAsyncAsyncWorkerStyle> copyWith({
    Duration? showDuration,
    Duration? hideDuration,
    Curve? curve,
    DynamicAsyncWorkerLoadingBuilder? loadingBuilder,
  }) =>
      DynamicAsyncAsyncWorkerStyle(
        showDuration: showDuration ?? this.showDuration,
        hideDuration: hideDuration ?? this.hideDuration,
        curve: curve ?? this.curve,
        loadingBuilder: loadingBuilder ?? this.loadingBuilder,
      );

  @override
  ThemeExtension<DynamicAsyncAsyncWorkerStyle> lerp(
      covariant ThemeExtension<DynamicAsyncAsyncWorkerStyle>? other, double t) {
    return this;
  }
}
