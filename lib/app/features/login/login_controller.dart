import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  Future<bool> login({required String email, required String password, required String name, required int age}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await Future.delayed(2.seconds);

    await prefs.setBool('logged', true);
    await prefs.setString('email', email);
    await prefs.setString('name', name);
    await prefs.setInt('age', age);
    return true;
  }
}
