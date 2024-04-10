// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';

import 'Drawer.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(
            255, 255, 255, 255), // Cambio de color de fondo a negro
        drawer: DrawerContent(),
        drawerScrimColor: Colors.white
            .withOpacity(0.4), // Cambio de opacidad del scrim del cajón lateral
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor:
              Colors.black, // Cambio de color de fondo de la AppBar a negro
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Defenza civil',
            style: TextStyle(
              color: Colors
                  .white, // Cambio de color del texto de la AppBar a blanco
              fontWeight: FontWeight.bold,
            ),
          ),
          shadowColor: Colors.black
              .withOpacity(0.5), // Agregar una sombra suave a la AppBar
        ));
  }
}
