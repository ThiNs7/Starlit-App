import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlitfilms/controllers/authProvider.dart';
import 'package:starlitfilms/screens/entrar.dart';

class EditarPerfil extends StatefulWidget {
  const EditarPerfil({super.key});

  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> with TickerProviderStateMixin {
  late TextEditingController _nomeController;
  late TextEditingController _descricaoController;
  late TextEditingController _avatarController;

  late AnimationController _animationController;
  late Animation<Offset> _imageAnimation;
  late AnimationController _profilePicAnimationController;
  late Animation<Offset> _profilePicAnimation;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _nomeController = TextEditingController(text: authProvider.nome);
    _descricaoController = TextEditingController(text: authProvider.descricao);
    _avatarController = TextEditingController(text: authProvider.avatar);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _imageAnimation = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _profilePicAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _profilePicAnimation = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(CurvedAnimation(
      parent: _profilePicAnimationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
    _profilePicAnimationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _profilePicAnimationController.dispose();
    _nomeController.dispose();
    _descricaoController.dispose();
    _avatarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2A1266), Color(0xFF150B2E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _imageAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _imageAnimation.value.dy * 150),
                  child: child,
                );
              },
              child: Image.asset(
                '../assets/detalheEditarPerfil.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
                Positioned(
              top: screenHeight * 0.13,
              left: screenWidth / 2 - 80,
              child: AnimatedBuilder(
                animation: _profilePicAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _profilePicAnimation.value.dy * 100),
                    child: child,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3), // Cor da sombra
                        blurRadius: 10, // Desfoque da sombra
                        offset: const Offset(0, 5), // Posição da sombra
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(authProvider.avatar ?? 'https://example.com/user_avatar.jpg'),
                  ),
                ),
              ),
            ),
          Positioned(
            top: screenHeight * 0.5,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField("Nome", _nomeController, (value) {
                    authProvider.updateNome(value);
                  }, Icons.person),

                  const SizedBox(height: 40),

                  _buildTextField("Descrição", _descricaoController, (value) {
                    authProvider.updateDescricao(value);
                  }, Icons.description),

                  const SizedBox(height: 40),

                  _buildTextField("Avatar", _avatarController, (value) {
                    authProvider.updateAvatar(value);
                  }, Icons.image),

                  const SizedBox(height: 20),

                  Center(
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          _salvarAlteracoes(authProvider);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff7E56E4),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 10,
                        ),
                        child: const Text(
                          'Salvar',
                          style: TextStyle(fontSize: 20, color: Color(0xffffffff), fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  const Divider(
                    color: Colors.white54,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth * 0.3,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () {
                              _showLogoutDialog(context, authProvider);
                            },
                            child: const Text(
                              'Sair',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xffFE2137),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        const Text(
                          'Trocar Conta',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff7E56E4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, Function(String) onChanged, IconData icon) {
    return SizedBox(
      width: 400,
      height: 49,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          fontFamily: "Poppins",
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontFamily: "Poppins",
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(icon, color: Colors.white70),
          ),
          filled: true,
          fillColor: const Color(0xFF5936B2).withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  void _salvarAlteracoes(AuthProvider authProvider) {
    authProvider.updateNome(_nomeController.text);
    authProvider.updateDescricao(_descricaoController.text);
    authProvider.updateAvatar(_avatarController.text);

    authProvider.saveProfileChanges();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alterações salvas com sucesso!'), backgroundColor: const Color(0xff7E56E4),),
    );
     
  }
  

void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
            .animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        )),
        child: Dialog(
          backgroundColor: const Color(0xFF150B2E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  '../assets/icon_door.png',
                  width: 60,
                  height: 60,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Oh não! Você está saindo...\nTem certeza?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Nah, to só brincando',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff7E56E4),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0, 
                      horizontal: 24.0, 
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    authProvider.logout();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Entrar()),
                    );
                  },
                  child: const Text(
                    'Sim, desconecte-me',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
}
