// ignore_for_file: unused_local_variable, dead_code

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlitfilms/controllers/authProvider.dart';
import 'package:starlitfilms/screens/Perfil/editar_perfil.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> with TickerProviderStateMixin {
  bool isPostsSelected = true;
  late final String username;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    
    super.initState();
    
    username = Provider.of<AuthProvider>(context, listen: false).username ?? '';
    Provider.of<AuthProvider>(context, listen: false).fetchFilmes();
  
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (username.isNotEmpty) {
        authProvider.fetchReviews(username);
      }
    });

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
              SlideTransition(
                position: _slideAnimation,
                child: Container(
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
                              padding: const EdgeInsets.fromLTRB(0, 15, 30, 0),
                              child: Row(
                                children: [
                                  _statColumn("Friends", authProvider.amigos.length.toString()),
                                  _verticalDivider(),
                                  _statColumn("Posts", authProvider.reviews.length.toString()),
                                  _verticalDivider(),
                                  _statColumn("Likes", "0"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        authProvider.nome ?? 'usuário',
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
              ),
              SizedBox(height: screenHeight * 0.02),

              // Adicionando o switch de "Posts" e "Favoritos"
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
                      alignment: isPostsSelected
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
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
                                  color: isPostsSelected
                                      ? Colors.black
                                      : Colors.white,
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
                                  color: !isPostsSelected
                                      ? Colors.black
                                      : Colors.white,
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
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 50,
      color: Colors.white70,
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildNewPostModal(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    int starRating = 0; // Controle para a avaliação com estrelas
    bool isPublic = true; // Controle para visibilidade (Público/Privado)
    String? selectedMovie; // Para armazenar o filme selecionado

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2A1266), Color(0xFF150B2E)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          Consumer<AuthProvider>(
            builder: (context, auth, child) {
              // Verifica se há filmes carregados
              final filmes = auth.filmes;

              return DropdownButtonFormField<String>(
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
                items: filmes.isNotEmpty
                    ? filmes
                        .map<DropdownMenuItem<String>>(
                            (filme) => DropdownMenuItem<String>(
                                  // Usando o campo 'nome' conforme sua API
                                  value: filme['nome'],
                                  child: Text(
                                    filme['nome'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ))
                        .toList()
                    : [
                        const DropdownMenuItem(
                          value: null,
                          child: Text(
                            'Nenhum filme disponível',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                onChanged: (value) {
                  setState(() {
                    selectedMovie = value;
                  });
                },
              );
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
              IconButton(
                icon: Icon(
                  isPublic ? Icons.visibility : Icons.visibility_off,
                  color: isPublic ? Colors.white : Colors.grey,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    isPublic = !isPublic;
                  });
                },
              ),
              const SizedBox(width: 10),
              Row(
                children: List.generate(5, (index) {
                  return IconButton(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    icon: Icon(
                      Icons.star,
                      color: index < starRating
                          ? const Color(0xff7E56E4)
                          : Colors.grey,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        starRating = index + 1;
                      });
                    },
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              if (selectedMovie != null) {
                // Lógica para salvar o post aqui
                print("Visibilidade: ${isPublic ? 'Público' : 'Privado'}");
                print("Nota: $starRating estrelas");
                print("Filme: $selectedMovie");
                Navigator.pop(context);
              } else {
                // Exibir uma mensagem de erro se nenhum filme for selecionado
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Por favor, selecione um filme.')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff7E56E4),
              minimumSize: Size(double.infinity, screenHeight * 0.07),
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
  }
}