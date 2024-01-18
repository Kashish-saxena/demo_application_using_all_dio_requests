import 'package:api_project/screens/home_screen.dart';
import 'package:api_project/screens/register_screen.dart';
import 'package:api_project/screens/update_screen.dart';
import 'package:api_project/screens/user_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white, background: Colors.white),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
