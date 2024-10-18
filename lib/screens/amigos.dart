import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Amigo {
  final String nome;
  final String status;
  final String fotoUrl;
  final String email;
  final String description;

  Amigo({
    required this.nome,
    required this.status,
    required this.fotoUrl,
    required this.email,
    this.description = '',
  });
}

class AmigosPage extends StatefulWidget {
  @override
  _AmigosPageState createState() => _AmigosPageState();
}

class _AmigosPageState extends State<AmigosPage> {
  final List<Amigo> amigos = [];
  final TextEditingController _searchController = TextEditingController();
  final String userEmail = 'user@example.com';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchAmigos();
  }

  Future<void> _fetchAmigos() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('https://afaa0946-c534-4bea-9f4f-3ce9c82746c0-00-29z2fpfbiqe87.riker.replit.dev/buscarAmigos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': userEmail}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        amigos.clear();
        amigos.addAll(data.map((item) => Amigo(
          nome: item['nome'],
          status: item['status'],
          fotoUrl: item['fotoUrl'],
          email: item['email'],
          description: item['description'] ?? '',
        )).toList());
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar amigos: ${response.body}')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _adicionarAmigo(String emailFriend) async {
    final response = await http.post(
      Uri.parse('https://a81d930b-8145-426a-a992-3ae5212953d1-00-141ku1p7be0mi.janeway.replit.dev/adicionarAmigo'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': userEmail, 'emailFriend': emailFriend}),
    );

    if (response.statusCode == 200) {
      _fetchAmigos();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Amigo adicionado com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar amigo: ${response.body}')),
      );
    }
  }

  Future<void> _removerAmigo(String emailFriend) async {
    final response = await http.post(
      Uri.parse('https://a81d930b-8145-426a-a992-3ae5212953d1-00-141ku1p7be0mi.janeway.replit.dev/removerAmigo'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': userEmail, 'emailFriend': emailFriend}),
    );

    if (response.statusCode == 200) {
      _fetchAmigos();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Amigo removido com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao remover amigo: ${response.body}')),
      );
    }
  }

  void _mostrarDetalhes(BuildContext context, Amigo amigo) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          contentPadding: EdgeInsets.zero,
          content: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 380,
              ),
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(amigo.fotoUrl),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      amigo.nome,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      amigo.status,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      child: Text(
                        amigo.description,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        _removerAmigo(amigo.email);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Remover Amigo'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Fechar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/homeFundo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          labelText: 'Email do Amigo',
                          border: OutlineInputBorder(),
                          labelStyle: const TextStyle(color: Color.fromARGB(255, 121, 42, 84)),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String emailFriend = _searchController.text;
                        if (emailFriend.isNotEmpty) {
                          _adicionarAmigo(emailFriend);
                          _searchController.clear();
                        }
                      },
                      child: Text('Adicionar Amigo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 121, 42, 84),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: amigos.length,
                        itemBuilder: (context, index) {
                          final amigo = amigos[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(amigo.fotoUrl),
                            ),
                            title: Text(amigo.nome, style: TextStyle(color: Colors.white)),
                            subtitle: Text(amigo.status, style: TextStyle(color: Colors.white)),
                            onTap: () {
                              _mostrarDetalhes(context, amigo);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: Icon(Icons.person_add),
        backgroundColor: const Color.fromARGB(255, 121, 42, 84),
      ),
    );
  }
}
