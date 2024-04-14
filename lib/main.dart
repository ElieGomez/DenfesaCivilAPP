// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:defensacivilapp/screens/AlberguesScreen.dart';
import 'package:defensacivilapp/screens/Configuracion.dart';
import 'package:defensacivilapp/screens/MapaAlberguesScreen.dart';
import 'package:defensacivilapp/screens/Post-Login/MapaSituaciones.dart';
import 'package:defensacivilapp/screens/Post-Login/NewsEspecificas.dart';
import 'package:defensacivilapp/screens/Post-Login/ReportSituaciones.dart';
import 'package:defensacivilapp/screens/Post-Login/Situaciones.dart';
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
          '/inicio': (context) => InicioScreen(),
          '/servicios': (context) => ServiciosScreen(),
          '/newsEspecificas': (context) => NoticiasEspecificas(),
          '/videos': (context) => VideosScreen(),
          '/albergues': (context) => AlberguesScreen(),
          '/mapaalbergues': (context) => MapaAlberguesScreen(),
          '/serVoluntario': (context) => SingUp(),
          '/situaciones': (context) => Situaciones(),
          '/reportSituaciones': (context) => Report(),
          '/mapadesituaciones': (context) => MapaSituaciones(),
          '/configuracion': (context) => ConfiguracionView(),
        },
        home: InicioScreen());
  }
}
