import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/auth_model.dart';
import '../constants/api_constants.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _token;
  String? _nickname;
  String? _userId;

  bool get isLoading => _isLoading;
  String? get token => _token;
  String? get nickname => _nickname;
  String? get userId => _userId;
  bool get isLoggedIn => _token != null;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearUserData() {
    _token = null;
    _nickname = null;
    _userId = null;
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    _setLoading(true);
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        _token = responseData['token'] as String?;
        _nickname = responseData['nickname'] as String?;
        if (responseData['userId'] != null) {
          _userId = responseData['userId'].toString();
        } else {
          _userId = null;
        }

        _setLoading(false);
        return {'success': true, 'data': responseData};
      } else {
        _setLoading(false);
        _clearUserData();

        return {'success': false, 'message': '로그인 실패: ${response.body}'};
      }
    } catch (e) {
      _setLoading(false);
      _clearUserData();
      return {'success': false, 'message': '오류 발생: $e'};
    }
  }

  Future<Map<String, dynamic>> signup(
    String username,
    String password,
    String nickname,
  ) async {
    _setLoading(true);
    final authData = AuthModel(
      username: username,
      password: password,
      nickname: nickname,
    );
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(authData.toJson()),
      );

      _setLoading(false);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return {'success': true, 'data': jsonDecode(response.body)};
      } else {
        return {'success': false, 'message': '회원가입 실패: ${response.body}'};
      }
    } catch (e) {
      _setLoading(false);
      return {'success': false, 'message': '오류 발생: $e'};
    }
  }

  Future<void> logout() async {
    _clearUserData();
  }
}
