import 'package:fl_chart/fl_chart.dart';
import 'package:neumorphicmeasurementconcept/common/general/state/app_state.dart';
import 'package:neumorphicmeasurementconcept/common/measurement_type.dart';

import 'chart_data_type.dart';

class ChartViewModel {
  final MeasurementType measurementType;
  final List<FlSpot> hourlySpots;
  final List<FlSpot> dailySpots;
  final List<FlSpot> monthlySpots;

  ChartViewModel(
    this.measurementType,
    this.hourlySpots,
    this.dailySpots,
    this.monthlySpots,
  );

  factory ChartViewModel.fromAppState(AppState state) {
    final chartState = state.chartState;
    return ChartViewModel(
      chartState.measurementType,
      chartState.hourly,
      chartState.daily,
      chartState.monthly,
    );
  }

  bool isEmpty() => hourlySpots.isEmpty || dailySpots.isEmpty || monthlySpots.isEmpty;

  List<FlSpot> getData(ChartDataType chartDataType) {
    switch (chartDataType) {
      case ChartDataType.hour:
        return hourlySpots;
      case ChartDataType.day:
        return dailySpots;
      case ChartDataType.month:
        return monthlySpots;
      default:
        return [];
    }
  }
}
