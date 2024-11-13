import 'package:flutter/material.dart';
import 'amigos.dart';  // Importa a classe Amigo de amigos.dart

class BibliotecaPage extends StatelessWidget {
  final Amigo amigo;  // Agora Amigo é a mesma classe de amigos.dart

  BibliotecaPage({Key? key, required this.amigo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Amigo'),
        backgroundColor: const Color.fromARGB(255, 61, 25, 66),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(amigo.fotoUrl),
            ),
            SizedBox(height: 16),
            Text(
              amigo.nome,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              amigo.email,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 20),
            // Você pode adicionar mais informações aqui sobre o amigo
            Text(
              'Informações adicionais sobre o amigo...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
