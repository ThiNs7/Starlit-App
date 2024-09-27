import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "https://a81d930b-8145-426a-a992-3ae5212953d1-00-141ku1p7be0mi.janeway.replit.dev";

  Uri _createUri(String path) {
    return Uri.parse('$baseUrl$path');
  }

  Future<void> register(String nome, String email, String password, String avatar) async {
    final uri = _createUri('/user/register');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': nome,
        'email': email,
        'password': password,
        'avatar': avatar,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  Future<String> login(String email, String password) async {
    final url = _createUri("/user/login");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

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
      return json.decode(response.body);
    } else {
      throw Exception('Failed to verify authentication: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> fetchUserDetails(String email) async {
    final url = _createUri("/user/details?email=$email");

    final response = await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch user details: ${response.body}');
    }
  }

  Future<void> updateUserDetails(String email, String nome, String avatar, String descricao) async {
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
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user details: ${response.body}');
    }
  }

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
