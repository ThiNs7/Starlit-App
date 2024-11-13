import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlitfilms/components/splashScreen/splash_screen.dart';
import 'package:starlitfilms/controllers/authProvider.dart';
import 'package:starlitfilms/screens/biblioteca.dart';  // Certifique-se de importar BibliotecaPage
import 'package:starlitfilms/screens/entrar.dart';
import 'package:starlitfilms/screens/homepage.dart';
import 'package:starlitfilms/screens/amigos.dart';  // Certifique-se de importar a página de Amigos

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreenIntro(),
          '/entrar': (context) => const Entrar(),
          '/home': (context) => const HomePage(),
          // Aqui estamos definindo a rota para 'BibliotecaPage'.
          // Agora, vamos passar o 'Amigo' como argumento para a biblioteca
          '/biblioteca': (context) => BibliotecaPage(
            amigo: ModalRoute.of(context)?.settings.arguments as Amigo,  // Recebendo o 'Amigo' da navegação
          ),
        },
      ),
    );
  }
}

