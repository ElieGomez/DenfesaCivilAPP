// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names

import 'package:defensacivilapp/screens/Detalles/Detalles.dart';
import 'package:flutter/material.dart';

import 'Apartados Data/Historia.dart';
import 'Apartados Data/MedidasPreventivas.dart';
import 'Apartados Data/Miembros.dart';
import 'Apartados Data/Noticias.dart';
import 'Apartados Data/Servicios.dart';
import 'Apartados Data/Videos.dart';
import 'ManejarElementos/CajasModel.dart';
import 'ManejarElementos/PonerElementosACajas.dart';

class DrawerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Color.fromARGB(255, 0, 0, 0).withGreen(0.8),
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            height: 250,
            color: Color.fromARGB(255, 0, 0, 0),
            child: CircleAvatar(
              radius: 200, // Tamaño del círculo
              backgroundImage: AssetImage(
                  'assets/ImageHistoria/DefenzaCivil.png'), // Ruta de la imagen
            ),
          ),
          Center(
            child: ListTile(
              title: Text(
                "Defenza Civil",
                textAlign: TextAlign.center, // Alinea el texto al centro
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home,
                color: Color.fromARGB(
                    255, 255, 255, 255)), // Ajuste del color del icono
            title: Text("Inicio",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            onTap: () {
              Navigator.pushNamed(context, '/PortadaYPersonajes');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people,
                color: Color.fromARGB(
                    255, 255, 255, 255)), // Ajuste del color del icono
            title: Text(
              "Historia",
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
            onTap: () {
              List<Caja> historia = obtenerHistoria();
              if (historia.isEmpty) {
                // Si la lista está vacía, muestra un mensaje o realiza alguna acción apropiada
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('No hay datos disponibles'),
                  ),
                );
              } else {
                // Obtener el primer elemento de la lista (asumiendo que solo hay uno)
                Caja caja = historia[0];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detalles(
                      imagePath: caja.imagePath,
                      name: caja.name,
                      description: caja.description,
                      videoPath: caja.videoPath,
                    ),
                  ),
                );
              }
            },
          ),
          Divider(),

          //hecho
          ListTile(
            leading: Icon(Icons.star,
                color: Color.fromARGB(
                    255, 255, 255, 255)), // Ajuste del color del icono
            title: Text("Servicios",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FutureBuilder<List<Caja>>(
                    future: obtenerServicios(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error al cargar los datos'));
                      } else {
                        return TodosScroll(
                          listaCajas: snapshot.data!,
                          titulo: 'Servicios',
                        );
                      }
                    },
                  ),
                ),
              );
            },
          ),
          Divider(),

          //hecho
          ListTile(
              leading: Icon(Icons.text_snippet_outlined,
                  color: Color.fromARGB(
                      255, 255, 255, 255)), // Ajuste del color del icono
              title: Text(
                "Noticias",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FutureBuilder<List<Caja>>(
                      future: obtenerNoticias(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error al cargar los datos'));
                        } else {
                          return TodosScroll(
                            listaCajas: snapshot.data!,
                            titulo: 'Noticias',
                          );
                        }
                      },
                    ),
                  ),
                );
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.co_present_outlined,
                  color: Color.fromARGB(
                      255, 255, 255, 255)), // Ajuste del color del icono
              title: Text(
                "Videos",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FutureBuilder<List<Caja>>(
                      future: obtenerVideos(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error al cargar los datos'));
                        } else {
                          return TodosScroll(
                            listaCajas: snapshot.data!,
                            titulo: 'Videos',
                          );
                        }
                      },
                    ),
                  ),
                );
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.work_outlined,
                  color: Color.fromARGB(
                      255, 255, 255, 255)), // Ajuste del color del icono
              title: Text(
                "Albergues",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/Contratame');
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.text_snippet_outlined,
                  color: Color.fromARGB(
                      255, 255, 255, 255)), // Ajuste del color del icono
              title: Text(
                "Medidas preventivas",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FutureBuilder<List<Caja>>(
                      future: obtenerMedidasPreventivas(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error al cargar los datos'));
                        } else {
                          return TodosScroll(
                            listaCajas: snapshot.data!,
                            titulo: 'Medidas preventivas',
                          );
                        }
                      },
                    ),
                  ),
                );
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.text_snippet_outlined,
                  color: Color.fromARGB(
                      255, 255, 255, 255)), // Ajuste del color del icono
              title: Text(
                "Miembros",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FutureBuilder<List<Caja>>(
                      future: obtenerMiembros(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error al cargar los datos'));
                        } else {
                          return TodosScroll(
                            listaCajas: snapshot.data!,
                            titulo: 'Miembros',
                          );
                        }
                      },
                    ),
                  ),
                );
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.text_snippet_outlined,
                  color: Color.fromARGB(
                      255, 255, 255, 255)), // Ajuste del color del icono
              title: Text(
                "Ser voluntario",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/AcercaDe');
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.text_snippet_outlined,
                  color: Color.fromARGB(
                      255, 255, 255, 255)), // Ajuste del color del icono
              title: Text(
                "Acerca de",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/AcercaDe');
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.text_snippet_outlined,
                  color: Color.fromARGB(
                      255, 255, 255, 255)), // Ajuste del color del icono
              title: Text(
                "Configuración",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/AcercaDe');
              }),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}
