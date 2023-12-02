import 'package:shared_preferences/shared_preferences.dart';

Future<bool> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  try {
    await prefs.remove('logged');
    await prefs.remove('email');
    await prefs.remove('name');
    await prefs.remove('age');
    return true;
  } catch (e) {
    return false;
  }
}
