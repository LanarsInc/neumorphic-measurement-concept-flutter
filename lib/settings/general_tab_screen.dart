import 'package:flutter/material.dart';
import 'package:neumorphicmeasurementconcept/settings/tab_interface.dart';
import 'package:neumorphicmeasurementconcept/settings/widget/text_input_widget.dart';

import 'widget/button_widget.dart';

class GeneralTab extends TabInterface {
  GeneralTab(String titleName) : super(titleName);

  @override
  _GeneralTabState createState() => _GeneralTabState();
}

class _GeneralTabState extends State<GeneralTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final deviceNameTextController = TextEditingController();

  final deviceNameKey = GlobalKey<TextInputState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        children: <Widget>[
          TextInput(
            key: deviceNameKey,
            controller: deviceNameTextController,
            labelText: 'Device name',
          ),
          Button.text(
            labelText: 'Save',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
