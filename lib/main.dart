import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlitfilms/components/splashScreen/splash_screen.dart';
import 'package:starlitfilms/controllers/authProvider.dart';
import 'package:starlitfilms/screens/biblioteca.dart';
import 'package:starlitfilms/screens/homepage.dart';


void main() {

  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          'biblioteca': (context) => const Biblioteca(),
          '/home' : (context) => const HomePage(),
        },
      ),
    );
  }
}