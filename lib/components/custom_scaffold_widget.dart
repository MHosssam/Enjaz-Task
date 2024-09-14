import 'package:enjaz/app_config/image_name.dart';
import 'package:enjaz/helpers/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScaffoldWidget extends StatelessWidget {
  final Widget body;

  const ScaffoldWidget({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Styles.primaryColor.withOpacity(0.95),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 60),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(ImageName.splashBg), fit: BoxFit.fill),
          ),
          child: body,
        ),
      ),
    );
  }
}
