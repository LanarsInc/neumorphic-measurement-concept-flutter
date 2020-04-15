import 'package:neumorphicmeasurementconcept/chart/bloc/chart_state.dart';

class AppState {
  final ChartState chartState;

  const AppState({
    this.chartState,
  });

  factory AppState.initialState() => AppState(
        chartState: ChartState.initialState(),
      );

  AppState copyWith({
    ChartState chartState,
  }) {
    return AppState(
      chartState: chartState ?? this.chartState,
    );
  }
}
