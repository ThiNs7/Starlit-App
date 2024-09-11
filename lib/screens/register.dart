import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlitfilms/controllers/authProvider.dart';
import 'package:starlitfilms/screens/homepage.dart';


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
                  image: AssetImage('assets/loginFundo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Image.asset(
                    'assets/logoCompleta.png',
                    width: 300,
                    height: 300,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(0, 0, 0, 0).withOpacity(0.7),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'REGISTRAR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(_nameController, 'Nome'),
                      const SizedBox(height: 16),
                      _buildTextField(_emailController, 'Email'),
                      const SizedBox(height: 16),
                      _buildTextField(_passwordController, 'Senha', isPassword: true),
                      const SizedBox(height: 16),
                      _buildTextField(_passwordConfirmController, 'Confirmar senha', isPassword: true),
                      const SizedBox(height: 16),
                      _buildTextField(_avatarController, 'URL do Avatar'), // Campo para a URL do avatar
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 121, 42, 84),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: () async {
                            final name = _nameController.text;
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            final confirmPassword = _passwordConfirmController.text;
                            final avatarUrl = _avatarController.text;

                            if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty || avatarUrl.isEmpty) {
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
                                  builder: (context) => const HomePage(
                                   
                                  ),
                                ),
                              );
                            } catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Falha ao se registrar: $error')),
                              );
                            }
                          },
                          child: const Text(
                            'REGISTRAR',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Color.fromARGB(255, 121, 42, 84)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Color.fromARGB(255, 121, 42, 84), width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Color.fromARGB(255, 121, 42, 84), width: 2.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        style: const TextStyle(color: Color.fromARGB(255, 121, 42, 84)),
      ),
    );
  }
}
