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
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 24,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              myName,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              myId,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ),
      body: Text("Works"),
    );
  }
}
