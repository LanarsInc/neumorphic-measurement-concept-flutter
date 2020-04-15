import 'package:flutter/material.dart';
import 'package:neumorphicmeasurementconcept/settings/tab_interface.dart';
import 'package:neumorphicmeasurementconcept/settings/widget/text_input_widget.dart';

class ChartTab extends TabInterface {
  ChartTab(String titleName) : super(titleName);

  @override
  _ChartTabState createState() => _ChartTabState();
}

class _ChartTabState extends State<ChartTab> {
  final deviceNameTextController = TextEditingController();

  final deviceNameKey = GlobalKey<TextInputState>();

  @override
  Widget build(BuildContext context) => Container();
}
