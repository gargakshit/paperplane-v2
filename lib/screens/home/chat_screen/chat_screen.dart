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
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Feather.user),
                  title: Text("New Chat"),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 24),
                ),
                ListTile(
                  leading: Icon(Feather.users),
                  title: Text("New Group"),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 24),
                ),
                ListTile(
                  leading: Icon(FontAwesome.qrcode),
                  title: Text("Scan QR Code"),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 24),
                ),
                Container(
                  height: MediaQuery.of(context).padding.bottom,
                ),
              ],
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
