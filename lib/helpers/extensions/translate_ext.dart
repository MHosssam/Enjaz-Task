import 'package:enjaz/helpers/translation/set_localization.dart';
import 'package:enjaz/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';

// extension Translate on String {
//   String translate() => tr(Go.navigatorKey.currentContext!, this);
// }

extension TranslateString on String {
  String tr({BuildContext? context}) {
    return SetLocalization.of(context ?? CustomNavigator.navigatorState.currentContext!)!
        .getTranslateValue(this);
  }
}
