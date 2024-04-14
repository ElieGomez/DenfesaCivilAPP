// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, file_names

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../ManejarElementos/CajasModel.dart';

Future<List<Caja>> obtenerVideos() async {
  // Realiza la solicitud HTTP a la URL de la API
  final response = await http
      .get(Uri.parse('https://adamix.net/defensa_civil/def/videos.php'));

  if (response.statusCode == 200) {
    // Decodifica el JSON de la respuesta
    final jsonData = jsonDecode(response.body);

    // Accede a la lista de datos dentro de la respuesta
    List<dynamic> datos = jsonData['datos']; // Cambio aquí, de 'datos' a 'data'

    // Crea una lista para almacenar los objetos de tipo Caja
    List<Caja> listaCajas = [];

    // Itera sobre los datos y crea instancias de Caja
    for (var item in datos) {
      Caja caja = Caja(
        imagePath: "assets/elgei1.png",
        name: item['titulo'],
        description: item['descripcion'],
        videoPath:
            "https://www.youtube.com/watch?v=" + item['link'], // Cambio aquí
      );
      // Agrega la instancia de Caja a la lista
      listaCajas.add(caja);
    }
    // Retorna la lista de objetos de tipo Caja
    return listaCajas;
  } else {
    // Si la solicitud falla, lanza una excepción o maneja el error de otra manera
    throw Exception('Error al cargar los datos de la API');
  }
}
