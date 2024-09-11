import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlitfilms/controllers/authProvider.dart';
import 'package:starlitfilms/screens/Perfil/editar_perfil.dart';


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
    final avatarUrl = authProvider.avatar ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
    final nome = widget.email; // Or fetch the actual name if needed

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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(avatarUrl), // Use NetworkImage with URL
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nome,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.email,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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
                              title: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
                              onTap: () async {
                                final responseEdit = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  EditarPerfil(),
                                  ),
                                );
                                if (responseEdit != null && responseEdit['imageUrl'] != null) {
                                  setState(() {
                                    // authProvider = responseEdit['imageUrl'];
                                  });
                                }
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.notifications, color: Colors.white),
                              title: const Text('Notifications', style: TextStyle(color: Colors.white)),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: const Icon(Icons.security, color: Colors.white),
                              title: const Text('Privacy Settings', style: TextStyle(color: Colors.white)),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: const Icon(Icons.help, color: Colors.white),
                              title: const Text('Help & Support', style: TextStyle(color: Colors.white)),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: const Icon(Icons.logout, color: Colors.white),
                              title: const Text('Logout', style: TextStyle(color: Colors.white)),
                              onTap: () {
                                
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
}
