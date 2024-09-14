// ignore_for_file: constant_identifier_names, no_duplicate_case_values, file_names

import 'dio_imports.dart';

enum ReturnType { Model, List, Type }

enum MethodType { Get, Post, Put, Patch, Delete }

class GenericHttp<T> {
  GenericHttp();

  Future<dynamic> callApi(
      {required ReturnType returnType,
      required MethodType methodType,
      required String name,
      Function(dynamic data)? returnDataFun,
      Map<String, dynamic>? jsonBody,
      Map<String, dynamic>? query,
      Function(dynamic data)? toJsonFunc,
      bool sendFormData = false,
      bool refresh = true}) async {
    var dataJson = jsonBody ?? {};

    switch (methodType) {
      case MethodType.Get:
        return _getData(
            name: name,
            query: query,
            returnType: returnType,
            refresh: refresh,
            dataKeyFun: returnDataFun,
            toJsonFunc: toJsonFunc,
            json: dataJson);
      case MethodType.Post:
        return _postData(
            name: name,
            returnType: returnType,
            json: dataJson,
            query: query,
            dataKeyFun: returnDataFun,
            toJsonFunc: toJsonFunc,
            sendFormData: sendFormData);
      case MethodType.Patch:
        return _patchData(
            name: name,
            query: query,
            returnType: returnType,
            json: dataJson,
            dataKeyFun: returnDataFun,
            toJsonFunc: toJsonFunc);
      case MethodType.Put:
        return _putData(
            name: name,
            returnType: returnType,
            json: dataJson,
            query: query,
            dataKeyFun: returnDataFun,
            toJsonFunc: toJsonFunc);
      case MethodType.Delete:
        return _deleteData(
            name: name,
            returnType: returnType,
            json: dataJson,
            query: query,
            dataKeyFun: returnDataFun,
            toJsonFunc: toJsonFunc);
    }
  }

  Future<dynamic> _getData({
    required ReturnType returnType,
    Map<String, dynamic> json = const {},
    Map<String, dynamic>? query,
    required String name,
    Function(dynamic data)? dataKeyFun,
    bool refresh = true,
    Function(dynamic data)? toJsonFunc,
  }) async {
    var data = await DioHelper().get(
      url: name,
      query: query,
    );
    return _returnDataFromType(data, returnType, toJsonFunc ?? (val) {}, dataKeyFun);
  }

  Future<dynamic> _postData({
    required ReturnType returnType,
    required String name,
    Map<String, dynamic>? query,
    Function(dynamic data)? dataKeyFun,
    Map<String, dynamic> json = const {},
    bool? showLoader,
    Function(dynamic data)? toJsonFunc,
    bool sendFormData = false,
  }) async {
    var data = await DioHelper().post(
        sendFormData: sendFormData, url: name, body: json, showLoader: showLoader ?? true, query: query);
    return _returnDataFromType(data, returnType, toJsonFunc ?? (val) {}, dataKeyFun);
  }

  Future<dynamic> _putData({
    Map<String, dynamic>? query,
    required ReturnType returnType,
    required String name,
    Function(dynamic data)? dataKeyFun,
    Map<String, dynamic> json = const {},
    bool? showLoader,
    Function(dynamic data)? toJsonFunc,
  }) async {
    var data = await DioHelper().put(url: name, body: json, showLoader: showLoader ?? true);
    return _returnDataFromType(data, returnType, toJsonFunc ?? (val) {}, dataKeyFun);
  }

  Future<dynamic> _patchData({
    Map<String, dynamic>? query,
    required ReturnType returnType,
    required String name,
    Function(dynamic data)? dataKeyFun,
    Map<String, dynamic> json = const {},
    bool? showLoader,
    Function(dynamic data)? toJsonFunc,
  }) async {
    var data = await DioHelper().patch(url: name, body: json, showLoader: showLoader ?? true);
    return _returnDataFromType(data, returnType, toJsonFunc ?? (val) {}, dataKeyFun);
  }

  Future<dynamic> _deleteData({
    Map<String, dynamic>? query,
    required ReturnType returnType,
    required String name,
    Function(dynamic data)? dataKeyFun,
    Map<String, dynamic> json = const {},
    bool? showLoader,
    Function(dynamic data)? toJsonFunc,
  }) async {
    var data = await DioHelper().delete(url: name, body: json, showLoader: showLoader ?? true);
    return _returnDataFromType(data, returnType, toJsonFunc ?? (val) {}, dataKeyFun);
  }

  dynamic _returnDataFromType(
    dynamic data,
    ReturnType returnType,
    Function(dynamic data) toJsonFunc,
    Function(dynamic data)? dataKeyFun,
  ) async {
    switch (returnType) {
      case ReturnType.Type:
        return dataKeyFun == null ? data : Function.apply(dataKeyFun, [data]);
      case ReturnType.Model:
        return Function.apply(toJsonFunc, [
          dataKeyFun == null ? data : Function.apply(dataKeyFun, [data])
        ]);
      case ReturnType.Model:
        return;
      case ReturnType.List:
        return List<T>.from(
          dataKeyFun == null
              ? data
              : Function.apply(dataKeyFun, [data]).map(
                  (e) => Function.apply(toJsonFunc, [e]),
                ),
        );
    }
  }
}
