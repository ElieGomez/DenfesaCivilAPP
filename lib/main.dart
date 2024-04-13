// ignore_for_file: prefer_const_constructors

import 'package:defensacivilapp/screens/AlberguesScreen.dart';
import 'package:defensacivilapp/screens/MapaAlberguesScreen.dart';
import 'package:defensacivilapp/screens/ServiciosScreen.dart';
import 'package:defensacivilapp/screens/VideosScreen.dart';
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
        routes: {'/servicios': (context) => ServiciosScreen(), 
                 '/videos':(context) => VideosScreen(),
                 '/albergues':(context) => AlberguesScreen(),
                 '/mapaalbergues':(context) => MapaAlberguesScreen(),
                },
        home: Inicio());
  }
}
