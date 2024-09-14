import 'package:internet_connection_checker/internet_connection_checker.dart';
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl._internal();
  static final NetworkInfoImpl _instance =NetworkInfoImpl._internal();
  factory NetworkInfoImpl()=>_instance;

  final InternetConnectionChecker _internetConnectionChecker =InternetConnectionChecker();


  @override
  Future<bool> get isConnected => _internetConnectionChecker.hasConnection;
}
