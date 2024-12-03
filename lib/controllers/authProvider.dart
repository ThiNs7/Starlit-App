import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starlitfilms/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  // === Variáveis privadas ===
  String? _token;
  String? _nome;
  String? _username;
  String? _email;
  String? _avatar;
  String? _descricao;
  List<dynamic> _amigos = [];
  List<dynamic> _reviews = [];
  List<dynamic> _filmes = [];
  final AuthService _authService = AuthService();

  bool get isAuthenticated => _token != null;
  String? get avatar => _avatar;
  String? get nome => _nome;
  String? get username => _username;
  String? get descricao => _descricao;
  List<dynamic> get amigos => _amigos;
  List<dynamic> get reviews => _reviews;
  List<dynamic> get filmes => _filmes;
  String get authToken => _token ?? '';
  String? get email => _email;

  // === Construtor ===
  AuthProvider() {
    _loadUserData();
  }

  // === Autenticação ===
  Future<bool> login(String email, String password) async {
    try {
      final responseData = await _authService.login(email, password);
      final responseDecoded = jsonDecode(responseData);
      print('vbokfsg ${responseDecoded['usuario']}');
      print('bal ${_nome}');
      print('bal ${_email}');
      print('bal ${_avatar}');
      print('bal ${_descricao}');
      print('bal ${_token}');
      await setAuthToken(responseDecoded['token'].toString());
      return true;
    } catch (error) {
      debugPrint('Erro ao fazer login: $error');
      rethrow;
    }
  }
  List<dynamic> _todasReviews = [];

List<dynamic> get todasReviews => _todasReviews;

Future<void> fetchAllReviews() async {
  try {
    _todasReviews = await _authService.fetchAllReviews(); // Atribua diretamente
    debugPrint('Reviews recebidas: $_todasReviews'); // Imprime a lista de reviews
    notifyListeners();
  } catch (error) {
    debugPrint('Erro ao buscar todas as reviews: $error');
    rethrow;
  }
}

  Future<void> register(String nome, String username, String email,
      String password, String avatar) async {
    try {
      await _authService.register(nome, username, email, password, avatar);
      _nome = nome;
      _username = username;
      _avatar = avatar;

      await saveProfileChanges();
      notifyListeners();
    } catch (error) {
      debugPrint('Erro ao registrar: $error');
      rethrow;
    }
  }

  Future<void> logout() async {
    _token = null;
    _nome = null;
    _username = null;
    _email = null;
    _avatar = null;
    _descricao = null;
    _filmes = []; // Limpa a lista de filmes no logout
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }



  void updateAvatar(String newAvatarUrl) {
    _avatar = newAvatarUrl;
    notifyListeners();
    _updateUserDetails();
  }

  void updateNome(String newNome) {
    _nome = newNome;
    notifyListeners();
    _updateUserDetails();
  }

  void updateUsername(String newUsername) {
    _username = newUsername;
    notifyListeners();
    _updateUserDetails();
  }

  void updateDescricao(String newDescricao) {
    _descricao = newDescricao;
    notifyListeners();
    _updateUserDetails();
  }

  Future<void> saveProfileChanges() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome', _nome ?? '');
    await prefs.setString('username', _username ?? '');
    await prefs.setString('avatar', _avatar ?? '');
    await prefs.setString('descricao', _descricao ?? '');
    notifyListeners();
  }

  Future<void> _updateUserDetails() async {
    if (_email != null) {
      try {
        await _authService.updateUserDetails(
          _email!,
          _nome ?? '',
          _username ?? '',
          _avatar ?? '',
          _descricao ?? ''
        );
        await saveProfileChanges();
      } catch (error) {
        debugPrint('Erro ao atualizar detalhes do usuário: $error');
      }
    }
  }

  // === Amigos ===
  Future<void> fetchFriends(String username) async {
    try {
      _amigos = await _authService.fetchFriends(username!);
      notifyListeners();
    } catch (error) {
      debugPrint('Erro ao buscar amigos: $error');
      rethrow;
    }
  }
  Future<void> fetchReviews(String username) async {
    try {
      _reviews = await _authService.fetchReviews(username);
      notifyListeners();
    } catch (error) {
      debugPrint('Erro ao buscar reviews: $error');
      rethrow;
    }
  }

  Future<void> addFriend(String emailFriend) async {
    if (_token != null && _email != null) {
      try {
        await _authService.addFriend(_email!, emailFriend, _token!);
        await fetchFriends(_username!);
      } catch (error) {
        debugPrint('Erro ao adicionar amigo: $error');
        rethrow;
      }
    }
  }

  Future<void> removeFriend(String emailFriend) async {
    if (_token != null && _email != null) {
      try {
        await _authService.removeFriend(_email!, emailFriend, _token!);
        await fetchFriends(_username!);
      } catch (error) {
        debugPrint('Erro ao remover amigo: $error');
        rethrow;
      }
    }
  }

  // === Filmes ===
Future<void> fetchFilmes() async {
  if (_token == null) {
    throw Exception('Usuário não está autenticado!');
  }

  try {
    // Realiza a requisição para buscar os filmes
    _filmes = await _authService.fetchFilmes(_token!);
    debugPrint('Filmes recebidos: $_filmes');
    notifyListeners();
  } catch (error) {
    debugPrint('Erro ao buscar filmes: $error');
    rethrow;
  }
}

  // === Avaliações ===
Future<void> publishReview(String reviewText, int rating) async {
  if (_token == null) {
    throw Exception('Usuário não está autenticado!');
  }

  try {
    await _authService.publishReview(
      _email!,
      reviewText,
      rating,
      _token!,
    );
    await fetchAllReviews(); // Atualiza a lista de todas as reviews
  } catch (error) {
    debugPrint('Erro ao publicar a avaliação: $error');
    rethrow;
  }
}

  // === Armazenamento local ===
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('authToken');
    _nome = prefs.getString('nome');
    _username = prefs.getString('username');
    _avatar = prefs.getString('avatar');
    _descricao = prefs.getString('descricao');

    if (_token != null) {
      await setCredentials(_token!);
    }
    notifyListeners();
  }

  Future<void> setAuthToken(String? token) async {
    _token = token;
    if (_token != null) {
      await _saveAuthToken(_token!);
      await setCredentials(_token!);
    }
    notifyListeners();
  }

  Future<void> _saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('authToken', token);
  }

  Future<void> setCredentials(String token) async {
    try {
      final responseCredentials =
          await _authService.verifyAuthentication(token);
      final responseDecoded = responseCredentials['decode'];
      _nome = responseDecoded['name'];
      _username = responseDecoded['username'];
      _email = responseDecoded['email'];
      _avatar = responseDecoded['avatar'];
      _descricao = responseDecoded['description'];
      notifyListeners();
    } catch (err) {
      debugPrint('Falha ao carregar credenciais: $err');
    }
  }
  Future<void> addReview(String movieName, int rating) async {
  if (_token == null) {
    throw Exception('Usuário não está autenticado!');
  }

  try {
    // Aqui você pode adicionar lógica para enviar a review ao seu banco de dados
    await _authService.publishReview(_email!, movieName, rating, _token!);
    // Atualiza a lista de todas as reviews
    await fetchAllReviews();
  } catch (error) {
    debugPrint('Erro ao publicar a avaliação: $error');
    rethrow;
  }
}
}
