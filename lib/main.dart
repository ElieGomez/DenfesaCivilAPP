// ignore_for_file: prefer_const_constructors

import 'package:defensacivilapp/screens/ManejarElementos/Todo.dart';
import 'package:flutter/material.dart';

import 'screens/Inicio.dart';
import 'screens/ManejarElementos/CajasModel.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<Caja> myModelList = [
      Caja(
        imagePath: "assets/pruebaImg.png",
        name: "Elclitori",
        description: "heos",
        videoPath: "",
      ),
      Caja(
        imagePath: "assets/pruebaImg.png",
        name: "El mio",
        description: "heos",
        videoPath: "assets/pruebaVideo.mkv",
      ),
      Caja(
        imagePath: "assets/pruebaImg.png",
        name: "El mio",
        description: "heos",
        videoPath: "assets/pruebaVideo.mkv",
      ),
      Caja(
        imagePath: "assets/pruebaImg.png",
        name: "El mio",
        description: "heos",
        videoPath: "assets/pruebaVideo.mkv",
      )
    ];
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Defenza civil',
        routes: {
          '/prueba': (context) => TodosScroll(
                listaCajas: myModelList,
                titulo: 'Servicios',
              )
        },
        home: Inicio());
  }
}
