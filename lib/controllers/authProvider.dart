import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:starlitfilms/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _nome;
  String? _email;
  String? _avatar;
  final AuthService _authService = AuthService();

  bool get isAuthenticated => _token != null;
  String? get avatar => _avatar;

  void setAuthToken(String token){
    _token = token;
    setCredentials(_token);
  }
  String getAuthToken(){
    if(_token == null || _token == '') {
      return '';
    }
    return _token!;
  }

  setCredentials(token) async {
    try {
      final responseCredentials = await _authService.verifyAuthentication(token);
      final responseDecoded = responseCredentials['decode'];
      _nome = responseDecoded['name'].toString();
      _email = responseDecoded['email'].toString();
      _avatar = responseDecoded['avatar'].toString();
    }catch(err){
      print('falha: ${err}');
    }
  }

  getCredentials() {
    return {
      "nome": _nome,
      "email": _email,
      "avatar": _avatar
    };
  }

  Future<void> register(String nome, String email, String password, String avatar) async {
    try {
      await _authService.register(nome, email, password, avatar);
    } catch (error) {
      debugPrint('Erro ao registrar: $error');
      rethrow;
    }
  }

  login(String email, String password) async {
    try {
      final responseData = await _authService.login(email, password);
      var responseDecoded = jsonDecode(responseData);
      setAuthToken(responseDecoded['token'].toString());

      return true;
    } catch (error) {
      debugPrint('Erro ao fazer login: $error');
      rethrow;
    }
  }

  Future<void> fetchUserDetails(String email) async {
    try {
      final userDetails = await _authService.fetchUserDetails(email);
      _avatar = userDetails['avatar']; 
    } catch (error) {
      debugPrint('Erro ao buscar detalhes do usuário: $error');
      rethrow;
    }
  }
}
