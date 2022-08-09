import 'package:flutter/material.dart';
import 'view/home_page.dart';

var request =
    Uri.parse("https://api.hgbrasil.com/finance?format=json&key=4de16a13");
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
