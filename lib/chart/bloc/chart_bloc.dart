import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:neumorphicmeasurementconcept/common/general/state/app_state.dart';
import 'package:neumorphicmeasurementconcept/common/measurement_type.dart';
import 'package:rebloc/rebloc.dart';

class GetMeasurementDataAction extends Action {
  final MeasurementType measurementType;

  GetMeasurementDataAction(this.measurementType);
}

class SaveMeasurementDataAction extends Action {
  final List<FlSpot> hourly;
  final List<FlSpot> daily;
  final List<FlSpot> monthly;

  SaveMeasurementDataAction(this.hourly, this.daily, this.monthly);
}

class ChartBloc extends SimpleBloc<AppState> {
  @override
  FutureOr<Action> middleware(DispatchFunction dispatcher, AppState state, Action action) async {
    switch (action.runtimeType) {
      case GetMeasurementDataAction:
        final actualAction = action as GetMeasurementDataAction;
        if (actualAction.measurementType == MeasurementType.temperature || actualAction.measurementType == MeasurementType.humidity) {
          dispatcher(StubbedTemperatureAction());
        } else if (actualAction.measurementType == MeasurementType.co2 || actualAction.measurementType == MeasurementType.pressure) {
          dispatcher(StubbedCo2Action());
        }

        break;
    }
    return action;
  }

  @override
  AppState reducer(AppState state, Action action) {
    switch (action.runtimeType) {
      case GetMeasurementDataAction:
        return state.copyWith(
          chartState: state.chartState.copyWith(
            measurementType: (action as GetMeasurementDataAction).measurementType,
          ),
        );
      case SaveMeasurementDataAction:
      case StubbedCo2Action:
      case StubbedTemperatureAction:
        return state.copyWith(
          chartState: state.chartState.copyWith(
            hourly: (action as SaveMeasurementDataAction).hourly,
            daily: (action as SaveMeasurementDataAction).daily,
            monthly: (action as SaveMeasurementDataAction).monthly,
          ),
        );

      default:
        return state;
    }
  }
}

//TODO delete on real data
class StubbedTemperatureAction extends SaveMeasurementDataAction {
  StubbedTemperatureAction()
      : super(
          [
            FlSpot(1, 14),
            FlSpot(5, 18),
            FlSpot(10, 22),
            FlSpot(15, 35),
            FlSpot(20, 25),
            FlSpot(25, 20),
            FlSpot(30, 18),
            FlSpot(35, 16),
            FlSpot(40, 14),
            FlSpot(45, 16),
            FlSpot(50, 18),
            FlSpot(55, 20),
            FlSpot(60, 35),
          ],
          [
            FlSpot(1, 5),
            FlSpot(3, 10),
            FlSpot(5, 15),
            FlSpot(7, 34),
            FlSpot(9, 20),
            FlSpot(11, 22),
            FlSpot(13, 18),
            FlSpot(15, 25),
            FlSpot(17, 20),
            FlSpot(19, 19),
            FlSpot(21, 14),
            FlSpot(23, 15),
          ],
          [
            FlSpot(1, 5),
            FlSpot(3, 20),
            FlSpot(5, 15),
            FlSpot(7, 16),
            FlSpot(9, 20),
            FlSpot(11, 22),
            FlSpot(13, 23),
            FlSpot(15, 35),
            FlSpot(17, 23),
            FlSpot(19, 22),
            FlSpot(21, 20),
            FlSpot(23, 16),
            FlSpot(25, 15),
            FlSpot(27, 10),
            FlSpot(29, 5),
            FlSpot(31, 7),
          ],
        );
}

class StubbedCo2Action extends SaveMeasurementDataAction {
  StubbedCo2Action()
      : super(
          [
            FlSpot(1, 400),
            FlSpot(5, 700),
            FlSpot(10, 1700),
            FlSpot(15, 2200),
            FlSpot(20, 2000),
            FlSpot(25, 2000),
            FlSpot(30, 1000),
            FlSpot(35, 500),
            FlSpot(40, 250),
            FlSpot(45, 900),
            FlSpot(50, 900),
            FlSpot(55, 950),
            FlSpot(60, 700),
          ],
          [
            FlSpot(1, 500),
            FlSpot(3, 1500),
            FlSpot(9, 700),
            FlSpot(11, 2200),
            FlSpot(13, 2000),
            FlSpot(15, 1200),
            FlSpot(17, 1250),
            FlSpot(19, 1200),
            FlSpot(21, 1250),
            FlSpot(23, 1300),
          ],
          [
            FlSpot(1, 250),
            FlSpot(3, 300),
            FlSpot(5, 400),
            FlSpot(7, 600),
            FlSpot(9, 1000),
            FlSpot(11, 1500),
            FlSpot(13, 1450),
            FlSpot(15, 1550),
            FlSpot(19, 400),
            FlSpot(21, 450),
            FlSpot(23, 900),
            FlSpot(25, 500),
            FlSpot(29, 500),
            FlSpot(31, 250),
          ],
        );
}
