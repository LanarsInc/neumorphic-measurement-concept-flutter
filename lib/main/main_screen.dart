import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neumorphicmeasurementconcept/chart/bloc/chart_bloc.dart';
import 'package:neumorphicmeasurementconcept/chart/chart_screen.dart';
import 'package:neumorphicmeasurementconcept/common/general/ln_airbox_icons.dart';
import 'package:neumorphicmeasurementconcept/common/general/state/app_state.dart';
import 'package:neumorphicmeasurementconcept/common/general/theme_provider.dart';
import 'package:neumorphicmeasurementconcept/common/measurement_type.dart';
import 'package:neumorphicmeasurementconcept/common/navigation/base_navigation_screen.dart';
import 'package:neumorphicmeasurementconcept/common/navigation/bloc/navigation_bloc.dart';
import 'package:neumorphicmeasurementconcept/common/ui/bulged_in_widget.dart';
import 'package:neumorphicmeasurementconcept/common/ui/full_screen_single_child_scroll_view.dart';
import 'package:neumorphicmeasurementconcept/common/ui/neumorphic_container.dart';
import 'package:neumorphicmeasurementconcept/common/ui/non_overscroll_widget.dart';
import 'package:neumorphicmeasurementconcept/common/util/extensions.dart';
import 'package:neumorphicmeasurementconcept/main/ui/measurement_container.dart';
import 'package:neumorphicmeasurementconcept/settings/settings_screen.dart';
import 'package:neumorphicmeasurementconcept/settings/widget/button_widget.dart';
import 'package:rebloc/rebloc.dart';

class MainScreen extends BaseNavigationStatefulScreen {
  MainScreen({Key key}) : super(key: key, routeName: '/main_screeen');

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NonOverscrollWidget(
          child: FullScreenSingleChildScrollView(
            context: context,
            child: Container(
              padding: EdgeInsets.only(bottom: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 64),
                      SearchBar(),
                      DeviceListView(),
                    ],
                  ),
                  MeasurementGridView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Text(
              'Devices',
              style: theme.textTheme.title,
            ),
          ),
          Button.icon(
            icon: LnAirboxIcons.ic_search,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class DeviceListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const SizedBox(width: 24),
            ...mapIndexed(
              ['Sensor-11111', 'Sensor-22222', 'Sensor-33333'],
              builder: (index, device) {
                return NeumorphicContainer(
                  bevel: 16,
                  color: ThemeProvider.light_grey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: ThemeProvider.grey,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          device,
                          style: theme.textTheme.body1,
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          child: BulgedInWidget(
                            width: 32,
                            height: 32,
                            color: ThemeProvider.light_grey,
                            direction: GradientDirection.fromTopLeftToBottomRight,
                            child: Icon(
                              LnAirboxIcons.more_horiz,
                              color: ThemeProvider.navy_grey,
                            ),
                          ),
                          onTap: () => StoreProvider.of<AppState>(context).dispatch(PushNamedRouteAction(SettingsScreen())),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separator: const SizedBox(width: 16),
            ),
            const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }
}

class MeasurementGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double gridSpacing = 24;
    final spacingRespectedHalfScreenWidth = (MediaQuery.of(context).size.width - gridSpacing * 3) / 2;
    return Column(
      children: <Widget>[
        SizedBox(height: gridSpacing),
        Row(
          children: <Widget>[
            SizedBox(width: gridSpacing),
            Expanded(
              child: GestureDetector(
                onTap: () => _handleMeasurementClickEvent(context, MeasurementType.co2),
                child: NeumorphicContainer(
                  bevel: 24,
                  color: ThemeProvider.light_grey,
                  child: Measurement(
                    width: spacingRespectedHalfScreenWidth,
                    height: spacingRespectedHalfScreenWidth,
                    icon: LnAirboxIcons.ic_co2,
                    value: 1184,
                    title: "CO2",
                    unit: MeasurementType.co2.unit,
                  ),
                ),
              ),
            ),
            SizedBox(width: gridSpacing),
            Expanded(
              child: GestureDetector(
                onTap: () => _handleMeasurementClickEvent(context, MeasurementType.temperature),
                child: NeumorphicContainer(
                  bevel: 24,
                  color: ThemeProvider.light_grey,
                  child: Measurement(
                    width: spacingRespectedHalfScreenWidth,
                    height: spacingRespectedHalfScreenWidth,
                    icon: LnAirboxIcons.ic_temperature,
                    value: 25.43,
                    title: "Temperature",
                    unit: MeasurementType.temperature.unit,
                  ),
                ),
              ),
            ),
            SizedBox(width: gridSpacing),
          ],
        ),
        SizedBox(height: gridSpacing),
        Row(
          children: <Widget>[
            SizedBox(width: gridSpacing),
            Expanded(
              child: GestureDetector(
                onTap: () => _handleMeasurementClickEvent(context, MeasurementType.humidity),
                child: NeumorphicContainer(
                  bevel: 24,
                  color: ThemeProvider.light_grey,
                  child: Measurement(
                    width: spacingRespectedHalfScreenWidth,
                    height: spacingRespectedHalfScreenWidth,
                    icon: LnAirboxIcons.ic_humidity,
                    value: 26.93,
                    title: "Humidity",
                    unit: MeasurementType.humidity.unit,
                  ),
                ),
              ),
            ),
            SizedBox(width: gridSpacing),
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: NeumorphicContainer(
                  bevel: 24,
                  color: ThemeProvider.light_grey,
                  child: Measurement(
                    width: spacingRespectedHalfScreenWidth,
                    height: spacingRespectedHalfScreenWidth,
                    icon: LnAirboxIcons.ic_pressure,
                    value: 99.99,
                    title: "Pressure",
                    unit: MeasurementType.pressure.unit,
                  ),
                ),
              ),
            ),
            SizedBox(width: gridSpacing),
          ],
        ),
        SizedBox(height: gridSpacing),
      ],
    );
  }

  void _handleMeasurementClickEvent(BuildContext context, MeasurementType measurementType) {
    StoreProvider.of<AppState>(context).dispatch(GetMeasurementDataAction(measurementType));
    StoreProvider.of<AppState>(context).dispatch(PushNamedRouteAction(ChartScreen(measurementType: measurementType)));
  }
}
