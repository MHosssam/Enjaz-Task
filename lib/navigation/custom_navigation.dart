import 'dart:developer';

import 'package:enjaz/features/login/pages/login_view.dart';
import 'package:enjaz/features/register/page/register_page.dart';
import 'package:enjaz/features/splash/splash.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'routes.dart';

const begin = Offset(0.0, 1.0);
const end = Offset.zero;
const curve = Curves.bounceInOut;
var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

abstract class CustomNavigator {
  static final GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldState = GlobalKey<ScaffoldMessengerState>();

  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    log('Routes => ${settings.name}');

    PageRouteBuilder<dynamic> pageRoute(Widget widget) => PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(position: animation.drive(tween), child: child);
          },
        );
    switch (settings.name) {
      case Routes.app:
        return pageRoute(const MyApp());
      case Routes.splash:
        return pageRoute(const Splash());
      case Routes.login:
        return pageRoute(const LoginView());
      case Routes.register:
        return pageRoute(const RegisterPage());

      default:
        return MaterialPageRoute(builder: (_) => const MyApp());
    }
  }

  static pop({dynamic result}) {
    if (navigatorState.currentState!.canPop()) {
      navigatorState.currentState!.pop(result);
    }
  }

  static Future<dynamic> push(
    String routeName, {
    arguments,
    bool replace = false,
    bool clean = false,
  }) {
    if (clean) {
      return navigatorState.currentState!
          .pushNamedAndRemoveUntil(routeName, (_) => false, arguments: arguments);
    } else if (replace) {
      return navigatorState.currentState!.pushReplacementNamed(routeName, arguments: arguments);
    } else {
      return navigatorState.currentState!.pushNamed(routeName, arguments: arguments);
    }
  }

  static Future<dynamic> pushView({
    required Widget page,
    required BuildContext context,
    bool replace = false,
    bool clean = false,
  }) {
    if (clean) {
      return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => page),
        (route) => false,
      );
    } else if (replace) {
      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
    } else {
      return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    }
  }
}
