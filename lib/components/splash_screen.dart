import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:starlitfilms/screens/homepage.dart';

class SplashScreenIntro extends StatefulWidget {
  const SplashScreenIntro({super.key});

  @override
  State<SplashScreenIntro> createState() => _SplashScreenIntroState();
}

class _SplashScreenIntroState extends State<SplashScreenIntro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterSplashScreen.scale(
        backgroundColor: const Color(0xff1A0C40),
        childWidget: SizedBox(
          height: 300,
          child: Image.asset("assets/logoCompleta.png"),
        ),
        duration: const Duration(milliseconds: 2500),
        animationDuration: const Duration(milliseconds: 1250),
        nextScreen: HomePage(),
      ),
    );
  }
}