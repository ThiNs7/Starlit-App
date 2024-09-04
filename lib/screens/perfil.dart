import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  const Perfil({Key? key}) : super(key: key);

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
                    
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/profile_picture.png'),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SongBreeze',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'songbreeze@example.com',
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
                              onTap: () {
                                
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.notifications, color: Colors.white),
                              title: const Text('Notifications', style: TextStyle(color: Colors.white)),
                              onTap: () {
                              
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.security, color: Colors.white),
                              title: const Text('Privacy Settings', style: TextStyle(color: Colors.white)),
                              onTap: () {
                              
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.help, color: Colors.white),
                              title: const Text('Help & Support', style: TextStyle(color: Colors.white)),
                              onTap: () {
                                
                              },
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
