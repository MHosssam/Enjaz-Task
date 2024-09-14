import 'dart:async';

import 'package:enjaz/app_config/image_name.dart';
import 'package:enjaz/components/custom_scaffold_widget.dart';
import 'package:enjaz/components/my_text.dart';
import 'package:enjaz/core/app_event.dart';
import 'package:enjaz/helpers/styles.dart';
import 'package:enjaz/helpers/translation/localization_methods.dart';
import 'package:flutter/material.dart';

import 'splash_bloc.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer timer;
  bool showText = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => showText = true);
      }
    });
    timer = Timer.periodic(const Duration(milliseconds: 1500), (Timer t) => _controller.forward());

    Timer(const Duration(seconds: 4), () => SplashBloc.instance.add(Click()));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // _timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImageName.logo, height: 150),
                if (showText) ...[
                  MyText(
                    title: tr("missionDone"),
                    size: 20,
                    color: Styles.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                  MyText(
                    title: tr("restUp"),
                    size: 20,
                    color: Styles.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ],
            ),
          ),
          RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
            child: Image.asset(ImageName.clock, height: 30),
          ),
          const SizedBox(height: 5),
          MyText(title: tr("splashDes"), color: Styles.whiteColor),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
