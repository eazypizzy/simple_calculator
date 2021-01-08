import 'home.dart';
import 'package:flutter/material.dart';

// import 'dart:math';
void main(List<String> args) => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(primarySwatch: MaterialColor()),
      debugShowCheckedModeBanner: false,

      home: Home(),
    );
  }
}
