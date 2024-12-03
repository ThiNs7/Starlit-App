import 'package:flutter/material.dart';

class ReviewDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final double rating; // Parâmetro para a classificação

  const ReviewDetailPage({
    Key? key,
    required this.title,
    required this.description,
    required this.rating, // Recebe a classificação
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Permite que o corpo se estenda atrás da AppBar
      extendBodyBehindAppBar: true, // Permite que o corpo se estenda atrás da AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Torna a AppBar transparente
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Seta de voltar branca
          onPressed: () {
            Navigator.of(context).pop(); // Volta para a página anterior
          },
        ),
      ),
      body: Stack(
        children: [
          // Fundo com degradê
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2A1266), Color(0xFF150B2E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Overlay escuro (opcional)
          Container(
            color: Colors.black.withOpacity(0.5), // Escurece o fundo
          ),
          // Conteúdo da página
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40), // Espaçamento entre a seta e o título
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                // Exibe as estrelas de nota
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating.round() ? Icons.star : Icons.star_border,
                      color: const Color(0xff9670F5),
                      size: 20,
                    );
                  }),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}