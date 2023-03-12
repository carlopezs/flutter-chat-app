import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/global/environment.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _isLogin = false;

  final _storage = const FlutterSecureStorage();

  bool get isLogin => _isLogin;
  set isLogin(bool valor) {
    _isLogin = valor;
    notifyListeners();
  }

  // Getters del token de forma estática
  static Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token ?? '';
  }

  static void deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    isLogin = true;

    final data = {'email': email, 'password': password};

    final resp = await http.post(Uri.parse('${Environment.apiUrl}/login'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    isLogin = false;

    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      //TODO: Guardar token en lugar seguro

      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    isLogin = true;
    final data = {"nombre": nombre, "email": email, "password": password};
    final response = await http.post(
        Uri.parse('${Environment.apiUrl}/login/new'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data));
    isLogin = false;
    if (response.statusCode == 200) {
      final registerResponse = LoginResponse.fromJson(response.body);
      usuario = registerResponse.usuario;
      await _guardarToken(registerResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(response.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token') ?? '';
    final response = await http.get(
      Uri.parse('${Environment.apiUrl}/login/renew'),
      headers: {'Content-Type': 'application/json', 'x-token': token},
    );

    if (response.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(response.body);
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
