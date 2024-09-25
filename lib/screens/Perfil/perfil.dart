import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlitfilms/controllers/authProvider.dart';
import 'package:starlitfilms/screens/entrar.dart';

class Perfil extends StatefulWidget {
  final String email;

  Perfil({Key? key, required this.email}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    await Provider.of<AuthProvider>(context, listen: false).fetchUserDetails(widget.email);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final avatarUrl = authProvider.avatar ?? 
        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
    final nome = authProvider.nome ?? widget.email;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/homeFundo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(avatarUrl),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nome,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                             const SizedBox(height: 4),
                            Container(
                              width: 200, 
                              height: 0.8,
                              color: Colors.white, 
                            ),
                            const SizedBox(height: 8), 
                            Text(
                              widget.email,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: ListView.separated(
                        itemCount: 5,
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.white30,
                          thickness: 1,
                          height: 20,
                        ),
                        itemBuilder: (context, index) {
                          List<Widget> options = [
                            ListTile(
                              leading: const Icon(Icons.edit, color: Colors.white),
                              title: const Text('Editar Perfil', style: TextStyle(color: Colors.white)),
                              onTap: () {
                                _showEditProfileDialog(context, authProvider);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.notifications, color: Colors.white),
                              title: const Text('Notificações', style: TextStyle(color: Colors.white)),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: const Icon(Icons.security, color: Colors.white),
                              title: const Text('Configurações de Privacidade', style: TextStyle(color: Colors.white)),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: const Icon(Icons.help, color: Colors.white),
                              title: const Text('Ajuda e Suporte', style: TextStyle(color: Colors.white)),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: const Icon(Icons.logout, color: Colors.white),
                              title: const Text('Logout', style: TextStyle(color: Colors.white)),
                              onTap: () async {
                                bool? shouldLogout = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.black,
                                      title: const Text(
                                        'Confirmar Logout',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      content: const Text(
                                        'Você tem certeza de que deseja sair?',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                        ),
                                        const Divider(
                                          color: Colors.white30,
                                          thickness: 1,
                                        ),
                                        TextButton(
                                          child: const Text('Sair', style: TextStyle(color: Colors.redAccent)),
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (shouldLogout == true) {
                                  authProvider.logout();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Entrar()),
                                  );
                                }
                              },
                            ),
                          ];
                          return options[index];
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, AuthProvider authProvider) {
    final TextEditingController _nomeController = TextEditingController(text: authProvider.nome);
    final TextEditingController _avatarController = TextEditingController(text: authProvider.avatar);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text('Editar Perfil', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nomeController,
                style: const TextStyle(color: Color.fromARGB(188, 219, 219, 219)), 
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(color: Colors.white), 
                ),
              ),
              TextField(
                controller: _avatarController,
                style: const TextStyle(color: Color.fromARGB(188, 219, 219, 219)),
                decoration: const InputDecoration(
                  labelText: 'URL do Avatar',
                  labelStyle: TextStyle(color: Colors.white), 
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Salvar', style: TextStyle(color: Colors.redAccent)),
              onPressed: () {
                authProvider.updateNome(_nomeController.text);
                authProvider.updateAvatar(_avatarController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
