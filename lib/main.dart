import 'package:flutter/material.dart';
import 'package:weather_application/views/HomeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.blueGrey[900],
      ),
      home: MyHomePage(),
    );
  }
}

