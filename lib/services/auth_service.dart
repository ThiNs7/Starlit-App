import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "https://8f7414e8-3063-4b51-922b-333c93b2d21a-00-3b27394cfoaqp.riker.replit.dev";

  Uri _createUri(String path) {
    return Uri.parse('$baseUrl$path');
  }

  // Adicionando username ao método de registro
  Future<void> register(String nome, String email, String password, String avatar, String username) async {
    final uri = _createUri('/user/register');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': nome,
        'email': email,
        'password': password,
        'avatar': avatar,
        'username': username,  // Adicionando username no registro
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  // Modificando o login para também retornar username
  Future<String> login(String email, String password) async {
    print('fabroca');
    final url = _createUri("/user/login");
    print('Tecnica');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    print('rboerto carlos: ${response}');

    if (response.statusCode == 200) {
      return response.body;  // Aqui esperamos que o `username` seja retornado junto com o token
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  // Modificando a verificação de autenticação para incluir username
  Future<Map<String, dynamic>> verifyAuthentication(String token) async {
    final url = _createUri("/user/verify-auth");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'loggedToken': token}),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to verify authentication: ${response.body}');
    }
  }

  // Buscando detalhes do usuário com username
  Future<Map<String, dynamic>> fetchUserDetails(String email) async {
    final url = _createUri("/user/details?email=$email");

    final response = await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return json.decode(response.body);  // Aqui esperamos que o `username` seja retornado
    } else {
      throw Exception('Failed to fetch user details: ${response.body}');
    }
  }

  // Atualizando detalhes do usuário, incluindo o username
  Future<void> updateUserDetails(String email, String nome, String avatar, String descricao, String username) async {
    final url = _createUri("/user/update");

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_TOKEN_HERE', // Atualize para usar o token correto
      },
      body: json.encode({
        'email': email,
        'name': nome,
        'avatar': avatar,
        'description': descricao,
        'username': username,  // Incluindo username na atualização
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user details: ${response.body}');
    }
  }

  // Função de buscar amigos (sem modificações relacionadas ao username)
  Future<List<dynamic>> fetchFriends(String email, String token) async {
    final uri = _createUri('/friends/buscar');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'email': email}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // Retorna a lista de amigos
    } else {
      throw Exception('Failed to fetch friends: ${response.body}');
    }
  }

  // Função de adicionar amigo
  Future<void> addFriend(String email, String emailFriend, String token) async {
    final uri = _createUri('/friends/adicionar');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'email': email,
        'emailFriend': emailFriend,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add friend: ${response.body}');
    }
  }

  // Função de remover amigo
  Future<void> removeFriend(String email, String emailFriend, String token) async {
    final uri = _createUri('/friends/remover');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'email': email,
        'emailFriend': emailFriend,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove friend: ${response.body}');
    }
  }
}
