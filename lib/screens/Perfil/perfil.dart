import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlitfilms/controllers/authProvider.dart';
import 'package:starlitfilms/screens/homepage.dart'; // Certifique-se de que o caminho para HomePage está correto

class Perfil extends StatefulWidget {
  final String email;

  Perfil({Key? key, required this.email}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  late NotchBottomBarController _controller;
  int _selectedIndex = 1; // Define 1 como página inicial (Perfil)

  @override
  void initState() {
    super.initState();
    _controller = NotchBottomBarController();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    await Provider.of<AuthProvider>(context, listen: false).fetchUserDetails(widget.email);
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),  // Navega para HomePage ao selecionar "Página 1"
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2A1266), Color(0xFF150B2E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Conteúdo removido, mantendo apenas o gradiente
            Expanded(
              child: Center(
                child: Text(
                  'Perfil Limpo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
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
        bottomBarHeight: 70.0,
        elevation: 8.0,
        color: Color(0xff2C2247),
        durationInMilliSeconds: 300,
        showBlurBottomBar: false,
        kBottomRadius: 30,
        kIconSize: 24,
      ),
    );
  }
}
