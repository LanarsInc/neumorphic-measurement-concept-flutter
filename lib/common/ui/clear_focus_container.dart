import 'package:flutter/material.dart';

class ClearFocusContainer extends StatelessWidget {
  final Widget child;

  ClearFocusContainer({Key key, this.child});

  @override
  Widget build(BuildContext context) => GestureDetector(
        child: child,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      );
}
