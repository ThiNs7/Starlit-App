import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlitfilms/controllers/authProvider.dart';
import 'package:starlitfilms/screens/register.dart';
import 'package:starlitfilms/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true; // Estado para controlar a visibilidade da senha

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fundoLogin.png'),
            fit: BoxFit.cover,
          ),
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
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  _buildTextField(_emailController, 'Email', Icons.email),
                  const SizedBox(height: 30),
                  _buildPasswordField(),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Lógica para recuperar senha
                      },
                      child: const Text(
                        'Esqueceu sua senha?',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2), // Cor da sombra
                            spreadRadius: 2, // Espalhamento da sombra
                            blurRadius: 5, // Desfoque da sombra
                            offset: Offset(0, 3), // Offset da sombra (x, y)
                          ),
                        ],
                      ),
                      child: SizedBox(
                        width: 331,
                        height: 49,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _login,
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
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      strokeWidth: 3,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    )
                                  : const Text(
                                      'Log in',
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
                      // Navegação para a tela de registro usando PageRouteBuilder para animação
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => Cadastro(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                          
                        },
                        transitionDuration: const Duration(milliseconds: 500),
                      ));
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: 'Não tem uma conta? ',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: 'REGISTRAR',
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
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, IconData icon) {
    return SizedBox(
      width: 331,
      height: 49,
      child: TextField(
        controller: controller,
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
            padding: const EdgeInsets.symmetric(horizontal: 12.0), // Espaçamento
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

  Widget _buildPasswordField() {
    return SizedBox(
      width: 331,
      height: 49,
      child: TextField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        style: const TextStyle(
          fontFamily: "Poppins",
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: 'Senha',
          labelStyle: const TextStyle(
            fontFamily: "Poppins",
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0), // Espaçamento
            child: Icon(Icons.lock, color: Colors.white70),
          ),
          filled: true,
          fillColor: const Color(0xFF5936B2).withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility, // Inverte a lógica
              color: Colors.white70,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword; // Alterna a visibilidade
              });
            },
          ),
        ),
      ),
    );
  }

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email e senha não podem ser vazios'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _performLogin(email, password);
  }

  void _performLogin(String email, String password) async {
  setState(() { _isLoading = true; });

  try {
    var tryLogin = await Provider.of<AuthProvider>(context, listen: false).login(email, password);
    if (tryLogin) {
      // Armazena o token após o login
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', Provider.of<AuthProvider>(context, listen: false).authToken);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login realizado com sucesso!'), backgroundColor: const Color(0xff7E56E4)),
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha no login. Tente novamente.'), backgroundColor: Colors.red),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao fazer login: $e'), backgroundColor: Colors.red),
    );
  } finally {
    setState(() { _isLoading = false; });
  }
}
}