import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starlitfilms/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _nome;
  String? _username;  // Adicionando username
  String? _email;
  String? _avatar;
  String? _descricao;
  List<dynamic> _amigos = [];
  final AuthService _authService = AuthService();

  bool get isAuthenticated => _token != null;
  String? get avatar => _avatar;
  String? get nome => _nome;
  String? get username => _username;  // Getter para username
  String? get descricao => _descricao;
  List<dynamic> get amigos => _amigos;

  String get authToken => _token ?? '';
  String? get email => _email;

  // Constructor que carrega os dados persistidos ao inicializar o provider
  AuthProvider() {
    _loadUserData();
  }

  // Salva o token de autenticação e os dados relacionados ao usuário no SharedPreferences
  Future<void> setAuthToken(String? token) async {
    _token = token;
    if (_token != null) {
      await _saveAuthToken(_token!);
      await setCredentials(_token!);
    }
    notifyListeners();
  }

  // Método para salvar o token no SharedPreferences
  Future<void> _saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('authToken', token);
  }

  // Carrega os dados de autenticação armazenados do SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('authToken');
    _nome = prefs.getString('nome');
    _username = prefs.getString('username');  // Carregando o username
    _avatar = prefs.getString('avatar');
    _descricao = prefs.getString('descricao');

    if (_token != null) {
      await setCredentials(_token!);
    }
    notifyListeners();
  }

  // Atualiza o avatar do usuário e armazena no SharedPreferences
  void updateAvatar(String newAvatarUrl) {
    _avatar = newAvatarUrl;
    notifyListeners();
    _updateUserDetails();
  }

  // Atualiza o nome do usuário e armazena no SharedPreferences
  void updateNome(String newNome) {
    _nome = newNome;
    notifyListeners();
    _updateUserDetails();
  }

  // Atualiza o username do usuário
  void updateUsername(String newUsername) {
    _username = newUsername;
    notifyListeners();
    _updateUserDetails();
  }

  // Atualiza a descrição do usuário
  void updateDescricao(String newDescricao) {
    _descricao = newDescricao;
    notifyListeners();
    _updateUserDetails();
  }

  // Método para salvar as alterações do perfil no SharedPreferences
  Future<void> saveProfileChanges() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome', _nome ?? '');
    await prefs.setString('username', _username ?? '');  // Salvando o username
    await prefs.setString('avatar', _avatar ?? '');
    await prefs.setString('descricao', _descricao ?? '');
    notifyListeners();
  }

  // Atualiza os dados do usuário no servidor e salva no SharedPreferences
  Future<void> _updateUserDetails() async {
    if (_email != null) {
      try {
        await _authService.updateUserDetails(_email!, _nome ?? '', _avatar ?? '', _descricao ?? '', _username ?? '');
        // Após atualizar no servidor, salvamos os dados localmente
        await saveProfileChanges();  // Salva as alterações no perfil
      } catch (error) {
        debugPrint('Erro ao atualizar detalhes do usuário: $error');
      }
    }
  }

  // Recupera as credenciais do usuário a partir do token
  Future<void> setCredentials(String token) async {
    try {
      final responseCredentials = await _authService.verifyAuthentication(token);
      final responseDecoded = responseCredentials['decode'];
      _nome = responseDecoded['name'];
      _username = responseDecoded['username'];  // Carregando o username
      _email = responseDecoded['email'];
      _avatar = responseDecoded['avatar'];
      _descricao = responseDecoded['description'];
      notifyListeners();
    } catch (err) {
      print('Falha ao carregar credenciais: $err');
    }
  }

  // Realiza o login do usuário
  Future<bool> login(String email, String password) async {
    try {
      final responseData = await _authService.login(email, password);
      final responseDecoded = jsonDecode(responseData);
      await setAuthToken(responseDecoded['token'].toString());
      return true;
    } catch (error) {
      debugPrint('Erro ao fazer login: $error');
      rethrow;
    }
  }

  // Realiza o registro do usuário
  Future<void> register(String nome, String email, String password, String avatar, String username) async {
    try {
      await _authService.register(nome, email, password, avatar, username);
      updateAvatar(avatar);
      updateNome(nome);
      updateUsername(username);  // Salvando o username durante o registro
    } catch (error) {
      debugPrint('Erro ao registrar: $error');
      rethrow;
    }
  }

  // Busca os detalhes do usuário no servidor
  Future<void> fetchUserDetails(String email) async {
    try {
      final userDetails = await _authService.fetchUserDetails(email);
      _nome = userDetails['name'];
      _username = userDetails['username'];  // Carregando o username
      _avatar = userDetails['avatar'];
      _descricao = userDetails['description'];
      notifyListeners();
    } catch (error) {
      debugPrint('Erro ao buscar detalhes do usuário: $error');
      rethrow;
    }
  }

  // Busca os amigos do usuário
  Future<void> fetchFriends() async {
    if (_token != null && _email != null) {
      try {
        _amigos = await _authService.fetchFriends(_email!, _token!);
        notifyListeners();
      } catch (error) {
        debugPrint('Erro ao buscar amigos: $error');
        rethrow;
      }
    }
  }

  // Adiciona um amigo
  Future<void> addFriend(String emailFriend) async {
    if (_token != null && _email != null) {
      try {
        await _authService.addFriend(_email!, emailFriend, _token!);
        await fetchFriends();
      } catch (error) {
        debugPrint('Erro ao adicionar amigo: $error');
        rethrow;
      }
    }
  }

  // Remove um amigo
  Future<void> removeFriend(String emailFriend) async {
    if (_token != null && _email != null) {
      try {
        await _authService.removeFriend(_email!, emailFriend, _token!);
        await fetchFriends();
      } catch (error) {
        debugPrint('Erro ao remover amigo: $error');
        rethrow;
      }
    }
  }

  // Realiza o logout, limpando os dados persistidos e a memória
  Future<void> logout() async {
    _token = null;
    _nome = null;
    _username = null;  // Limpando o username
    _email = null;
    _avatar = null;
    _descricao = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();  // Limpa todos os dados no SharedPreferences
  }
}
