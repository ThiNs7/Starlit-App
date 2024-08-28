import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService  {
  String? _token;

  bool get isAuthenticated => _token != null;

  final String baseUrl = "https://def5f95f-e30e-4f86-b1e0-9f53460f5248-00-1pjmbawk5ifrf.worf.replit.dev";

  Future<void> register(String nome, String email, String password) async {
    final url = Uri.parse("$baseUrl/register");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': nome, 'email': email, 'password': password}),
    );

    if(response.statusCode != 201){
      throw Exception('Failed to register ${response.body}');
    }
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/login");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    print(response.body);

    if(response.statusCode == 200){
      final responseData = json.decode(response.body);

      return responseData['token'];
    }else{
      throw Exception('Failed to login: ${response.body}');
    }
  }
}