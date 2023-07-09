import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

typedef DynamicNetworkImageEmptyWidgetBuilder = Widget Function(
    BuildContext context);
typedef DynamicNetworkImageProgressIndicatorBuilder = Widget Function(
    BuildContext context, String url, DownloadProgress progress);
typedef DynamicNetworkImageErrorWidgetBuilder = Widget Function(
    BuildContext context, String url, dynamic error);

class DynamicNetworkImageStyle
    extends ThemeExtension<DynamicNetworkImageStyle> {
  static Widget defaultEmptyWidgetBuilder(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return DynamicNetworkFillRatioIconWidget(
        icon: Icons.image_outlined,
        size: min(constraint.maxWidth, constraint.maxHeight),
        fillRatio: 0.66,
        color: Theme.of(context).hintColor,
      );
    });
  }

  static Widget defaultProgressIndicatorBuilder(
      BuildContext context, String url, DownloadProgress progress) {
    if (progress.progress == null) {
      return Container();
    }

    return LayoutBuilder(builder: (context, constraint) {
      return DynamicNetworkFillRatioIconWidget(
        icon: Icons.downloading_outlined,
        size: min(constraint.maxWidth, constraint.maxHeight),
        fillRatio: 0.66,
        color: Theme.of(context).hintColor,
      );
    });
  }

  static Widget defaultErrorWidgetBuilder(
    BuildContext context,
    String url,
    dynamic error,
  ) {
    return LayoutBuilder(builder: (context, constraint) {
      return DynamicNetworkFillRatioIconWidget(
        icon: Icons.image_not_supported_outlined,
        size: min(constraint.maxWidth, constraint.maxHeight),
        fillRatio: 0.66,
        color: Theme.of(context).hintColor,
      );
    });
  }

  const DynamicNetworkImageStyle({
    this.fit = BoxFit.cover,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeOutDuration = const Duration(milliseconds: 500),
    this.visibleProgress = false,
    this.emptyWidgetBuilder = defaultEmptyWidgetBuilder,
    this.progressIndicatorBuilder = defaultProgressIndicatorBuilder,
    this.errorWidgetBuilder = defaultErrorWidgetBuilder,
  });

  final BoxFit fit;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;
  final bool visibleProgress;
  final DynamicNetworkImageEmptyWidgetBuilder emptyWidgetBuilder;
  final DynamicNetworkImageProgressIndicatorBuilder progressIndicatorBuilder;
  final DynamicNetworkImageErrorWidgetBuilder errorWidgetBuilder;

  @override
  ThemeExtension<DynamicNetworkImageStyle> copyWith({
    BoxFit? fit,
    Duration? fadeInDuration,
    Duration? fadeOutDuration,
    bool? visibleProgress,
    DynamicNetworkImageEmptyWidgetBuilder? emptyWidgetBuilder,
    DynamicNetworkImageProgressIndicatorBuilder? progressIndicatorBuilder,
    DynamicNetworkImageErrorWidgetBuilder? errorWidgetBuilder,
  }) =>
      DynamicNetworkImageStyle(
        fit: fit ?? this.fit,
        fadeInDuration: fadeInDuration ?? this.fadeInDuration,
        fadeOutDuration: fadeOutDuration ?? this.fadeOutDuration,
        visibleProgress: visibleProgress ?? this.visibleProgress,
        emptyWidgetBuilder: emptyWidgetBuilder ?? this.emptyWidgetBuilder,
        progressIndicatorBuilder:
            progressIndicatorBuilder ?? this.progressIndicatorBuilder,
        errorWidgetBuilder: errorWidgetBuilder ?? this.errorWidgetBuilder,
      );

  @override
  ThemeExtension<DynamicNetworkImageStyle> lerp(
      covariant ThemeExtension<DynamicNetworkImageStyle>? other, double t) {
    return this;
  }
}

class DynamicNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;
  final bool visibleProgress;
  final DynamicNetworkImageEmptyWidgetBuilder? emptyWidgetBuilder;
  final DynamicNetworkImageProgressIndicatorBuilder? progressIndicatorBuilder;
  final DynamicNetworkImageErrorWidgetBuilder? errorWidgetBuilder;

  const DynamicNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeOutDuration = const Duration(milliseconds: 1000),
    this.visibleProgress = false,
    this.emptyWidgetBuilder,
    this.progressIndicatorBuilder,
    this.errorWidgetBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final style = (Theme.of(context).extension<DynamicNetworkImageStyle>() ??
        const DynamicNetworkImageStyle().copyWith(
          fit: fit,
          fadeInDuration: fadeInDuration,
          fadeOutDuration: fadeOutDuration,
          visibleProgress: visibleProgress,
          emptyWidgetBuilder: emptyWidgetBuilder,
          progressIndicatorBuilder: progressIndicatorBuilder,
          errorWidgetBuilder: errorWidgetBuilder,
        )) as DynamicNetworkImageStyle;

    // return style.errorWidgetBuilder(context, '', null);
    final imageUrl = this.imageUrl;
    if (imageUrl == null || imageUrl.isEmpty) {
      return style.emptyWidgetBuilder(context);
    }

    return CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: style.fit,
        fadeInDuration: style.fadeInDuration,
        fadeOutDuration: style.fadeOutDuration,
        progressIndicatorBuilder:
            style.visibleProgress ? style.progressIndicatorBuilder : null,
        errorWidget: style.errorWidgetBuilder);
  }
}

class DynamicNetworkFillRatioIconWidget extends StatelessWidget {
  final IconData icon;
  final double? size;
  final double? fillRatio;
  final Color? color;

  const DynamicNetworkFillRatioIconWidget(
      {super.key, required this.icon, this.size, this.fillRatio, this.color});

  @override
  Widget build(BuildContext context) {
    final icon = this.icon;
    final size = this.size ?? Theme.of(context).iconTheme.size;
    final fillRatio = this.fillRatio;

    return Icon(
      icon,
      size: size != null && fillRatio != null ? min(size * fillRatio, 128) : null,
      color: color,
    );
  }
}
