import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_flutter/models/user_login.dart';
import 'package:project_flutter/services/url.dart';


class LoginService {
  static Future<UserLogin?> login(String username, String password) async {
    final url = Uri.parse(BaseUrl + "/auth/login");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password, 
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = UserLogin.fromJson(data);
        await user.saveToPrefs();
        return user;
      } else {
        return UserLogin(
          status: false,
          message: 'Invalid credentials',
        );
      }
    } catch (e) {
      return UserLogin(
        status: false,
        message: 'Login error: $e',
    );
    }
  }
}