import 'package:flutter/material.dart';

abstract class BaseNavigationScreen extends Widget {
  final String routeName;

  BaseNavigationScreen({Key key, this.routeName}) : super(key: key);

  static MaterialPageRoute getScreen(RouteSettings settings, {initialScreen: BaseNavigationScreen}) {
    return MaterialPageRoute(
      builder: (context) => (settings?.arguments as BaseNavigationScreen) ?? initialScreen,
      settings: settings,
    );
  }
}

abstract class BaseNavigationStatefulScreen extends BaseNavigationScreen implements StatefulWidget {
  BaseNavigationStatefulScreen({Key key, String routeName}) : super(key: key, routeName: routeName);

  @override
  StatefulElement createElement() => StatefulElement(this);
}

abstract class BaseNavigationStatelessScreen extends BaseNavigationScreen implements StatelessWidget {
  BaseNavigationStatelessScreen({Key key, String routeName}) : super(key: key, routeName: routeName);

  @override
  StatelessElement createElement() => StatelessElement(this);
}
