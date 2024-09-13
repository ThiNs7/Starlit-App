import 'package:flutter/material.dart';



class Amigo {
  final String nome;
  final String status;
  final String fotoUrl;
  final String description;

  Amigo({required this.nome, required this.status, required this.fotoUrl, required this.description});
}

void main() {
  runApp(MaterialApp(
    home: AmigosPage(),
  ));
}


class AmigosPage extends StatelessWidget {
  // Lista de amigos de exemplo
  final List<Amigo> amigos = [
    
    Amigo(
      nome: 'thiago',
      status: 'Online',
      fotoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4WJlo6N2ZW9EA8THbrW-v-1sTmeTIU-r9Yg&s',
      description: 'urfuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu',

      
    ),
    Amigo(
      nome: 'EDUARDO',
      status: 'Offline',
      fotoUrl: 'https://media.tenor.com/FnQ8dh_evjgAAAAe/eduardo-eduardo-dog.png',
      description: 'OLAMAHAAAAAAAAAAAAAAAA',
    ),
    Amigo(
      nome: 'Miranda',
      status: 'Online',
      fotoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSi9DDAU7UdHBbJhp7tmZ_4qOuhbOaTYdBX8Q&s',
      description: "OLAMAHAAAAAAAAAAAAAAA",
    ),
     Amigo(
      nome: 'Sales',
      status: 'Offline',
      fotoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Sassoferrato_-_Jungfrun_i_b%C3%B6n.jpg/800px-Sassoferrato_-_Jungfrun_i_b%C3%B6n.jpg',
      description: "OLAMAHAAAAAAAAAAAAAAA",
     ),
      Amigo(
      nome: 'Guelmi',
      status: 'Online',
      fotoUrl: 'https://i.redd.it/pto29lmksakb1.jpg',
      description: "OLAMAHAAAAAAAAAAAAAAA",
     ),
      Amigo(
      nome: 'Kyk',
      status: 'Offline',
      fotoUrl: 'https://pbs.twimg.com/media/GUFvwwFW4AAI_ld.jpg:large',
      description: "OLAMAHAAAAAAAAAAAAAAA",
     ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[800],
      appBar: AppBar(
        backgroundColor: Color(0xFF8C3061),

      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8C3061),
              Color(0xFF522258),
            ],
          ),
        ),
        child: ListView.builder(  
          itemCount: amigos.length,
          itemBuilder: (context, index) {
            final amigo = amigos[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(amigo.fotoUrl),
              ),
              title: Text(amigo.nome),
              subtitle: Text(amigo.status),
              
              onTap: () {
                _mostrarDetalhes(context, amigo);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
       
          print('Adicionar amigo');
        },
        child: Icon(Icons.person_add),
      ),
    );
  }


  void _mostrarDetalhes(BuildContext context, Amigo amigo) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor:  Colors.black,
        contentPadding: EdgeInsets.zero, 
      
        content: Stack(
          children: [
           

            Container(
              width: double.infinity,
              height: 380, 
              
  
            ),
           
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(amigo.fotoUrl),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    amigo.nome,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, 
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    amigo.status,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    child:
                    Text(
                    amigo.description,
                    style: const TextStyle(color: Colors.white,),
                    
                    ),
                  )
                  
                  
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Fechar',
              style: TextStyle(color: Colors.white), 
            ),
          ),
        ],
      );
    },
  );}
}