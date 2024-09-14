import 'package:enjaz/core/enums.dart';
import 'package:get_storage/get_storage.dart';

class CachingKey extends Enum<String> {
  const CachingKey(super.val);
  static const CachingKey token = CachingKey('token');
  static const CachingKey isUser = CachingKey('isUser');
  static const CachingKey profileData = CachingKey('profileData');
  static const CachingKey aboutUs = CachingKey('aboutUs');
  static const CachingKey terms = CachingKey('terms');
  static const CachingKey policy = CachingKey('policy');
  static const CachingKey contactInfo = CachingKey('contactInfo');
  static const CachingKey packageData = CachingKey('packageData');
  static const CachingKey orderDetailsData = CachingKey('orderDetailsData');
}

class SharedHelper {
  GetStorage myStorage = GetStorage();

  void saveValue(String key, var value) {
    myStorage.write(key, value);
  }

  void removeValue(String key) {
    myStorage.remove(key);
  }

  dynamic getValue(String key) {
    var value = myStorage.read(key);
    return value;
  }
}
