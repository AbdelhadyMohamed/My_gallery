import 'package:hive/hive.dart';

class Utilities {
  static void storeToken(String token) async {
    var box = await Hive.openBox('tokenBox');
    await box.put('token', token);
  }

  static void storeName(String name) async {
    var box = await Hive.openBox('nameBox');
    await box.put('name', name);
  }

  static Future<String> getToken() async {
    var box = await Hive.openBox('tokenBox');
    return box.get('token');
  }

  static Future<String> getName() async {
    var box = await Hive.openBox('nameBox');
    return box.get('name');
  }
}
