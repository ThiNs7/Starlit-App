// ignore_for_file: unused_local_variable

import 'dart:ui';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:starlitfilms/components/review_form.dart';
import 'package:starlitfilms/controllers/authProvider.dart';
import 'package:starlitfilms/screens/Perfil/perfil.dart';
import 'package:starlitfilms/screens/amigos.dart';
import 'package:starlitfilms/screens/review.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late NotchBottomBarController _controller;
  List<Review> userReviews = [];
  // ignore: unused_field
  final AuthProvider _authProvider = AuthProvider();

  void _showReviewForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReviewForm(
          onSubmit: (review) {
            setState(() {
              userReviews.add(review);
            });
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = NotchBottomBarController(); 
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).fetchAllReviews();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return _homePageContent();
      case 1:
        return const Perfil(); // Página de Perfil, onde AppBar será ocultada
      case 2:
        return const AmigosPage();
      default:
        return _homePageContent();
    }
  }

  Widget _homePageContent() {
    final authProvider = Provider.of<AuthProvider>(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2A1266), Color(0xFF150B2E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SingleChildScrollView( // Permite rolagem
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Text(
              'StarlitFilms',
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w300,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 383,
                    height: 42,
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF35286D).withOpacity(0.5),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Icon(Icons.search, color: Colors.white),
                        ),
                        hintText: 'Choose a Movie',
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),

            // Título "Destaques"
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 30),
                child : Text(
                  'Destaques',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),

            // Exibir as reviews em formato de grade
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0), 
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(), 
                shrinkWrap: true, 
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  childAspectRatio: 0.7, 
                  crossAxisSpacing: 10, 
                  mainAxisSpacing: 10, 
                ),
                itemCount: authProvider.todasReviews.length,
                itemBuilder: (context, index) {
                  final review = authProvider.todasReviews[index]; 

                  // Extrai as informações necessárias
                  String reviewText = review['descricao'] ?? 'Sem descrição';
                  List<String> words = reviewText.split(' ');
                  String shortReviewText = words.take(5).join(' '); 
                  String bannerFilme = review['bannerFilme'] ?? ''; 

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewDetailPage(
                            title: review['tituloFilme'] ?? 'Título Desconhecido',
                            description: reviewText,
                            rating: review['nota']?.toDouble() ?? 0.0,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(bannerFilme), 
                          fit: BoxFit.cover, 
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5), 
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3), 
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          color: Colors.black.withOpacity(0.7), // Fundo escuro cobrindo todo o banner
                          child: Padding(
                            padding: const EdgeInsets.all(12), 
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review['tituloFilme'] ?? 'Sem título', 
                                  style: const TextStyle(color: Colors.white, fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: List.generate(5, (starIndex) {
                                    return Icon(
                                      starIndex < review['nota']?.round() ? Icons.star : Icons.star_border,
                                      color: const Color(0xff9670F5),
                                      size: 20,
                                    );
                                  }),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  shortReviewText, 
                                  style: const TextStyle(color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 150),
                                Text(
                                  'Autor: ${review['autorReview'] ?? 'Desconhecido'}', 
                                  style: const TextStyle(color: Colors.white, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _selectedIndex == 1 
          ? null
          : AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 100,
              title: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                child: Image.asset(
                  'assets/logoSmall.png',
                  height: 50,
                  width: 50,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
      body: _getPage(_selectedIndex),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Image.asset(
              'assets/home_icon.png',
              width: 30,
              height: 30,
            ),
            activeItem: Image.asset(
              'assets/home_icon.png',
              width: 30,
              height: 30,
            ),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Image.asset(
              'assets/perfil_icon.png',
              width: 30,
              height: 30,
            ),
            activeItem: Image.asset(
              'assets/perfil_icon.png',
              width: 30,
              height: 30,
            ),
            itemLabel: 'Perfil',
          ),
          BottomBarItem(
            inActiveItem: Image.asset(
              'assets/amigos_icon.png',
              width: 50,
              height: 50,
            ),
            activeItem: Image.asset(
              'assets/amigos_icon.png',
              width: 50,
              height: 50,
            ),
            itemLabel: 'Amigos',
          ),
        ],
        onTap: _onItemTapped,
        notchColor: const Color(0xFF42326A),
        showLabel: false,
        itemLabelStyle: const TextStyle(
          fontSize: 16.0,
        ),
        bottomBarHeight: 20.0,
        elevation: 8.0,
        color: const Color(0xff2C2247),
        durationInMilliSeconds: 200,
        showBlurBottomBar: false,
        kBottomRadius: 40,
        kIconSize: 24,
      ),
    );
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // Ativar modo imersivo (esconde barra de status e navegação)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Espera 2 segundos e navega para a tela de amigos
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const AmigosPage(), // Substitua pela sua tela de amigos
        ),
      );
    });
  }

  @override
  void dispose() {
    // Voltar com as overlays normais
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.purple, // Cor de fundo da splash screen
      body: Center(
        child: Text(
          'Bem-vindo!',
          style: TextStyle(color: Colors.white, fontSize: 24), // Texto de boas-vindas
        ),
      ),
    );
  }
}

