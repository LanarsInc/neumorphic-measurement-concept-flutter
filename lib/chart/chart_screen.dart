import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neumorphicmeasurementconcept/chart/widget/line_chart.dart';
import 'package:neumorphicmeasurementconcept/common/general/ln_airbox_icons.dart';
import 'package:neumorphicmeasurementconcept/common/general/state/app_state.dart';
import 'package:neumorphicmeasurementconcept/common/general/theme_provider.dart';
import 'package:neumorphicmeasurementconcept/common/measurement_type.dart';
import 'package:neumorphicmeasurementconcept/common/navigation/base_navigation_screen.dart';
import 'package:neumorphicmeasurementconcept/common/navigation/bloc/navigation_bloc.dart';
import 'package:neumorphicmeasurementconcept/common/ui/bulged_in_widget.dart';
import 'package:neumorphicmeasurementconcept/common/ui/clear_focus_container.dart';
import 'package:neumorphicmeasurementconcept/common/ui/tab_indicator.dart';
import 'package:neumorphicmeasurementconcept/settings/tab_interface.dart';
import 'package:rebloc/rebloc.dart';

import 'chart_tab.dart';
import 'model/chart_view_model.dart';

class ChartScreen extends BaseNavigationStatefulScreen {
  final MeasurementType measurementType;

  ChartScreen({
    Key key,
    @required this.measurementType,
  }) : super(key: key, routeName: '/chart_screen');

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> with TickerProviderStateMixin {
  TabController _controller;
  VoidCallback _controllerListener;
  final chartStateKey = GlobalKey<ChartState>();
  int _index;

  @override
  void initState() {
    super.initState();
    _index = 0;
    _controller = TabController(initialIndex: 0, length: 3, vsync: this);

    _controllerListener = () {
      setState(() {
        _index = _controller.index;
        chartStateKey.currentState.changeChartData(_index);
      });
    };
    _controller.addListener(_controllerListener);
  }

  @override
  void dispose() async {
    super.dispose();
    _controller.removeListener(_controllerListener);
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<TabInterface> tabs = [
      ChartTab('Hour'),
      ChartTab('Day'),
      ChartTab('Month'),
    ];

    String _title;
    switch (widget.measurementType) {
      case MeasurementType.co2:
        _title = 'CO2 ${widget.measurementType.unit}';
        break;
      case MeasurementType.temperature:
        _title = 'Temperature ${widget.measurementType.unit}';
        break;
      case MeasurementType.pressure:
        _title = 'Pressure ${widget.measurementType.unit}';
        break;
      case MeasurementType.humidity:
        _title = 'Humidity ${widget.measurementType.unit}';
        break;
      default:
        _title = '';
        break;
    }

    return Scaffold(
      body: SafeArea(
        child: ClearFocusContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 8),
                    GestureDetector(
                      child: BulgedInWidget(
                        width: 32,
                        height: 32,
                        color: ThemeProvider.grey,
                        child: Icon(LnAirboxIcons.ic_chevron_left),
                        direction: GradientDirection.fromTopLeftToBottomRight,
                      ),
                      onTap: () => StoreProvider.of<AppState>(context).dispatch(PopRouteAction()),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _title,
                      style: theme.textTheme.title,
                    ),
                    const SizedBox(height: 8),
                    BulgedInWidget(
                      width: double.infinity,
                      height: 48,
                      cornerRadius: 16,
                      borderWidth: 2,
                      color: ThemeProvider.grey,
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BubbleTabIndicator(
                          indicatorHeight: 48,
                          indicatorColor: ThemeProvider.grey,
                          tabBarIndicatorSize: TabBarIndicatorSize.tab,
                        ),
                        labelPadding: EdgeInsets.all(0),
                        controller: _controller,
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.black,
                        tabs: List.generate(
                          tabs.length,
                          (index) {
                            return Container(
                              child: Center(
                                child: Text(
                                  tabs[index].titleName,
                                  style: theme.textTheme.body1,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _controller,
                      children: tabs,
                    ),
                    ViewModelSubscriber<AppState, ChartViewModel>(
                      converter: (state) => ChartViewModel.fromAppState(state),
                      builder: (context, dispatcher, viewModel) {
                        if (viewModel.isEmpty()) return Container();

                        return Chart(
                          key: chartStateKey,
                          measurementType: widget.measurementType,
                          viewModel: viewModel,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
