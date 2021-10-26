
import 'package:flutter/material.dart';
import 'package:api_app/home_page.dart';
import 'home_page.dart';

void main() async {
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:  ThemeData(primarySwatch: Colors.deepPurple),
      home: HomePage(),
    );
  }
}

