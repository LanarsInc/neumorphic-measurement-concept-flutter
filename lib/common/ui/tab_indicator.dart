import 'package:flutter/material.dart';
import 'package:neumorphicmeasurementconcept/common/general/theme_provider.dart';

class BubbleTabIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;
  final double indicatorRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry insets;
  final TabBarIndicatorSize tabBarIndicatorSize;

  const BubbleTabIndicator({
    this.indicatorHeight: 20.0,
    this.indicatorColor: Colors.greenAccent,
    this.indicatorRadius: 16.0,
    this.tabBarIndicatorSize = TabBarIndicatorSize.label,
    this.padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
    this.insets: const EdgeInsets.symmetric(horizontal: 5.0),
  })  : assert(indicatorHeight != null),
        assert(indicatorColor != null),
        assert(indicatorRadius != null),
        assert(padding != null),
        assert(insets != null);

  @override
  Decoration lerpFrom(Decoration a, double t) {
    if (a is BubbleTabIndicator) {
      return BubbleTabIndicator(
        padding: EdgeInsetsGeometry.lerp(a.padding, padding, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration lerpTo(Decoration b, double t) {
    if (b is BubbleTabIndicator) {
      return BubbleTabIndicator(
        padding: EdgeInsetsGeometry.lerp(padding, b.padding, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _BubblePainter createBoxPainter([VoidCallback onChanged]) {
    return _BubblePainter(this, onChanged);
  }
}

class _BubblePainter extends BoxPainter {
  _BubblePainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  final BubbleTabIndicator decoration;

  double get indicatorHeight => decoration.indicatorHeight;

  Color get indicatorColor => decoration.indicatorColor;

  double get indicatorRadius => decoration.indicatorRadius;

  EdgeInsetsGeometry get padding => decoration.padding;

  EdgeInsetsGeometry get insets => decoration.insets;

  TabBarIndicatorSize get tabBarIndicatorSize => decoration.tabBarIndicatorSize;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    final Rect indicatorRect =
        Offset(offset.dx, (configuration.size.height / 2) - indicatorHeight / 2) & Size(configuration.size.width + 10, indicatorHeight);
    final Rect shadowRect =
        Offset(offset.dx, (configuration.size.height / 2) - indicatorHeight / 2) & Size(configuration.size.width, indicatorHeight - 4);
    final TextDirection textDirection = configuration.textDirection;
    final Rect indicator = _indicatorRectFor(indicatorRect, textDirection);
    final Rect shadow = _shadowRectFor(shadowRect, textDirection);
    final Paint paint = Paint();
    paint.color = Color.lerp(indicatorColor, Colors.black, 0.07);
    paint.style = PaintingStyle.fill;

    final bottomShadowRRect = RRect.fromRectAndRadius(Offset(offset.dx + 4, 4) & shadow.size, Radius.circular(indicatorRadius));
    canvas.drawRRect(
        bottomShadowRRect,
        Paint()
          ..color = Color.lerp(ThemeProvider.grey, Colors.black, 0.15)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(indicatorRadius)));

    final topShadowRRect = RRect.fromRectAndRadius(Offset(offset.dx - 4, 4) & shadow.size, Radius.circular(indicatorRadius));
    canvas.drawRRect(
        topShadowRRect,
        Paint()
          ..color = Color.lerp(ThemeProvider.grey, Colors.white, 1)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(indicatorRadius)));

    canvas.drawRRect(RRect.fromRectAndRadius(indicator, Radius.circular(indicatorRadius)), paint);
  }

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    assert(rect != null);
    assert(textDirection != null);

    Rect indicator = padding.resolve(textDirection).inflateRect(rect);

    if (tabBarIndicatorSize == TabBarIndicatorSize.tab) {
      indicator = insets.resolve(textDirection).deflateRect(rect);
    }

    return Rect.fromLTWH(
      indicator.left - 5,
      indicator.top,
      indicator.width,
      indicator.height,
    );
  }

  Rect _shadowRectFor(Rect rect, TextDirection textDirection) {
    assert(rect != null);
    assert(textDirection != null);

    Rect indicator = padding.resolve(textDirection).inflateRect(rect);

    if (tabBarIndicatorSize == TabBarIndicatorSize.tab) {
      indicator = insets.resolve(textDirection).deflateRect(rect);
    }

    return Rect.fromLTWH(
      indicator.left,
      indicator.top,
      indicator.width,
      indicator.height,
    );
  }

  static double convertRadiusToSigma(double radius) => radius * 0.57735 + 0.5;
}
