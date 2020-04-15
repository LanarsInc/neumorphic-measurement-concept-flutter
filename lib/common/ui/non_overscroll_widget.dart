import 'package:flutter/material.dart';

class NonOverscrollWidget extends StatelessWidget {
  final Widget child;

  NonOverscrollWidget({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => ScrollConfiguration(
        behavior: _NonOverscrollBehavior(),
        child: child,
      );
}

class _NonOverscrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) => child;
}
