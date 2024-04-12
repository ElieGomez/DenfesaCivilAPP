// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

import '../Detalles.dart';
import 'CajasModel.dart';

class CajasContent extends StatefulWidget {
  final List<Caja> todasLasCajas;

  const CajasContent({
    Key? key,
    required this.todasLasCajas,
  }) : super(key: key);

// apartado que incrusta las cajas
  @override
  State<CajasContent> createState() => _CajasContentState();

  static Widget _buildPhotoCard(BuildContext context, String imagePath,
      String name, String description, String videoPath) {
    return Material(
      color: Color.fromARGB(255, 255, 253, 253),
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

// Cajas que reciben los parametros
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
              // Usar un ListView.builder para recorrer la lista de objetos y mostrar las cajas
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.todasLasCajas.length,
                itemBuilder: (context, index) {
                  // Obtener el objeto en la posición actual
                  Caja item = widget.todasLasCajas[index];
                  // Construir y retornar una caja utilizando los datos del objeto
                  return CajasContent._buildPhotoCard(
                    context,
                    item.imagePath,
                    item.name,
                    item.description,
                    item.videoPath,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
