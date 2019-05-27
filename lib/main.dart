import 'package:flutter/material.dart';
import 'package:mombook/pages/setup/welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MomBook',
      theme:ThemeData(
        primaryColor: Colors.blue
      ) ,
      home: Scaffold(
        body: Center(
          child: WelcomePage(),
        ),
      ),
    );
  }
}
