import 'package:flutter/material.dart';

class MyProfileScreen extends StatelessWidget {
  final String myName;
  final String myId;

  MyProfileScreen({
    @required this.myName,
    @required this.myId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, i) => [
          Text("hm"),
        ][i],
      ),
    );
  }
}
