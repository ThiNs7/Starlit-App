import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'conversas.dart';  // Importando a ChatPage de conversas.dart

class AmigosPage extends StatefulWidget {
  const AmigosPage({super.key});

  @override
  _AmigosPageState createState() => _AmigosPageState();
}

class _AmigosPageState extends State<AmigosPage> {
  List<Amigo> amigos = [];
  List<Amigo> amigosFiltrados = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAmigos();
  }

  Future<void> _fetchAmigos() async {
    final url = Uri.parse('https://8f7414e8-3063-4b51-922b-333c93b2d21a-00-3b27394cfoaqp.riker.replit.dev/user/amigos');
    final body = json.encode({
      "email": "pedro@gmail.com"
    });
    try {
      final response = await http.post(url, headers: {
        'Content-Type': 'application/json',
      }, body: body);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          amigos = data.map((json) => Amigo.fromJson(json)).toList();
          amigosFiltrados = amigos;
          isLoading = false;
        });
      } else {
        throw Exception('Erro ao carregar dados');
      }
    } catch (e) {
      print('Erro: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Função para filtrar amigos
  void _filterAmigos(String query) {
    final amigosFiltradosList = amigos.where((amigo) {
      final amigoNome = amigo.nome.toLowerCase();
      final input = query.toLowerCase();
      return amigoNome.contains(input);
    }).toList();

    setState(() {
      amigosFiltrados = amigosFiltradosList;
    });
  }

  // Função para exibir recomendações de amigos em uma janela
  void _showFriendRecommendations() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 61, 25, 66),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              onChanged: _filterAmigos,
              decoration: InputDecoration(
                hintText: 'Pesquisar amigos',
                hintStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white70,
                  size: 20, // Diminui o tamanho do ícone
                ),
                filled: true,
                fillColor: Colors.white10,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: amigosFiltrados.map((amigo) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(amigo.fotoUrl),
                    radius: 20,
                  ),
                  title: Text(
                    amigo.nome,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          nome: amigo.nome,
                          fotoUrl: amigo.fotoUrl,
                          amigo: amigo, // Passa o objeto 'Amigo' inteiro
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Fechar", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 61, 25, 66),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: amigos.length,
              itemBuilder: (context, index) {
                final amigo = amigos[index];
                return ListTile(
                  contentPadding: EdgeInsets.all(11),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          nome: amigo.nome,       // Passa o nome do amigo
                          fotoUrl: amigo.fotoUrl,
                          amigo: amigo,            // Passa o objeto amigo completo
                        ),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(amigo.fotoUrl),
                    radius: 30,
                  ),
                  title: Text(
                    amigo.nome,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showFriendRecommendations,
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class Amigo {
  final String nome;
  final String fotoUrl;
  final String email;

  Amigo({required this.nome, required this.fotoUrl, required this.email});

  factory Amigo.fromJson(Map<String, dynamic> json) {
    return Amigo(
      nome: json['name'] as String,
      fotoUrl: json['avatar'] as String,
      email: json['email'] as String,
    );
  }
}
