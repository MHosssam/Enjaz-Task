// ignore_for_file: avoid_function_literals_in_foreach_calls

part of 'dio_imports.dart';

class DioHelper {
  late Dio _dio;

  DioHelper() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        contentType: "application/json",
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 800),
        receiveTimeout: const Duration(seconds: 800),
      ),
    )..interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          logPrint: (data) => log(data.toString()),
        ),
      );
  }

  Future<dynamic> get({required String url, Map<String, dynamic>? query}) async {
    _dio.options.headers = await _getHeader();
    try {
      var response = await _dio.get(url, queryParameters: query);
      log("response ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        showErrorMessage(response);
      }
    } on DioException catch (e) {
      showErrorMessage(e.response);
    }
    return null;
  }

  Future<dynamic> post({
    required String url,
    required Map<String, dynamic> body,
    bool showLoader = true,
    Map<String, dynamic>? query,
    bool sendFormData = false,
  }) async {
    //network connection
    if (await NetworkInfoImpl().isConnected == false) {
      AppCore().showSimpleToast("No Internet Connection !");
      return;
    }
    _printRequestBody(body);
    FormData formData = FormData.fromMap(body);
    bool haveFile = false;
    body.forEach((key, value) async {
      if ((value) is File) {
        haveFile = true;
        MapEntry<String, MultipartFile> pic = MapEntry(
          key,
          MultipartFile.fromFileSync(value.path, filename: value.path.split("/").last),
        );
        //add multipart to request
        formData.files.add(pic);
      } else if ((value) is List<File>) {
        haveFile = true;
        List<MapEntry<String, MultipartFile>> files = [];
        value.forEach((element) async {
          MapEntry<String, MultipartFile> pic = MapEntry(
              key,
              MultipartFile.fromFileSync(
                element.path,
                filename: element.path.split("/").last,
              ));
          files.add(pic);
        });
        formData.files.addAll(files);
      }
    });
    _dio.options.headers = await _getHeader();
    //create multipart request for POST or PATCH method
    try {
      var response = await _dio.post(url,
          data: sendFormData
              ? formData
              : haveFile
                  ? formData
                  : body,
          queryParameters: query);
      log("response ${response.statusCode}");
      log("response data ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
        return response.data;
      } else {
        showErrorMessage(response);
      }
    } on DioException catch (e) {
      showErrorMessage(e.response);
    }
    return null;
  }

  Future<dynamic> put(
      {required String url,
      required Map<String, dynamic> body,
      bool showLoader = true,
      Map<String, dynamic>? query}) async {
    if (await NetworkInfoImpl().isConnected == false) {
      AppCore().showSimpleToast("No Internet Connection !", backgroundColor: Colors.orangeAccent);
      return;
    }
    _printRequestBody(body);
    FormData formData = FormData.fromMap(body);
    bool haveFile = false;
    body.forEach((key, value) async {
      if ((value) is File) {
        haveFile = true;
        //create multipart using filepath, string or bytes
        MapEntry<String, MultipartFile> pic = MapEntry(
          key,
          MultipartFile.fromFileSync(value.path, filename: value.path.split("/").last),
        );
        //add multipart to request
        formData.files.add(pic);
      } else if ((value) is List<File>) {
        haveFile = true;
        List<MapEntry<String, MultipartFile>> files = [];
        value.forEach((element) async {
          MapEntry<String, MultipartFile> pic = MapEntry(
              key,
              MultipartFile.fromFileSync(
                element.path,
                filename: element.path.split("/").last,
              ));
          files.add(pic);
        });
        formData.files.addAll(files);
      }
    });

    _dio.options.headers = await _getHeader();
    //create multipart request for POST or PATCH method

    try {
      var response = await _dio.put(url, data: haveFile ? formData : body, queryParameters: query);
      log("response ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        showErrorMessage(response);
      }
    } on DioException catch (e) {
      showErrorMessage(e.response);
    }

    return null;
  }

  Future<dynamic> patch(
      {required String url,
      required Map<String, dynamic> body,
      bool showLoader = true,
      Map<String, dynamic>? query}) async {
    if (await NetworkInfoImpl().isConnected == false) {
      AppCore().showSimpleToast("No Internet Connection !");
      return;
    }
    _printRequestBody(body);
    _dio.options.headers = await _getHeader();
    try {
      var response = await _dio.patch(url, data: body, queryParameters: query);
      log("response ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        showErrorMessage(response);
      }
    } on DioException catch (e) {
      showErrorMessage(e.response);
    }

    return null;
  }

  Future<dynamic> delete(
      {required String url,
      required Map<String, dynamic> body,
      bool showLoader = true,
      Map<String, dynamic>? query}) async {
    if (await NetworkInfoImpl().isConnected == false) {
      AppCore().showSimpleToast("No Internet Connection !");
      return;
    }
    _printRequestBody(body);
    _dio.options.headers = await _getHeader();
    try {
      var response = await _dio.delete(url, data: body, queryParameters: query);
      log("body response ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        showErrorMessage(response);
      }
    } on DioException catch (e) {
      showErrorMessage(e.response);
    }

    return null;
  }

  Future<dynamic> uploadChatFile(String url, Map<String, dynamic> body, {bool showLoader = true}) async {
    if (await NetworkInfoImpl().isConnected == false) {
      AppCore().showSimpleToast("No Internet Connection !");
      return;
    }
    _printRequestBody(body);
    FormData formData = FormData.fromMap(body);
    body.forEach((key, value) async {
      if ((value) is File) {
        //create multipart using filepath, string or bytes
        MapEntry<String, MultipartFile> pic = MapEntry(
          key,
          MultipartFile.fromFileSync(value.path, filename: value.path.split("/").last),
        );
        //add multipart to request
        formData.files.add(pic);
      } else if ((value) is List<File>) {
        List<MapEntry<String, MultipartFile>> files = [];
        value.forEach((element) async {
          MapEntry<String, MultipartFile> pic = MapEntry(
              key,
              MultipartFile.fromFileSync(
                element.path,
                filename: element.path.split("/").last,
              ));
          files.add(pic);
        });
        formData.files.addAll(files);
      } else {
        // requestData.addAll({"$key":"$value"});
      }
    });

    _dio.options.headers = await _getHeader();
    //create multipart request for POST or PATCH method

    try {
      var response = await _dio.post(url, data: formData);
      log("response ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        showErrorMessage(response);
      }
    } on DioException catch (e) {
      showErrorMessage(e.response);
    }

    return null;
  }

  void _printRequestBody(Map<String, dynamic> body) {
    log("-------------------------------------------------------------------");
    log("$body");
    log("-------------------------------------------------------------------");
  }

  showErrorMessage(Response? response) {
    if (response == null) {
      AppCore().showSimpleToast(tr("expetion"));
    } else {
      log("failed response ${response.statusCode}");
      log("failed response ${response.data}");
      var data = response.data;
      if (data is String) data = json.decode(response.data.toString());
      switch (response.statusCode) {
        case 500:
          if (data["message"] == null) {
            AppCore().showSimpleToast(data["error"].toString());
          } else {
            AppCore().showSimpleToast(data["message"].toString());
          }
          break;
        case 422:
          if (data["message"] == null) {
            AppCore().showSimpleToast(data["error"].toString());
          } else {
            AppCore().showSimpleToast(data["message"].toString());
          }
          break;
        case 400:
          if (data["errors"] != null) {
            Map<String, dynamic> errors = data["errors"];
            log("response errors $errors");
            errors.forEach((key, value) {
              List<String> lst = List<String>.from(value.map((e) => e));
              lst.forEach((e) {
                AppCore().showSimpleToast(e);
              });
            });
          } else {
            AppCore().showSimpleToast(data["message"].toString());
          }
          break;
        case 401:
          Utility.unAuthFunc();
          AppCore().showSimpleToast(data["message"].toString());

          break;
        case 403:
          if (data["message"] == null) {
            AppCore().showSimpleToast(data["error"].toString());
          } else {
            AppCore().showSimpleToast(data["message"].toString());
          }
          break;
        case 404:
        case 405:
          AppCore().showSimpleToast(data["message"].toString());
          break;
      }
    }
  }

  _getHeader() async {
    String lang = CustomNavigator.navigatorState.currentContext!.read<LangCubit>().state.locale.languageCode;
    bool auth = CustomNavigator.navigatorState.currentContext!.read<AuthCubit>().state.authorized;
    String? token = TokenUtil.getTokenFromMemory();
    return {
      'lang': lang,
      'Accept': 'application/json',
      if (auth) 'Authorization': 'Bearer $token',
    };
  }

  // void tokenExpired() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.clear();
  //   // Navigator.pushReplacementNamed(context, Routes.loginRoute);
  // }
}
