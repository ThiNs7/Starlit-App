import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlitfilms/controllers/authProvider.dart';

class EditarPerfil extends StatelessWidget {
  final TextEditingController _avatarController = TextEditingController();

  EditarPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _avatarController,
              decoration: const InputDecoration(labelText: 'URL do novo Avatar'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newAvatarUrl = _avatarController.text;
                Provider.of<AuthProvider>(context, listen: false).updateAvatar(newAvatarUrl);
                Navigator.pop(context, {'imageUrl': newAvatarUrl});
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
