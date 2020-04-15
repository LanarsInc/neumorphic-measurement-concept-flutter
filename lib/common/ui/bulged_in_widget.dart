import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../painter.dart';

class BulgedInWidget extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final Color color;
  final double cornerRadius;
  final double borderWidth;
  final GradientDirection direction;

  BulgedInWidget({
    @required this.child,
    this.width = 40,
    this.height = 40,
    this.color,
    this.cornerRadius = 8,
    this.borderWidth = 0,
    this.direction = GradientDirection.fromTopCenterToBottomCenter,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GradientPainter(
        radius: cornerRadius,
        strokeWidth: borderWidth,
        gradient: _getBorderGradient(direction, context),
      ),
      child: Container(
        margin: EdgeInsets.all(borderWidth),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cornerRadius - borderWidth),
          gradient: _getGradient(direction, context),
        ),
        child: child,
      ),
    );
  }

  LinearGradient _getGradient(GradientDirection direction, BuildContext context) {
    final color = this.color ?? Theme.of(context).accentColor;
    Alignment begin;
    Alignment end;
    Color colorDarkShader;
    switch (direction) {
      case GradientDirection.fromTopCenterToBottomCenter:
        begin = Alignment.topCenter;
        end = Alignment.bottomCenter;
        colorDarkShader = Color.lerp(color, Colors.black, 0.1);
        break;
      case GradientDirection.fromTopLeftToBottomRight:
        begin = Alignment.topLeft;
        end = Alignment.bottomRight;
        colorDarkShader = Color.lerp(color, Colors.black, 0.2);
        break;
    }

    return LinearGradient(
      begin: begin,
      end: end,
      colors: [
        colorDarkShader,
        color,
        Color.lerp(color, Colors.white, 0.2),
      ],
      stops: [0.0, 0.75, 1.0],
    );
  }

  LinearGradient _getBorderGradient(GradientDirection direction, BuildContext context) {
    final color = this.color ?? Theme.of(context).accentColor;
    Alignment begin;
    Alignment end;
    switch (direction) {
      case GradientDirection.fromTopCenterToBottomCenter:
        begin = Alignment.topCenter;
        end = Alignment.bottomCenter;
        break;
      case GradientDirection.fromTopLeftToBottomRight:
        begin = Alignment.topLeft;
        end = Alignment.bottomRight;
        break;
    }

    return LinearGradient(
      begin: begin,
      end: end,
      colors: [
        Color.lerp(color, Colors.black, 0.15),
        Color.lerp(color, Colors.white, 0.85),
      ],
      stops: [
        0.0,
        1.0,
      ],
    );
  }
}

enum GradientDirection {
  fromTopCenterToBottomCenter,
  fromTopLeftToBottomRight,
}
