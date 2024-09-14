import 'package:enjaz/core/app_event.dart';
import 'package:enjaz/core/app_state.dart';
import 'package:enjaz/navigation/custom_navigation.dart';
import 'package:enjaz/navigation/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<AppEvent, AppState> {
  SplashBloc() : super(Start()) {
    on<Click>(onClick);
  }

  static SplashBloc get instance => BlocProvider.of(CustomNavigator.navigatorState.currentContext!);

  void onClick(AppEvent event, Emitter<AppState> emit) {
    CustomNavigator.push(Routes.login, clean: true);
  }
}
