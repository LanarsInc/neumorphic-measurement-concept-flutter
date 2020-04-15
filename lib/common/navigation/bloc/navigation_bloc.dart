import 'dart:async';

import 'package:flutter/widgets.dart' hide Action;
import 'package:neumorphicmeasurementconcept/common/general/state/app_state.dart';
import 'package:rebloc/rebloc.dart';

import '../base_navigation_screen.dart';

abstract class BaseNavigationAction extends Action {
  final BaseNavigationScreen toScreen;

  BaseNavigationAction(this.toScreen);
}

class PushNamedRouteAction extends BaseNavigationAction {
  final BaseNavigationScreen toScreen;

  PushNamedRouteAction(this.toScreen) : super(toScreen);
}

class PushNamedReplacementRouteAction extends BaseNavigationAction {
  final BaseNavigationScreen toScreen;

  PushNamedReplacementRouteAction(this.toScreen) : super(toScreen);
}

class PopRouteAction extends Action {}

class PopToAndPushNamedRouteAction extends BaseNavigationAction {
  final String popToRouteName;
  final BaseNavigationScreen toScreen;

  PopToAndPushNamedRouteAction(this.popToRouteName, this.toScreen) : super(toScreen);
}

class PopAndPushNamedRouteAction extends BaseNavigationAction {
  final BaseNavigationScreen toScreen;

  PopAndPushNamedRouteAction(this.toScreen) : super(toScreen);
}

class PopUntilRouteAction extends Action {
  final BaseNavigationScreen toScreen;

  PopUntilRouteAction(this.toScreen);
}

class ClearStackAndPushRouteAction extends PopToAndPushNamedRouteAction {
  final BaseNavigationScreen toScreen;

  ClearStackAndPushRouteAction(this.toScreen) : super('', toScreen);
}

/// A Bloc for manipulating a [Navigator].
///
/// This class will push and pop named [Route]s on a [Navigator] in response to
/// incoming [Action]s. It interacts only with the middleware stream, and does
/// not make any changes to app state.
class NavigationBloc extends SimpleBloc<AppState> {
  NavigationBloc(this.navigatorKey) : assert(navigatorKey != null);

  // Key to the [Navigator] widget this Bloc manages.
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  FutureOr<Action> middleware(DispatchFunction dispatcher, AppState state, Action action) {
    if (action is PopRouteAction) {
      navigatorKey.currentState?.pop();
    } else if (action is PushNamedRouteAction) {
      navigatorKey.currentState?.pushNamed(action.toScreen.routeName, arguments: action.toScreen);
    } else if (action is PushNamedReplacementRouteAction) {
      navigatorKey.currentState?.pushReplacementNamed(action.toScreen.routeName, arguments: action.toScreen);
    } else if (action is PopAndPushNamedRouteAction) {
      navigatorKey.currentState?.popAndPushNamed(action.toScreen.routeName, arguments: action.toScreen);
    } else if (action is PopUntilRouteAction) {
      navigatorKey.currentState?.popUntil((route) => route.settings.name == action.toScreen.routeName);
    } else if (action is PopToAndPushNamedRouteAction) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(action.toScreen.routeName, (Route<dynamic> route) {
        return route.settings.name == action.popToRouteName;
      }, arguments: action.toScreen);
    }

    return action;
  }
}
