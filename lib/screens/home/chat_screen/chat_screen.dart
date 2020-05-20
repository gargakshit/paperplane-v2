import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Home"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
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
