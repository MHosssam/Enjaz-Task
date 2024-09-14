import 'package:enjaz/helpers/styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppCore {
  static AppCore? _instance;

  AppCore._initial();

  factory AppCore() {
    _instance ??= AppCore._initial();
    return _instance!;
  }

  void showSimpleToast(
    String msg, {
    Color? backgroundColor,
    Color? textColor,
    ToastGravity? gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      fontSize: 16.0,
      gravity: gravity,
      toastLength: Toast.LENGTH_LONG,
      textColor: textColor ?? Colors.white,
      backgroundColor: backgroundColor ?? Styles.redColor,
    );
  }
}
