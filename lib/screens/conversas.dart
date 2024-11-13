import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'amigos.dart';  // Verifique a importação

class ChatPage extends StatefulWidget {
  final String nome;
  final String fotoUrl;
  final Amigo amigo;  // Agora o objeto Amigo é passado corretamente

  const ChatPage({
    required this.nome,
    required this.fotoUrl,
    required this.amigo,  // O objeto amigo é passado
    Key? key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();
  bool _isEmojiVisible = false;
  List<String> messages = [];

  // Função que lida com a seleção de emojis
  void _onEmojiSelected(Emoji emoji) {
    setState(() {
      _messageController.text += emoji.emoji;  // Adiciona emoji ao campo de texto
    });
  }

  // Função de backspace para apagar o último caractere
  void _onBackspacePressed() {
    setState(() {
      _messageController.text = _messageController.text.characters.skipLast(1).toString();  // Remove último caractere
    });
  }

  // Função para enviar a mensagem
  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add(_messageController.text);  // Adiciona a mensagem na lista
        _messageController.clear();  // Limpa o campo de texto
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.fotoUrl),
            ),
            const SizedBox(width: 10),
            Text(widget.nome),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 99, 96, 248),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),  // Exibe as mensagens
                );
              },
            ),
          ),
          if (_isEmojiVisible)  // Exibe o seletor de emojis
            SizedBox(
              height: 250,
              child: EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  _onEmojiSelected(emoji);  // Seleciona emoji
                },
                config: const Config(
                  columns: 7,  // Número de colunas no grid de emojis
                  emojiSizeMax: 32 * (1.0),  // Tamanho do emoji
                  verticalSpacing: 0,
                  horizontalSpacing: 0,
                  gridPadding: EdgeInsets.zero,
                  initCategory: Category.RECENT,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(_isEmojiVisible ? Icons.keyboard : Icons.emoji_emotions),
                  onPressed: () {
                    setState(() {
                      _isEmojiVisible = !_isEmojiVisible;  // Alterna a visibilidade do emoji
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Digite uma mensagem...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,  // Envia a mensagem
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
