import 'package:enjaz/app_config/endpoints.dart';
import 'package:enjaz/components/custom_button_animated.dart';
import 'package:enjaz/core/app_core.dart';
import 'package:enjaz/main_blocs/generic_cubit/generic_cubit.dart';
import 'package:enjaz/main_models/city_model.dart';
import 'package:enjaz/navigation/custom_navigation.dart';
import 'package:enjaz/navigation/routes.dart';
import 'package:enjaz/network/generic_http.dart';
import 'package:flutter/material.dart';

class RegisterBloc {
  static final RegisterBloc _instance = RegisterBloc._internal();

  factory RegisterBloc() => _instance;

  RegisterBloc._internal();
  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late String cityId;
  late TextEditingController passwordController;
  late GlobalKey<CustomButtonState> btnKey;
  ValueNotifier<bool> showPassword = ValueNotifier(false);
  ValueNotifier<int> selectGender = ValueNotifier(1);
  final GenericBloc<List<CityModel>> citiesCubit = GenericBloc([CityModel()]);

  void initData() {
    btnKey = GlobalKey<CustomButtonState>();
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    cityId = '';
    _getCities();
  }

  Future<void> _getCities() async {
    var data = await GenericHttp<CityModel>().callApi(
      name: Endpoints.citiesEnd,
      returnType: ReturnType.List,
      methodType: MethodType.Get,
      returnDataFun: (data) => data == null ? [] : data['data'],
      toJsonFunc: (json) => CityModel.fromJson(json),
    );
    citiesCubit.onUpdateData(data);
  }

  void registerFunction() async {
    if (formKey.currentState!.validate()) {
      btnKey.currentState?.animateForward();
      var data = await GenericHttp<dynamic>().callApi(
        name: Endpoints.registerEnd,
        returnType: ReturnType.Type,
        jsonBody: {
          "name": nameController.text,
          "phone": phoneController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "gender": "${selectGender.value}",
          "city_id": cityId,
        },
        methodType: MethodType.Post,
        returnDataFun: (data) => data,
      );
      btnKey.currentState?.animateReverse();
      if (data["status"] == true) {
        CustomNavigator.push(Routes.login);
      } else {
        AppCore().showSimpleToast(data["message"]);
      }
    }
  }
}
