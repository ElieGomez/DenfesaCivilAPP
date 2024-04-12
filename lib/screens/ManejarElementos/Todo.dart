// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, file_names, sized_box_for_whitespace

import 'package:defensacivilapp/screens/ManejarElementos/CajasDeTodo.dart';
import 'package:flutter/material.dart';

import 'CajasModel.dart';

// class TodosScroll extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             iconTheme: IconThemeData(color: Colors.white),
//             backgroundColor: Color.fromARGB(255, 12, 12, 12),
//             elevation: 0,
//             centerTitle: true,
//             title: Text("$titulo",
//                 style: TextStyle(
//                     color: Color.fromARGB(179, 255, 255, 255),
//                     fontWeight: FontWeight.bold))),
//         body: PageView(
//           // physics: BouncingScrollPhysics(),
//           scrollDirection: Axis.horizontal,
//           children: [VistaTodos(), VistaTodos()],
//         ));
//   }
// }

class TodosScroll extends StatelessWidget {
  final String titulo;
  final List<Caja> listaCajas;

  const TodosScroll({
    Key? key,
    required this.titulo,
    required this.listaCajas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 12, 12, 12),
        elevation: 0,
        centerTitle: true,
        title: Text(
          titulo,
          style: TextStyle(
            color: Color.fromARGB(179, 255, 255, 255),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [VistaTodos(listaCajas: listaCajas)],
      ),
    );
  }
}

// Apartado en si con el background añadido personalizado
// Donde quiero pasarle la info y la cantidad de cajas que yo quiera a cajasContent

class VistaTodos extends StatelessWidget {
  final List<Caja> listaCajas;
  // List<Caja> myModelList = [
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
  //   ),
  //   Caja(
  //     imagePath: "assets/pruebaImg.png",
  //     name: "El mio",
  //     description: "heos",
  //     videoPath: "assets/pruebaVideo.mkv",
  //   )
  // ];
  const VistaTodos({
    Key? key,
    required this.listaCajas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        CajasContent(todasLasCajas: listaCajas),
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
