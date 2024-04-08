// ignore_for_file: prefer_const_constructors

import 'package:defensacivilapp/screens/WagnerEsGei.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Defenza civil', home: ElGei());
  }
}
