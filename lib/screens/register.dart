import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlitfilms/controllers/authProvider.dart';
import 'package:starlitfilms/screens/homepage.dart';
import 'package:starlitfilms/screens/login.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _nameController = TextEditingController();
  final _avatarController = TextEditingController();
  final _usernameController = TextEditingController();  // Novo controller
  
  bool _obscurePassword = true;
  bool _obscurePasswordConfirm = true;
  String? _profileImageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/fundoLogin.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Image.asset(
                    'assets/logoCompleta.png',
                    width: 330,
                    height: 330,
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildTextField(_nameController, 'Nome', Icons.person),
                        const SizedBox(height: 20),
                        _buildTextField(_usernameController, 'Username', Icons.account_circle),  // Novo campo
                        const SizedBox(height: 20),
                        _buildTextField(_emailController, 'Email', Icons.email),
                        const SizedBox(height: 20),
                        _buildTextField(_passwordController, 'Senha', Icons.lock, isPassword: true),
                        const SizedBox(height: 20),
                        _buildTextField(_passwordConfirmController, 'Confirmar senha', Icons.lock, isPassword: true, isConfirm: true),
                        const SizedBox(height: 20),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: SizedBox(
                              width: 331,
                              height: 49,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_validateFields()) {
                                    await _showProfilePictureDialog();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF26174C), Color(0xFF5936B2)],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Criar Conta',
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const Login(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                                transitionDuration: const Duration(milliseconds: 500),
                              ),
                            );
                          },
                          child: RichText(
                            text: const TextSpan(
                              text: 'Já tem uma conta? ',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins",
                                color: Colors.white54,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: 'LOGIN',
                                  style: TextStyle(
                                    color: Color(0xFF7E56E4),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
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

  bool _validateFields() {
    if (_nameController.text.isEmpty ||
        _usernameController.text.isEmpty ||  // Validação do campo username
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _passwordConfirmController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Todos os campos devem ser preenchidos'),
        ),
      );
      return false;
    }

    if (_passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Insira uma senha com no mínimo 8 caracteres'),
        ),
      );
      return false;
    }

    if (_passwordController.text != _passwordConfirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('As senhas não coincidem'),
        ),
      );
      return false;
    }
    return true;
  }

  Future<void> _showProfilePictureDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Foto de Perfil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: _profileImageUrl != null && _profileImageUrl!.isNotEmpty
                    ? NetworkImage(_profileImageUrl!)
                    : AssetImage('assets/default_profile.png') as ImageProvider,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _avatarController,
                decoration: const InputDecoration(
                  labelText: 'URL da Imagem',
                  prefixIcon: Icon(Icons.link),
                ),
                onChanged: (value) {
                  setState(() {
                    _profileImageUrl = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _registerUser();
              },
              child: const Text('Continuar sem foto'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _registerUser();
              },
              child: const Text('Confirmar Foto'),
            ),
          ],
        );
      },
    );
  }

  void _registerUser() async {
    final name = _nameController.text;
    final username = _usernameController.text;  // Adicionado
    final email = _emailController.text;
    final password = _passwordController.text;
    final avatarUrl = _avatarController.text;

    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .register(name, username, email, password, avatarUrl);  // Passando o username
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao se registrar: $error')),
      );
    }
  }

  Widget _buildTextField(
    TextEditingController controller,
    String labelText,
    IconData icon, {
    bool isPassword = false,
    bool isConfirm = false,
  }) {
    return SizedBox(
      width: 331,
      height: 49,
      child: TextField(
        controller: controller,
        obscureText: isPassword ? (isConfirm ? _obscurePasswordConfirm : _obscurePassword) : false,
        style: const TextStyle(
          fontFamily: "Poppins",
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            fontFamily: "Poppins",
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(icon, color: Colors.white),
          ),
          filled: true,
          fillColor: const Color(0xFF5936B2).withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
