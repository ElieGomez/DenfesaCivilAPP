// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, file_names, sized_box_for_whitespace

import 'package:defensacivilapp/screens/CajasDeTodo.dart';
import 'package:flutter/material.dart';

// ESTO ES PARA MOSTRAR el apartado de TODO pero con alguna pagina al lado para poder hacer

class TodosScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color.fromARGB(255, 12, 12, 12),
            elevation: 0,
            centerTitle: true,
            title: Text('Momentos favoritos',
                style: TextStyle(
                    color: Color.fromARGB(179, 255, 255, 255),
                    fontWeight: FontWeight.bold))),
        body: PageView(
          // physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [VistaTodos(), VistaTodos()],
        ));
  }
}

// Apartado en si con el background añadido personalizado
class VistaTodos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //background image
        Background(),
        CajasContent(
            imagePath: "assets/pruebaImg.png",
            name: "hola",
            description: "heos",
            videoPath: "assets/pruebaVideo.mkv"),
      ],
    );
  }
}

//background personalizado
class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(114, 51, 51, 1),
      alignment: Alignment.topCenter,
      // child:
      //     Image(image: AssetImage('assets/pruebaImg.png'), fit: BoxFit.cover),
    );
  }
}
