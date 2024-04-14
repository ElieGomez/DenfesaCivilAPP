// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
    // List<Caja> myModelList = [
    //   Caja(
    //     imagePath: "assets/elgei.png",
    //     name: "Elclitori",
    //     description: "heos",
    //     videoPath: "",
    //   ),
    //   Caja(
    //     imagePath: "assets/pruebaImg.png",
    //     name: "El mio",
    //     description: "heos",
    //     videoPath: "assets/pruebaVideo.mkv",
    //   ),
    //   Caja(
    //     imagePath: "assets/pruebaImg.png",
    //     name: "El mio",
    //     description: "heos",
    //     videoPath: "assets/pruebaVideo.mkv",
    //   ),
    //   Caja(
    //     imagePath: "assets/pruebaImg.png",
    //     name: "El mio",
    //     description: "heos",
    //     videoPath: "assets/pruebaVideo.mkv",
    //   )
    // ];
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Defenza civil',
        routes: {'/servicios': (context) => ServiciosScreen(), 
                 '/videos':(context) => VideosScreen(),
                 '/albergues':(context) => AlberguesScreen(),
                 '/mapaalbergues':(context) => MapaAlberguesScreen(),
                 '/home':(context) => Inicio(),
                },
        home: Inicio());
  }
}
