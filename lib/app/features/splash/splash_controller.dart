import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isLogged() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? logged = prefs.getBool('logged') ?? false;
  String? email = prefs.getString('email') ?? '';

  if (logged && email.isNotEmpty) {
    return true;
  }
  return false;
}
