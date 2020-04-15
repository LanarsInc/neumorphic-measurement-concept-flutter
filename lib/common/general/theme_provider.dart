import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider {
  static const String app_font_family = "Rubik";

  static const Color light_grey = Color(0xFFECF0F3);
  static const Color grey = Color(0xFFE3E6EC);
  static const Color navy_grey = Color(0xFF8992A6);
  static const Color dark_grey = Color(0xFF6C7079);

  static const Color light_red = Color(0xFFFF96A2);
  static const Color red = Color(0xFFFF6073);
  static const Color dark_red = Color(0xFFE75668);

  static ThemeData get() {
    const TextStyle basicTextStyle = TextStyle(fontFamily: app_font_family, fontWeight: FontWeight.w500);

    return ThemeData(
      accentColor: red,
      primaryColor: dark_grey,
      backgroundColor: light_grey,
      scaffoldBackgroundColor: light_grey,
      fontFamily: app_font_family,
      cursorColor: red,
      textSelectionHandleColor: red,
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: Colors.red,
      ),
      ///////////////////////////////////////////////
      /////////////////Font Style////////////////////
      ///////////////////////////////////////////////
      textTheme: TextTheme(
        title: basicTextStyle.copyWith(
          color: navy_grey,
          fontSize: 34,
          fontStyle: FontStyle.normal,
        ),
        subtitle: basicTextStyle.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: navy_grey,
        ),
        body1: basicTextStyle.copyWith(
          fontSize: 16,
          color: dark_grey,
        ),
        body2: basicTextStyle.copyWith(
          fontSize: 14,
          color: navy_grey,
        ),
      ),
      ///////////////////////////////////////////////
      /////////////////Button style//////////////////
      ///////////////////////////////////////////////
      buttonTheme: ButtonThemeData(
        height: 64,
        buttonColor: red,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
        ),
      ),
    );
  }
}
