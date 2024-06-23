import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  // TOKEN
  Future<bool> setAuthToken(String token) {
    return _sharedPreferences!.setString('TOKEN', token);
  }

  String getAuthToken() {
    try {
      return _sharedPreferences!.getString('TOKEN') ?? '';
    } catch (e) {
      return '';
    }
  }
}
