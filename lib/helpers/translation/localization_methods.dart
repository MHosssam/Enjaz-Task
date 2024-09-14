import 'package:enjaz/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';

import 'set_localization.dart';

String tr(String key, {BuildContext? context}) {
  return SetLocalization.of(context ?? CustomNavigator.navigatorState.currentContext!)
          ?.getTranslateValue(key) ??
      "";
}
