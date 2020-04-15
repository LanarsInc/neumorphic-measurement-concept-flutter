import 'dart:math';

import 'package:flutter/material.dart';

class FullScreenSingleChildScrollView extends StatelessWidget {
  final BuildContext context;
  final Widget child;

  FullScreenSingleChildScrollView({
    @required this.context,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        var queryData = MediaQuery.of(this.context);
        final screenHeight = queryData.size.height - queryData.padding.top - queryData.padding.bottom;
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: max(constraints.maxHeight, screenHeight)),
            child: IntrinsicHeight(child: this.child),
          ),
        );
      },
    );
  }
}
