import 'package:flutter/material.dart';

class FAB extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  final Color bcolor;
  final Color fcolor;

  const FAB({this.onPressed, this.buttonText, this.bcolor, this.fcolor});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          onPressed(this.buttonText);
        },
        backgroundColor: this.bcolor,
        foregroundColor: this.fcolor,
        child: new Text(this.buttonText,
            textAlign: TextAlign.end, style: new TextStyle(fontSize: 15.0)));
  }
}
