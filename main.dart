
import 'package:first/main.dart';
import 'package:flutter/material.dart';
import 'package:first/HomePage.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  State<MyApp> createState()=> _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Homepage() ,
    );
  }
}


