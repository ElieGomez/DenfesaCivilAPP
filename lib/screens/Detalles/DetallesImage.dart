// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class DetallesImage extends StatelessWidget {
  final String imagePath;
  final String name;
  final String description;

  DetallesImage({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            // Imagen
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            // Nombre del personaje
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            // Descripción del personaje
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
