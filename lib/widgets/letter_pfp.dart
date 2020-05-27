import 'package:flutter/material.dart';

class LetterPfp extends StatelessWidget {
  final String name;
  final double size;

  LetterPfp({this.name, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(9999),
      ),
      width: size,
      height: size,
      child: Center(
        child: Text(
          name.substring(0, 1).toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Theme.of(context).canvasColor,
            fontSize: size / 3,
          ),
        ),
      ),
    );
  }
}
