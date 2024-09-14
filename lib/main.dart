import 'dart:developer';

import 'package:enjaz/helpers/styles.dart';
import 'package:enjaz/helpers/translation/set_localization.dart';
import 'package:enjaz/main_blocs/lang_cubit/lang_cubit.dart';
import 'package:enjaz/navigation/custom_navigation.dart';
import 'package:enjaz/navigation/routes.dart';
import 'package:enjaz/network/TokenUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';

import 'features/splash/splash_bloc.dart';
import 'main_blocs/auth_cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await TokenUtil.loadTokenToMemory();

  runApp(
    BlocProvider(
      create: (BuildContext context) => LangCubit(),
      child: const MyApp(),
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(create: (_) => SplashBloc()),
        BlocProvider<AuthCubit>(create: (BuildContext context) => AuthCubit()),
      ],
      child: BlocBuilder<LangCubit, LangState>(
        builder: (context, state) {
          log("state lang ${state.locale.languageCode}");
          return MaterialApp(
            initialRoute: Routes.splash,
            navigatorKey: CustomNavigator.navigatorState,
            onGenerateRoute: CustomNavigator.onCreateRoute,
            navigatorObservers: [CustomNavigator.routeObserver],
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: CustomNavigator.scaffoldState,
            locale: state.locale,
            supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
            localizationsDelegates: const [
              SetLocalization.localizationsDelegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            title: "Enjaz",
            theme: ThemeData(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                },
              ),
              primaryColor: Styles.primaryColor,
              colorScheme: const ColorScheme.light(
                primary: Styles.primaryColor,
                secondary: Styles.blackColor,
              ),
              checkboxTheme: CheckboxThemeData(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              fontFamily: 'IBMPlexSansArabic',
              scaffoldBackgroundColor: Styles.primaryColor,
            ),
            builder: (ctx, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child ?? Container(),
            ),
          );
        },
      ),
    );
  }
}
