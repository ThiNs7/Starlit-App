import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlitfilms/controllers/authProvider.dart';
import 'package:starlitfilms/screens/homepage.dart';
import 'package:starlitfilms/screens/login.dart';

class Cadastro extends StatelessWidget {
  Cadastro({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _nameController = TextEditingController();
  final _avatarController = TextEditingController();

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  Center(
                    child: Image.asset(
                      'assets/logoCompleta.png',
                      width: 330,
                      height: 330,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildTextField(_nameController, 'Nome', Icons.person),
                        const SizedBox(height: 30),
                        _buildTextField(_emailController, 'Email', Icons.email),
                        const SizedBox(height: 30),
                        _buildTextField(_passwordController, 'Senha', Icons.lock, isPassword: true),
                        const SizedBox(height: 30),
                        _buildTextField(_passwordConfirmController, 'Confirmar senha', Icons.lock, isPassword: true),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 331,
                          height: 49,
                          child: ElevatedButton(
                            onPressed: () async {
                              final name = _nameController.text;
                              final email = _emailController.text;
                              final password = _passwordController.text;
                              final confirmPassword = _passwordConfirmController.text;
                              final avatarUrl = _avatarController.text;

                              if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Todos os campos devem ser preenchidos'),
                                  ),
                                );
                                return;
                              }

                              if (password.length < 8) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Insira uma senha com no mínimo 8 caracteres'),
                                  ),
                                );
                                return;
                              }

                              if (password != confirmPassword) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('As senhas não coincidem'),
                                  ),
                                );
                                return;
                              }

                              try {
                                await Provider.of<AuthProvider>(context, listen: false)
                                    .register(name, email, password, avatarUrl);

                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                );
                              } catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Falha ao se registrar: $error')),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                // Remove a borda branca
                                side: BorderSide.none,
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
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            // Navegação para a tela de login usando PageRouteBuilder para animação
                            Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => const Login(),
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
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, IconData icon, {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF5936B2).withOpacity(0.2), // Define a mesma cor do campo de login
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
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
}
