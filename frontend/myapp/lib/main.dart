import 'package:flutter/material.dart';
import 'package:myapp/Pages/Homepage.dart';
import 'package:myapp/Pages/Loginpage.dart';
import 'package:myapp/Pages/welcomepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Welcomepage() ,
    );
  }
}
