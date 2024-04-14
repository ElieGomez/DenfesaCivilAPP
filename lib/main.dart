// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:defensacivilapp/screens/AlberguesScreen.dart';
import 'package:defensacivilapp/screens/Configuracion.dart';
import 'package:defensacivilapp/screens/MapaAlberguesScreen.dart';
import 'package:defensacivilapp/screens/NewsEspecificas.dart';
import 'package:defensacivilapp/screens/ServiciosScreen.dart';
import 'package:defensacivilapp/screens/VideosScreen.dart';
import 'package:defensacivilapp/screens/VoluntarioScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/InicioScreen.dart';
import 'screens/Post-Login/token.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => AuthToken(),
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Defenza civil',
        routes: {
          '/servicios': (context) => ServiciosScreen(),
          '/videos': (context) => VideosScreen(),
          '/albergues': (context) => AlberguesScreen(),
          '/mapaalbergues': (context) => MapaAlberguesScreen(),
          '/inicio': (context) => InicioScreen(),
          '/serVoluntario': (context) => SingUp(),
          '/newsEspecificas': (context) => NoticiasEspecificas(),
          '/configuracion': (context) => ConfiguracionView()
        },
        home: InicioScreen());
  }
}
