import 'package:flutter/material.dart';
import 'package:starlitfilms/screens/amigos.dart';

import 'package:starlitfilms/screens/biblioteca.dart';
import 'package:starlitfilms/screens/home.dart';
import 'package:starlitfilms/screens/perfil.dart';





class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pageList = [
    const Home(),
    const Biblioteca(),
    const Perfil(),
    AmigosPage()
  ];

  int pageIndex = 0;

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 74, 30, 80),
        toolbarHeight: 98.0,
        elevation: 10,
        shadowColor: const Color(0xFF0000),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                'assets/logoSmall.png',
                height: 66.0,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.deepPurple, size: 45),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'type to search',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
     
      
      body: pageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0XFFB43649),
        onTap: (e) {
          setState(() {
            pageIndex = e;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 80,
        currentIndex: pageIndex,
        items: const [
          
           BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu, color: Colors.white),
            label: '',
             
            
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            label: '',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: Colors.white),
            label: '',
          ),
        ],
        selectedIconTheme: const IconThemeData(size: 60),
        unselectedIconTheme: const IconThemeData(size: 50),
      ),
    );
  }
}
