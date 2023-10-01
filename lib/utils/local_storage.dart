import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static LocalStorage? _instance;
  SharedPreferences preferences;

  LocalStorage._(this.preferences);

  static Future<LocalStorage> getInstance() async {
    if (_instance == null) {
      final prefs = await SharedPreferences.getInstance();
      _instance = LocalStorage._(prefs);
    }
    return _instance!;
  }

  static LocalStorage get instance => _instance!;
}
