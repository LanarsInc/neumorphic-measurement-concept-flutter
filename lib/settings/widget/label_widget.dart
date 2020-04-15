import 'package:flutter/material.dart';

class Label extends StatefulWidget {
  final String labelText;

  Label({Key key, @required this.labelText}) : super(key: key);

  @override
  LabelState createState() => LabelState();
}

class LabelState extends State<Label> {
  ThemeData theme;
  bool _isErrorEnabled = false;

  error(bool isOn) {
    if (isOn == _isErrorEnabled) return;
    setState(() {
      _isErrorEnabled = isOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    final style = _isErrorEnabled ? theme.textTheme.subtitle.copyWith(color: theme.accentColor) : theme.textTheme.subtitle;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Text(
        widget.labelText,
        style: style,
      ),
    );
  }
}
