import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlitfilms/controllers/authProvider.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:starlitfilms/screens/Perfil/perfil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late NotchBottomBarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = NotchBottomBarController();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navegação para a página de perfil quando o item 'Perfil' (índice 1) for selecionado
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Perfil(email: '',)),  // Navega para a página de perfil
      );
    }
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const Center(child: Text('Página 1'));
      case 1:
        return const Center(child: Text('Página 2'));
      case 2:
        return const Center(child: Text('Página 3'));
      default:
        return const Center(child: Text('Página 1'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2A1266), Color(0xFF150B2E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
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
                  Container(
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
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
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
            const SizedBox(height: 230),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  'Posts Amigos',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
            itemLabel: 'Página 1',
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
            itemLabel: 'Página 2',
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
            itemLabel: 'Página 3',
          ),
        ],
        onTap: _onItemTapped,
        notchColor: Color(0xFF42326A),
        showLabel: false,
        itemLabelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        bottomBarHeight: 70.0, // Adjust the height to make it more prominent
        elevation: 8.0, // Increased elevation for more prominent effect
        color: Color(0xff2C2247),
        durationInMilliSeconds: 300,
        showBlurBottomBar: false,
        kBottomRadius: 30,  // Adjust the bottom radius to make it more curved
        kIconSize: 24, // Adjust icon size for better fit
      ),
    );
  }
}
