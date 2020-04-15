import 'package:flutter/material.dart';

class NeumorphicContainer extends StatelessWidget {
  final Widget child;
  final double bevel;
  final Color color;
  final Offset blurOffset;

  NeumorphicContainer({
    Key key,
    @required this.child,
    @required this.bevel,
    this.color,
  })  : this.blurOffset = Offset(bevel / 4, bevel / 4),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? Theme.of(context).backgroundColor;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(bevel),
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            blurRadius: bevel,
            offset: -blurOffset,
            color: Color.lerp(color, Colors.white, 0.6),
          ),
          BoxShadow(
            blurRadius: bevel,
            offset: blurOffset,
            color: Color.lerp(color, Colors.black, 0.2),
          )
        ],
      ),
      child: child,
    );
  }
}
