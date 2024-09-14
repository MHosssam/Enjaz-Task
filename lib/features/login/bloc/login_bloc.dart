import 'package:enjaz/app_config/endpoints.dart';
import 'package:enjaz/components/custom_button_animated.dart';
import 'package:enjaz/core/app_core.dart';
import 'package:enjaz/helpers/translation/localization_methods.dart';
import 'package:enjaz/network/generic_http.dart';
import 'package:flutter/material.dart';

class LoginBloc {
  static final LoginBloc _instance = LoginBloc._internal();

  factory LoginBloc() => _instance;

  LoginBloc._internal();
  late GlobalKey<FormState> formKey;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late GlobalKey<CustomButtonState> btnKey;
  ValueNotifier<bool> termsAccepted = ValueNotifier(false);
  ValueNotifier<bool> showPassword = ValueNotifier(false);

  void initLoginData() {
    btnKey = GlobalKey<CustomButtonState>();
    formKey = GlobalKey<FormState>();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  void loginFunction() async {
    if (termsAccepted.value == false) {
      AppCore().showSimpleToast(tr("youMustAgreeToTheTermsAndConditions"));
    } else if (formKey.currentState!.validate()) {
      btnKey.currentState?.animateForward();
      var data = await GenericHttp<dynamic>().callApi(
        name: Endpoints.loginEnd,
        returnType: ReturnType.Type,
        jsonBody: {
          "phone": phoneController.text,
          "password": passwordController.text,
        },
        methodType: MethodType.Post,
        returnDataFun: (data) => data,
      );
      btnKey.currentState?.animateReverse();
      if (data["status"] == true) {
        // CustomNavigator.push(Routes.activationCode);
      } else {
        AppCore().showSimpleToast(data["message"]);
      }
    }
  }
}
