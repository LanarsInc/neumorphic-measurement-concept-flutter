import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neumorphicmeasurementconcept/common/general/ln_airbox_icons.dart';
import 'package:neumorphicmeasurementconcept/common/general/state/app_state.dart';
import 'package:neumorphicmeasurementconcept/common/general/theme_provider.dart';
import 'package:neumorphicmeasurementconcept/common/navigation/base_navigation_screen.dart';
import 'package:neumorphicmeasurementconcept/common/navigation/bloc/navigation_bloc.dart';
import 'package:neumorphicmeasurementconcept/common/ui/bulged_in_widget.dart';
import 'package:neumorphicmeasurementconcept/common/ui/clear_focus_container.dart';
import 'package:neumorphicmeasurementconcept/common/ui/tab_indicator.dart';
import 'package:neumorphicmeasurementconcept/settings/server_tab_screen.dart';
import 'package:neumorphicmeasurementconcept/settings/tab_interface.dart';
import 'package:rebloc/rebloc.dart';

import 'general_tab_screen.dart';
import 'wifi_tab_screen.dart';

class SettingsScreen extends BaseNavigationStatefulScreen {
  SettingsScreen({Key key}) : super(key: key, routeName: '/settings_screen');

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    _controller = TabController(initialIndex: 0, length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<TabInterface> tabs = [
      GeneralTab('General'),
      WifiTab('Wifi'),
      ServerTab('Server'),
    ];

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
                      'Settings',
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
                child: TabBarView(
                  controller: _controller,
                  children: tabs,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
