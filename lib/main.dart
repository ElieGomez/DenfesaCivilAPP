// ignore_for_file: prefer_const_constructors

import 'package:defensacivilapp/screens/Todo.dart';
import 'package:flutter/material.dart';

import 'screens/Inicio.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Defenza civil',
        routes: {'/prueba': (context) => TodosScroll()},
        home: Inicio());
  }
}
