import 'dart:convert';
import 'package:http/http.dart' as http;

class FriendService {
  final String apiUrl = 'http://localhost:3000/friends';

  // Adicionar amigo
  Future<void> addFriend(String name, String email) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao adicionar amigo');
    }
  }

  // Remover amigo
  Future<void> removeFriend(String id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Erro ao remover amigo');
    }
  }

  // Listar amigos
  Future<List<dynamic>> getFriends() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao listar amigos');
    }
  }
}
