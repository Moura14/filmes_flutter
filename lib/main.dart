import 'package:flutter/material.dart';
import 'package:project_flutter/core/injection/injection.dart';
import 'package:project_flutter/feature/filmes/presentation/pages/home.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filmes',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  HomeScreen()
    );
  }
}


