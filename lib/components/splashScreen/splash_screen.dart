import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:starlitfilms/screens/entrar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starlitfilms/screens/homepage.dart'; // Para acessar os SharedPreferences

class SplashScreenIntro extends StatefulWidget {
  const SplashScreenIntro({super.key});

  @override
  State<SplashScreenIntro> createState() => _SplashScreenIntroState();
}

class _SplashScreenIntroState extends State<SplashScreenIntro> {
  Image? fundoLogin;

  @override
  void initState() {
    super.initState();
    fundoLogin = Image.asset('assets/fundoLogin.png');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(fundoLogin!.image, context);
  }

  // Função para verificar se o usuário está autenticado
  Future<bool> _checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    return token != null; // Retorna verdadeiro se o token estiver presente
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkAuthStatus(), // Verifica o status de autenticação
      builder: (context, snapshot) {
        // Enquanto carrega o status de autenticação, exibe o carregando
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(), // Indicador de carregamento
            ),
          );
        }

        // Após a verificação, decide qual tela mostrar
        if (snapshot.hasData && snapshot.data == true) {
          // Se o usuário está autenticado, redireciona para a HomePage
          return FlutterSplashScreen.scale(
            backgroundColor: const Color.fromARGB(255, 48, 24, 112),
            childWidget: SizedBox(
              height: 300,
              child: Image.asset("assets/logoCompleta.png"),
            ),
            duration: const Duration(milliseconds: 2500),
            animationDuration: const Duration(milliseconds: 1250),
            nextScreen: HomePage(), // Vai para a HomePage se autenticado
          );
        } else {
          // Se não autenticado, redireciona para a tela de login (Entrar)
          return FlutterSplashScreen.scale(
            backgroundColor: const Color.fromARGB(255, 48, 24, 112),
            childWidget: SizedBox(
              height: 300,
              child: Image.asset("assets/logoCompleta.png"),
            ),
            duration: const Duration(milliseconds: 2500),
            animationDuration: const Duration(milliseconds: 1250),
            nextScreen: const Entrar(), // Vai para a tela de login
          );
        }
      },
    );
  }
}
