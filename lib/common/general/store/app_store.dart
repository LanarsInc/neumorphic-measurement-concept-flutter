import 'package:flutter/foundation.dart';
import 'package:neumorphicmeasurementconcept/common/general/state/app_state.dart';
import 'package:rebloc/rebloc.dart';

class AppStore extends Store<AppState> {
  AppStore({
    @required AppState initialState,
    List<Bloc<AppState>> blocs = const [],
  }) : super(initialState: initialState, blocs: blocs);
}
