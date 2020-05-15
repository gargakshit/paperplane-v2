import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:paperplane/screens/chat/newChat.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Home"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NewChatScreen(),
            ),
          );
        },
        icon: Icon(
          Feather.plus,
          color: Theme.of(context).canvasColor,
        ),
        label: Text(
          "NEW CHAT",
          style: TextStyle(
            color: Theme.of(context).canvasColor,
          ),
        ),
      ),
    );
  }
}
