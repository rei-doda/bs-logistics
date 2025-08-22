import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  String? _token;
  String? _userId;
  String? _userRole;

  bool get isAuth => _token != null;
  String? get token => _token;
  String? get userId => _userId;
  String? get userRole => _userRole;

  Future<void> login(String email, String password) async {
    final url = Uri.parse('http://localhost:8080/api/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );
      final responseData = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception(responseData['message'] ?? 'Authentication Failed');
      }
      _token = responseData['token'];
      _userId = responseData['userId'];
      _userRole = responseData['role'];
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'userRole': _userRole,
      });
      prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) return false;
    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _userRole = extractedUserData['userRole'];
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _userRole = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
