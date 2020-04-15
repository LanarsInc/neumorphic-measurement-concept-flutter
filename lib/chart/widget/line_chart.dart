import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:neumorphicmeasurementconcept/chart/model/chart_data_type.dart';
import 'package:neumorphicmeasurementconcept/chart/model/chart_view_model.dart';
import 'package:neumorphicmeasurementconcept/common/general/theme_provider.dart';
import 'package:neumorphicmeasurementconcept/common/measurement_type.dart';
import 'package:neumorphicmeasurementconcept/common/util/extensions.dart';

class Chart extends StatefulWidget {
  final MeasurementType measurementType;
  final ChartViewModel viewModel;

  Chart({
    Key key,
    @required this.measurementType,
    this.viewModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChartState();
}

class ChartState extends State<Chart> {
  ChartDataType _chartDataType;

  @override
  void initState() {
    _chartDataType = ChartDataType.hour;
    super.initState();
  }

  void changeChartData(int index) {
    setState(() {
      switch (index) {
        case 0:
          _chartDataType = ChartDataType.hour;
          break;
        case 1:
          _chartDataType = ChartDataType.day;
          break;
        case 2:
          _chartDataType = ChartDataType.month;
          break;
        default:
          _chartDataType = ChartDataType.hour;
          break;
      }
    });
  }

  int _getMultiplicityByAxeY(MeasurementType measurementType) {
    switch (measurementType) {
      case MeasurementType.co2:
        return 250;
      case MeasurementType.temperature:
        return 5;
      case MeasurementType.pressure:
        return 1;
      case MeasurementType.humidity:
        return 10;
      default:
        return 1;
    }
  }

  int _getMultiplicityByAxeX(ChartDataType chartDataType) {
    switch (chartDataType) {
      case ChartDataType.hour:
        return 10;
      case ChartDataType.day:
      case ChartDataType.month:
        return 4;
      default:
        return 1;
    }
  }

  double _getMaxY() {
    switch (widget.measurementType) {
      case MeasurementType.co2:
        return 2500;
      case MeasurementType.temperature:
        return 50;
      case MeasurementType.pressure:
        return 105;
      case MeasurementType.humidity:
        return 100;
      default:
        return -1;
    }
  }

  double _getMinY() {
    switch (widget.measurementType) {
      case MeasurementType.pressure:
        return 94;
      case MeasurementType.temperature:
      case MeasurementType.humidity:
      case MeasurementType.co2:
        return 0;
      default:
        return -1;
    }
  }

  double _getMaxX() {
    switch (_chartDataType) {
      case ChartDataType.hour:
        return 60;
      case ChartDataType.day:
        return 24;
      case ChartDataType.month:
        return 31;
      default:
        return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 32),
              child: LineChart(
                data(theme, _chartDataType, widget.viewModel.getData(_chartDataType)),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  LineChartData data(ThemeData theme, ChartDataType chartDataType, List<FlSpot> spots) {
    return LineChartData(
      backgroundColor: ThemeProvider.light_grey,
      lineTouchData: LineTouchData(
        handleBuiltInTouches: true,
        getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((spot) {
            FlLine line = FlLine(color: Colors.transparent);
            FlDotData dot = FlDotData(
                getStrokeColor: (spot, percent, barData) => ThemeProvider.grey,
                getDotColor: (spot, percent, barData) => ThemeProvider.dark_red,
                strokeWidth: 4,
                dotSize: 4);

            return TouchedSpotIndicatorData(line, dot);
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: 8,
            tooltipPadding: EdgeInsets.all(8),
            tooltipBgColor: ThemeProvider.grey,
            getTooltipItems: (List<LineBarSpot> spots) {
              return spots.map((spot) {
                return LineTooltipItem(
                  spot.y.toInt().toString(),
                  theme.textTheme.subtitle.copyWith(
                    color: ThemeProvider.dark_red,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }).toList();
            }),
      ),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.white,
          strokeWidth: 2,
        ),
        checkToShowHorizontalLine: (value) {
          return value.toInt() % _getMultiplicityByAxeY(widget.measurementType) == 0;
        },
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: theme.textTheme.subtitle.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          margin: 10,
          getTitles: (value) {
            if (value.toInt() % _getMultiplicityByAxeX(chartDataType) == 0) {
              return value.toInt().toString();
            } else {
              return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: theme.textTheme.subtitle.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          margin: 8,
          reservedSize: 30,
          getTitles: (value) {
            if (value.toInt() % _getMultiplicityByAxeY(widget.measurementType) == 0) {
              return value.toInt().toString();
            } else {
              return '';
            }
          },
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            style: BorderStyle.solid,
            color: ThemeProvider.navy_grey,
            width: 4,
          ),
          left: BorderSide(
            color: ThemeProvider.navy_grey,
            width: 4,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.white,
            width: 4,
          ),
        ),
      ),
      minX: 0,
      maxX: _getMaxX(),
      maxY: _getMaxY(),
      minY: _getMinY(),
      lineBarsData: lineBarData(spots),
    );
  }

  List<LineChartBarData> lineBarData(List<FlSpot> spots) {
    double maximum = spots.map((e) => e.y).reduce(max);

    return [
      LineChartBarData(
        spots: spots,
        isStrokeCapRound: true,
        isCurved: true,
        curveSmoothness: 0.34,
        barWidth: 6,
        colors: _buildColors(spots, maximum),
        colorStops: _buildStops(spots, maximum),
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
      ),
    ];
  }

  List<Color> _buildColors(List<FlSpot> spots, double maximum) {
    final colors = List<Color>();
    mapIndexed(
      spots,
      builder: (index, spot) {
        if (spot.y == maximum) {
          colors.add(ThemeProvider.light_red);
          colors.add(ThemeProvider.dark_red);
          colors.add(ThemeProvider.light_red);
        }
      },
    );
    return colors;
  }

  List<double> _buildStops(List<FlSpot> spots, double maximum) {
    final stops = List<double>();
    mapIndexed(
      spots,
      builder: (index, spot) {
        if (spot.y == maximum) {
          final stop = spot.x / _getMaxX();
          stops.add((spot.x - _getMaxX() / 100 * 10) / _getMaxX());
          stops.add(stop);
          stops.add((spot.x + _getMaxX() / 100 * 10) / _getMaxX());
        }
      },
    );
    return stops;
  }
}
