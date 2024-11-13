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
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 2),
          child: Column(
            children: [
              // Container do perfil com responsividade
              Container(
                width: double.infinity,
                height: screenHeight * 0.43, // 35% da altura da tela
                margin: EdgeInsets.only(top: screenHeight * 0.02, left: 5, right: 5, bottom: 5),
                padding: EdgeInsets.only(top: screenHeight * 0.02, left: 20, right: 20, bottom: 20),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: authProvider.avatar != null
                                    ? NetworkImage(authProvider.avatar!)
                                    : null,
                                child: authProvider.avatar == null
                                    ? const Icon(Icons.person, size: 50, color: Colors.white)
                                    : null,
                              ),
                              SizedBox(height: screenHeight * 0.05),
                              Text(
                                authProvider.nome ?? 'Nome do Usuário',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.08, // Ajuste proporcional à largura
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
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
                            ],
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
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.33, // 35% da largura da tela
                          height: screenHeight * 0.05, // 7% da altura da tela
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
                          width: screenWidth * 0.45, // 55% da largura da tela
                          height: screenHeight * 0.05, // 7% da altura da tela
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
              SizedBox(height: screenHeight * 0.02), // Espaço entre as seções

              // Botão de alternância entre 'POSTS' e 'Favoritos' com AnimatedSwitcher
              Container(
                width: screenWidth * 0.8, // 80% da largura da tela
                height: screenHeight * 0.06, // 8% da altura da tela
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
                        width: screenWidth * 0.4, // 40% da largura da tela
                        height: screenHeight * 0.06, // 6% da altura da tela
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
                                  fontSize: screenWidth * 0.05, // Ajuste proporcional à largura
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
                                  fontSize: screenWidth * 0.05, // Ajuste proporcional à largura
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
              SizedBox(height: screenHeight * 0.02), // Espaço abaixo do botão

              // Novo botão para criar um post
              if (isPostsSelected) 
                SizedBox(
                  width: screenWidth * 0.9, // 90% da largura da tela
                  height: screenHeight * 0.05, // 6% da altura da tela
                  child: ElevatedButton(
                    onPressed: () {},
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
            color: Colors.white60,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: 1,
      height: 40,
      color: Colors.white54,
    );
  }
}