import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService  {
  String? _token;

  bool get isAuthenticated => _token != null;

  final String baseUrl = "https://3d9dba1f-2b5b-433f-a1b0-eb428d2de251-00-32rrmhyucky1c.worf.replit.dev";

  Future<void> register(String nome, String email, String password, String avatar) async {
    final uri = Uri.parse('$baseUrl/user/register');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': nome, 'email': email, 'password': password, 'avatar':avatar}),
    );

    print('Status Code: ${response.statusCode}');
    if(response.statusCode != 201){
      throw Exception('Failed to register ${response.body}');
    }
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/user/login");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    print('Status Code: ${response.statusCode}');

    if(response.statusCode == 200){
      final responseData = json.decode(response.body);

      return responseData['token'];
    }else{
      throw Exception('Failed to login: ${response.body}');
    }
  }
}