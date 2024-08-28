import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starlitfilms/components/styles.dart';
import 'package:starlitfilms/screens/login.dart';
import 'package:starlitfilms/screens/register.dart';

class Entrar extends StatelessWidget {
  const Entrar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fundoPrimeiro.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/logoCompleta.png',
                  height: 300,
                  width: 300,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(0, 0, 0, 0).withOpacity(0.6),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 50),
                    child: Text(
                      "JUNTE-SE A NÓS",
                      style: txtSans(35, Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Login()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent, 
                          padding: const EdgeInsets.symmetric(vertical: 15), 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(
                              color: Color.fromARGB(255, 121, 42, 84),
                              width: 2, 
                            ),
                          ),
                        ),
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(
                            color: Color.fromARGB(255, 121, 42, 84),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Cadastro()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent, 
                          padding: const EdgeInsets.symmetric(vertical: 15), 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(
                              color: Color.fromARGB(255, 121, 42, 84), 
                              width: 2, 
                            ),
                          ),
                        ),
                        child:  Text(
                          "REGISTRAR",
                          style: txtSans(20, const Color.fromARGB(255, 121, 42, 84),)
                          ), 
                        ),
                      ),
                    ),
                  ]),
        )],
              ),
            ),
    );
  }
}
