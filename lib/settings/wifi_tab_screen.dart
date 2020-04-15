import 'package:flutter/material.dart';
import 'package:neumorphicmeasurementconcept/common/general/ln_airbox_icons.dart';
import 'package:neumorphicmeasurementconcept/common/general/theme_provider.dart';
import 'package:neumorphicmeasurementconcept/common/ui/bulged_in_widget.dart';
import 'package:neumorphicmeasurementconcept/common/ui/neumorphic_container.dart';
import 'package:neumorphicmeasurementconcept/settings/tab_interface.dart';
import 'package:neumorphicmeasurementconcept/settings/widget/label_widget.dart';
import 'package:neumorphicmeasurementconcept/settings/widget/text_input_widget.dart';

import 'widget/button_widget.dart';

class WifiTab extends TabInterface {
  WifiTab(String titleName) : super(titleName);

  @override
  _WifiTabState createState() => _WifiTabState();
}

class _WifiTabState extends State<WifiTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final passwordTextController = TextEditingController();

  final passwordKey = GlobalKey<TextInputState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Label(labelText: 'Available networks'),
              GestureDetector(
                child: NeumorphicContainer(
                  bevel: 16,
                  color: ThemeProvider.light_grey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: ThemeProvider.grey,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Select network',
                          style: theme.textTheme.body1,
                        ),
                        const SizedBox(width: 8),
                        BulgedInWidget(
                          width: 32,
                          height: 32,
                          color: ThemeProvider.light_grey,
                          direction: GradientDirection.fromTopLeftToBottomRight,
                          child: Icon(
                            LnAirboxIcons.ic_chevron_down,
                            color: ThemeProvider.navy_grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {},
              ),
              const SizedBox(height: 24),
              TextInput(
                key: passwordKey,
                controller: passwordTextController,
                labelText: 'Password',
                textInputType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 24),
              Label(labelText: 'Connected to:'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Network not connected',
                  style: theme.textTheme.body1,
                ),
              ),
            ],
          ),
          Button.text(
            labelText: 'Connect',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
