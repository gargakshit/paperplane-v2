import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:paperplane/screens/home/chatScreen.dart';

class HomePage extends StatefulWidget {
  final String name;
  final bool hasPfp;
  final String pfpPath;

  HomePage({this.name, this.hasPfp, this.pfpPath});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9999),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey[400]
                        : Colors.grey[900],
                    blurRadius: 8,
                  ),
                ],
              ),
              child: !widget.hasPfp
                  ? Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Center(
                        child: Text(
                          widget.name.substring(0, 1).toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).canvasColor,
                          ),
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(9999),
                      child: Image.file(
                        File(widget.pfpPath),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              "PaperPlane",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) => setState(() => currentItem = i),
        currentIndex: currentItem,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Feather.message_square),
            title: Text("Chat"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.users),
            title: Text("Contacts"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.settings),
            title: Text("Settings"),
          ),
        ],
      ),
      body: IndexedStack(
        index: currentItem,
        children: [
          ChatScreen(),
          Center(
            child: Text("Contacts"),
          ),
          Center(
            child: Text("Settings"),
          ),
        ],
      ),
    );
  }
}