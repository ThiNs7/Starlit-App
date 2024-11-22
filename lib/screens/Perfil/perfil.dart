// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlitfilms/controllers/authProvider.dart';
import 'package:starlitfilms/screens/Perfil/editar_perfil.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  bool isPostsSelected = true; // Inicialmente 'POSTS' selecionado

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2A1266), Color(0xFF150B2E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: 2,
          ),
          child: Column(
            children: [
              // Container do perfil com responsividade
              Container(
                width: double.infinity,
                height: screenHeight * 0.43,
                margin: EdgeInsets.only(
                  top: screenHeight * 0.02,
                  left: 5,
                  right: 5,
                  bottom: 5,
                ),
                padding: EdgeInsets.only(
                  top: screenHeight * 0.02,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF462F7E), Color(0xFF7E56E4)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: authProvider.avatar != null
                                      ? NetworkImage(authProvider.avatar!)
                                      : null,
                                  child: authProvider.avatar == null
                                      ? const Icon(
                                          Icons.person,
                                          size: 50,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                                SizedBox(height: screenHeight * 0.05),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              children: [
                                _statColumn("Friends", authProvider.amigos.length.toString()),
                                _verticalDivider(),
                                _statColumn("Posts", "1.1K"),
                                _verticalDivider(),
                                _statColumn("Likes", "20.1K"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      authProvider.nome ?? 'Nome do Usuário',
                      style: TextStyle(
                        fontSize: screenWidth * 0.08,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '@${authProvider.username?.toLowerCase() ?? 'username'}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      authProvider.descricao ?? 'Descrição do usuário',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.white60,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      authProvider.email ?? 'email@exemplo.com',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white60,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.33,
                          height: screenHeight * 0.05,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditarPerfil(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff9670F5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 10,
                            ),
                            child: const Text(
                              'Editar Perfil',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.45,
                          height: screenHeight * 0.05,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff9670F5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 10,
                            ),
                            child: const Text(
                              'Compartilhar Perfil',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Botão de alternância entre 'POSTS' e 'Favoritos'
              Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.06,
                decoration: BoxDecoration(
                  color: const Color(0xFF000000).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Stack(
                  children: [
                    AnimatedAlign(
                      alignment: isPostsSelected ? Alignment.centerLeft : Alignment.centerRight,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Container(
                        width: screenWidth * 0.4,
                        height: screenHeight * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPostsSelected = true;
                              });
                            },
                            child: Center(
                              child: Text(
                                'Posts',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: isPostsSelected ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPostsSelected = false;
                              });
                            },
                            child: Center(
                              child: Text(
                                'Favoritos',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: !isPostsSelected ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Botão para criar novo post
              if (isPostsSelected)
                SizedBox(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.05,
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => _buildNewPostModal(context),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff7E56E4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 10,
                    ),
                    child: const Text(
                      'Novo Post',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.white70,
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

Widget _buildNewPostModal(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

  int starRating = 0; // Controle para a avaliação com estrelas
  bool isPublic = true; // Controle para visibilidade (Público/Privado)

  return StatefulBuilder(
    builder: (context, setModalState) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2A1266), Color(0xFF150B2E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Título
            const Text(
              'Criar Novo Post',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Campo para selecionar o nome do filme
            DropdownButtonFormField<String>(
              style: const TextStyle(color: Colors.white),
              dropdownColor: const Color(0xFF3A267F),
              decoration: InputDecoration(
                hintText: 'Selecione o filme',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: const Color(0xFF3A267F),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              items: ['Filme 1', 'Filme 2', 'Filme 3']
                  .map((filme) => DropdownMenuItem(
                        value: filme,
                        child: Text(
                          filme,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                // Lógica para salvar o nome do filme selecionado
              },
            ),
            const SizedBox(height: 20),

            // Campo para escrever o post
            TextFormField(
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Escreva algo...',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: const Color(0xFF3A267F),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Avaliação com estrelas e visibilidade
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ícone de visibilidade
                IconButton(
                  icon: Icon(
                    isPublic
                        ? Icons.visibility // Ícone de olho (público)
                        : Icons.visibility_off, // Ícone de olho com risco (privado)
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    // Alterna entre público e privado
                    setModalState(() {
                      isPublic = !isPublic;
                    });
                  },
                ),
                const SizedBox(width: 10), // Espaço menor entre ícone e estrelas

                // Avaliação com estrelas (estreitando espaço e mudando cor)
                Row(
                  children: List.generate(5, (index) {
                    return IconButton(
                      padding: const EdgeInsets.symmetric(horizontal: 5), // Espaçamento reduzido
                      icon: Icon(
                        Icons.star,
                        color: index < starRating ? Colors.pinkAccent : Colors.grey,
                        size: 30,
                      ),
                      onPressed: () {
                        // Atualiza a avaliação com estrelas
                        setModalState(() {
                          starRating = index + 1;
                        });
                      },
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Botão de publicar (tamanho aumentado)
            ElevatedButton(
              onPressed: () {
                // Lógica para salvar o post aqui
                print("Visibilidade: ${isPublic ? 'Público' : 'Privado'}");
                print("Nota: $starRating estrelas");
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff7E56E4),
                minimumSize: Size(double.infinity, screenHeight * 0.07), // Altura ajustada
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 10,
              ),
              child: const Text(
                'Publicar',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

}