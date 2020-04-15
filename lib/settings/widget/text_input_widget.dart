import 'package:flutter/material.dart';
import 'package:neumorphicmeasurementconcept/common/general/ln_airbox_icons.dart';
import 'package:neumorphicmeasurementconcept/common/general/theme_provider.dart';
import 'package:neumorphicmeasurementconcept/common/ui/bulged_in_widget.dart';

import 'label_widget.dart';

class TextInput extends StatefulWidget {
  final TextEditingController controller;

  final String labelText;
  final String hintText;
  final TextInputType textInputType;

  TextInput({
    Key key,
    this.controller,
    @required this.labelText,
    this.hintText,
    this.textInputType,
  }) : super(key: key);

  @override
  TextInputState createState() => TextInputState();
}

class TextInputState extends State<TextInput> {
  ThemeData theme;
  bool _obscureText = false;
  bool _isPasswordTypedInput = false;
  bool _isErrorEnabled = false;

  final _labelKey = GlobalKey<LabelState>();

  _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  error(bool isOn) {
    if (isOn == _isErrorEnabled) return;
    setState(() {
      _isErrorEnabled = isOn;
      _labelKey.currentState.error(isOn);
    });
  }

  @override
  void initState() {
    _isPasswordTypedInput = widget.textInputType == TextInputType.visiblePassword;
    _obscureText = _isPasswordTypedInput;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);

    final errorDecoration = _isErrorEnabled
        ? BoxDecoration(
            border: Border.all(
              width: 2,
              color: theme.accentColor,
            ),
            borderRadius: BorderRadius.circular(16),
          )
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Label(
          key: _labelKey,
          labelText: widget.labelText,
        ),
        Stack(
          children: <Widget>[
            BulgedInWidget(
              width: double.infinity,
              height: 48,
              cornerRadius: 16,
              borderWidth: 2,
              color: ThemeProvider.grey,
              child: TextFormField(
                controller: widget.controller,
                keyboardType: widget.textInputType,
                obscureText: _obscureText,
                style: _isErrorEnabled ? theme.textTheme.body1.copyWith(color: theme.accentColor) : theme.textTheme.body1,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: theme.textTheme.body1.copyWith(color: ThemeProvider.navy_grey),
                  border: InputBorder.none,
                  prefix: const SizedBox(width: 16),
                  suffix: const SizedBox(width: 16),
                  suffixIcon: Visibility(
                    visible: _isPasswordTypedInput,
                    child: GestureDetector(
                      child: Container(
                        child: Icon(
                          _obscureText ? LnAirboxIcons.ic_eye_invisible : LnAirboxIcons.ic_eye_visible,
                          size: 32,
                        ),
                      ),
                      onTap: _toggleObscureText,
                    ),
                  ),
                ),
              ),
            ),
            IgnorePointer(
              ignoring: true,
              child: Container(
                height: 52,
                decoration: errorDecoration,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
