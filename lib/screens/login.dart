import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlitfilms/controllers/authProvider.dart';
import 'package:starlitfilms/screens/register.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox.expand(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/loginFundo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Center(
                  child: Image.asset(
                    'assets/logoCompleta.png',
                    width: 400,
                    height: 300,
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(_emailController, 'Email'),
                    const SizedBox(height: 16),
                    _buildTextField(_passwordController, 'Senha', isPassword: true),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 121, 42, 84),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () async {
                          final email = _emailController.text;
                          final password = _passwordController.text;

                          if (email.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Email e senha não podem ser vazios'),
                              ),
                            );
                            return;
                          }
                          try {
                            await Provider.of<AuthProvider>(context, listen: false)
                                .login(email, password);
                            Navigator.of(context).pushReplacementNamed('/home');
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Falha ao fazer login: $error')),
                            );
                          }
                        },
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastro()));
                      },
                      child: const Text(
                        'Não tem uma conta? Registre-se',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
