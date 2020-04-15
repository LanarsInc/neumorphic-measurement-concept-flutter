import 'package:flutter/material.dart';
import 'package:neumorphicmeasurementconcept/common/general/theme_provider.dart';
import 'package:neumorphicmeasurementconcept/common/ui/bulged_in_widget.dart';


class Measurement extends StatelessWidget {
  final double width;
  final double height;
  final IconData icon;
  final double value;
  final String title;
  final String unit;

  Measurement({
    this.width,
    this.height,
    @required this.icon,
    @required this.value,
    @required this.title,
    @required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isValueWhole = value % 1 == 0;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: ThemeProvider.grey,
      ),
      padding: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            BulgedInWidget(
              color: ThemeProvider.light_grey,
              child: Icon(
                icon,
                color: ThemeProvider.navy_grey,
              ),
              direction: GradientDirection.fromTopLeftToBottomRight,
            ),
            ListTile(
              title: Text(
                isValueWhole ? value.toInt().toString() : value.toString(),
                style: theme.textTheme.title.copyWith(
                  color: theme.primaryColor,
                ),
              ),
              subtitle: Row(
                children: <Widget>[
                  Text(
                    title,
                    style: theme.textTheme.body2,
                  ),
                  Text(
                    " $unit",
                    style: theme.textTheme.body2.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.all(0),
            ),
          ],
        ),
      ),
    );
  }
}
