import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rebloc/rebloc.dart';

import 'chart/bloc/chart_bloc.dart';
import 'common/general/state/app_state.dart';
import 'common/general/store/app_store.dart';
import 'common/general/theme_provider.dart';
import 'common/navigation/base_navigation_screen.dart';
import 'common/navigation/bloc/navigation_bloc.dart';
import 'main/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final navigatorKey = GlobalKey<NavigatorState>();
  final store = AppStore(
    initialState: AppState.initialState(),
    blocs: [
      NavigationBloc(navigatorKey),
      ChartBloc(),
    ],
  );

  runApp(MyApp(
    store: store,
    navigatorKey: navigatorKey,
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  final GlobalKey<NavigatorState> navigatorKey;

  MyApp({this.store, this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Neumorphic Measurement',
        theme: ThemeProvider.get(),
        navigatorKey: navigatorKey,
        onGenerateRoute: (settings) => BaseNavigationScreen.getScreen(settings, initialScreen: MainScreen()),
      ),
    );
  }
}
