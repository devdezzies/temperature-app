import 'package:flutter/material.dart';
import 'package:temperature/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Quicksand',
        useMaterial3: true
      ),
      debugShowCheckedModeBanner: false,
      home: const Home()
    );
  }
}