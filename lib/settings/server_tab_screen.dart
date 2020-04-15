import 'package:flutter/material.dart';
import 'package:neumorphicmeasurementconcept/common/ui/non_overscroll_widget.dart';
import 'package:neumorphicmeasurementconcept/settings/tab_interface.dart';
import 'package:neumorphicmeasurementconcept/settings/widget/text_input_widget.dart';

import 'widget/button_widget.dart';

class ServerTab extends TabInterface {
  ServerTab(String titleName) : super(titleName);

  @override
  _ServerTabState createState() => _ServerTabState();
}

class _ServerTabState extends State<ServerTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final serverTextController = TextEditingController();

  final portTextController = TextEditingController();

  final usernameTextController = TextEditingController();

  final pathTextController = TextEditingController();

  final passwordTextController = TextEditingController();

  final serverKey = GlobalKey<TextInputState>();

  final portKey = GlobalKey<TextInputState>();

  final usernameKey = GlobalKey<TextInputState>();

  final pathKey = GlobalKey<TextInputState>();

  final passwordKey = GlobalKey<TextInputState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        children: <Widget>[
          NonOverscrollWidget(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextInput(
                    key: serverKey,
                    controller: serverTextController,
                    labelText: 'Server',
                    hintText: 'Enter server',
                  ),
                  const SizedBox(height: 24),
                  TextInput(
                    key: portKey,
                    controller: portTextController,
                    labelText: 'Port',
                    hintText: 'Enter port name',
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(height: 24),
                  TextInput(
                    key: usernameKey,
                    controller: usernameTextController,
                    labelText: 'Username',
                    hintText: 'Enter username',
                  ),
                  const SizedBox(height: 24),
                  TextInput(
                    key: passwordKey,
                    controller: passwordTextController,
                    labelText: 'Password',
                    hintText: 'Enter password',
                    textInputType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 24),
                  TextInput(
                    key: pathKey,
                    controller: pathTextController,
                    labelText: 'Path',
                    hintText: 'Enter path',
                  ),
                  const SizedBox(height: 140),
                ],
              ),
            ),
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
