import 'package:flutter/material.dart';

abstract class TabInterface extends StatefulWidget {
  final String _titleName;

  TabInterface(this._titleName);

  String get titleName => _titleName;
}
