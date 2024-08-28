import 'package:flutter/material.dart';
import 'package:starlitfilms/components/bottom_nav.dart';
import 'package:starlitfilms/screens/entrar.dart';
import 'package:starlitfilms/screens/homepage.dart';
import 'package:starlitfilms/screens/login.dart';
import 'package:starlitfilms/screens/register.dart';

class TelaInicial extends StatefulWidget {
   const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  int selectedIndex = 0;

  List<Widget> pages = [
    
     Login(),
    const HomePage(),
    Cadastro(),
    const Entrar(),
    
  ];

  nextPage(int index){
      setState(() {
        selectedIndex = index;
      });
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: nextPage,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        
        currentIndex: selectedIndex,
        items:  [
           bottomNavigationBarItem(Icons.home, 'Home'),
           bottomNavigationBarItem(Icons.search, 'Busca'),
           bottomNavigationBarItem(Icons.shopping_cart, 'Compras'),
           bottomNavigationBarItem(Icons.person, 'Perfil'),
          ],
      ),
    );
  }
}