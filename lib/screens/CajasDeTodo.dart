// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

import 'Detalles.dart';

class CajasContent extends StatefulWidget {
  final String imagePath;
  final String name;
  final String description;
  final String videoPath;

  // const CajasContent({Key? key}) : super(key: key);
  const CajasContent({
    Key? key,
    required this.imagePath,
    required this.videoPath,
    required this.name,
    required this.description,
    // required this.description,
  }) : super(key: key);

  @override
  State<CajasContent> createState() => _CajasContentState();

  static Widget _buildPhotoCard(BuildContext context, String imagePath,
      String name, String description, String videoPath) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Detalles(
                      imagePath: imagePath,
                      name: name,
                      description: description,
                      videoPath: videoPath,
                    )),
          );
          // Aquí puedes definir la acción al hacer clic en la foto
        },
        child: Column(
          children: [
            Image.asset(
              imagePath,
              width: 300,
              height: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 15),
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class _CajasContentState extends State<CajasContent> {
// LLENANDO LAS CAJAS CON LA INFO QUE CONSEGUI Y PASANDOSELA / ESTRUCTURA DONDE ESTAN LAS CAJAS
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              CajasContent._buildPhotoCard(context, widget.imagePath,
                  widget.name, widget.description, widget.videoPath),
              SizedBox(height: 30),
              CajasContent._buildPhotoCard(
                  context,
                  'assets/elgei.png',
                  'Wagner el gei',
                  '''El Planeta Miller donde 1 hora en es igual a 7 años en la Tierra, Es un mundo oceánico fascinante donde el tiempo transcurre de manera excepcionalmente dilatada en comparación con la Tierra. Cada hora en Miller equivale a siete años terrestres, lo que crea un fenómeno temporal desconcertante y único. ''',
                  '2'),
              SizedBox(height: 30),
              CajasContent._buildPhotoCard(
                  context,
                  'assets/elgei.png',
                  'Eliezer el',
                  'La emocionante travesia de intentar salvar la raza de la humanidad al conquistar otros planetas.',
                  '3'),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
