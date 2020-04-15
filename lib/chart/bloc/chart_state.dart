import 'package:fl_chart/fl_chart.dart';
import 'package:neumorphicmeasurementconcept/chart/model/chart_data_type.dart';
import 'package:neumorphicmeasurementconcept/common/measurement_type.dart';

class ChartState {
  final MeasurementType measurementType;
  final ChartDataType chartDataType;
  final List<FlSpot> hourly;
  final List<FlSpot> daily;
  final List<FlSpot> monthly;

  ChartState({
    this.measurementType,
    this.chartDataType,
    this.hourly,
    this.daily,
    this.monthly,
  });

  factory ChartState.initialState() => ChartState(
        measurementType: null,
        chartDataType: null,
        hourly: [],
        daily: [],
        monthly: [],
      );

  ChartState copyWith({
    MeasurementType measurementType,
    ChartDataType chartDataType,
    List<FlSpot> hourly,
    List<FlSpot> daily,
    List<FlSpot> monthly,
  }) {
    return ChartState(
      measurementType: measurementType ?? this.measurementType,
      chartDataType: chartDataType ?? this.chartDataType,
      hourly: hourly ?? this.hourly,
      daily: daily ?? this.daily,
      monthly: monthly ?? this.monthly,
    );
  }
}
