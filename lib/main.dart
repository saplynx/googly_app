import 'package:flutter/material.dart';
import 'package:googly_app/Home.dart';

void main() {
  runApp(const MyApp());
}

class TempContext {
  static late BuildContext context;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TempContext.context = context;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Googly'
        ),
      ),
      body: Home(),
    );
  }
}
