import 'package:project_flutter/models/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<UserLogin?> loadUserFromPrefs() async{
    try {
      final user = await UserLogin.loadFromPrefs();
      if (user != null && user.status == true) {
        return user;
      } return null;
    } catch (e) {
      print('Error Loading data: $e');
      return null;
    }
  }
  
  static Future<void> clearUserData() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userData'); 
  }
}
