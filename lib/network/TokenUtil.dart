import 'package:enjaz/helpers/shared_helper.dart';

class TokenUtil {
  static String _token = '';

  static Future<void> loadTokenToMemory() async {
    _token = SharedHelper().getValue(CachingKey.token.value).toString();
  }

  static String getTokenFromMemory() {
    return _token;
  }

  static Future<void> saveToken(String myToken) async {
    SharedHelper().saveValue(CachingKey.token.value, myToken);
    await loadTokenToMemory();
  }

  static void clearToken() {
    SharedHelper().removeValue(CachingKey.token.value);
    _token = '';
  }
}
