// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_app_fashion/screens/introduct_screen.dart';
import 'package:flutter_app_fashion/screens/landing_page.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroductScreen(),
    );
  }
}
