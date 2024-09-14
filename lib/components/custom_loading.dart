import 'package:enjaz/helpers/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoading {
  static showLoadingView() {
    return const Center(child: SpinKitDoubleBounce(color: Styles.primaryColor, size: 40));
  }
}
