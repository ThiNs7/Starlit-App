import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:starlitfilms/screens/entrar.dart';


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
  
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/fundoLogin'), context);
    return Scaffold(
      body: FlutterSplashScreen.scale(
        backgroundColor: const Color.fromARGB(255, 14, 7, 34),
        childWidget: SizedBox(
          height: 300,
          child: Image.asset("assets/logoCompleta.png"),
        ),
        duration: const Duration(milliseconds: 2500),
        animationDuration: const Duration(milliseconds: 1250),
        nextScreen: const Entrar(),
      ),
    );
  }
}