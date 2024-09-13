import 'package:flutter/material.dart';
import 'package:starlitfilms/components/slide.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 64, 29, 69),
              Color.fromARGB(255, 134, 39, 54),
            ],
          ),
        ),
        child: const Column(
          children: [
            Slide(),
            
          ],
        ),
      ),
    );
  }
}