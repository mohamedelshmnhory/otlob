import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:otlob/widgets/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  bool isAuth = false;

  Future<void> _authenticate(String email, String password) async {
    final url = 'http://otlob.accuragroup-eg.net/api/login';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'mobile': email,
            'password': password,
            'access_key': 'Gdka52DASWE3DSasWE742Wq',
            'access_password': 'yH52dDDF85sddEWqPNV7D12sW5e',
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      print(response.statusCode);
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {'userId': "_userId"},
      );
      prefs.setString('userData', userData);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      isAuth = false;
      return false;
    }
    print('true');
    isAuth = true;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    isAuth = false;
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    prefs.clear();
    notifyListeners();
  }
}
