// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../ManejarElementos/CajasModel.dart';

Future<List<Caja>> obtenerMiembros() async {
  // Realiza la solicitud HTTP a la URL de la API
  final response = await http
      .get(Uri.parse('https://adamix.net/defensa_civil/def/miembros.php'));

  if (response.statusCode == 200) {
    // Decodifica el JSON de la respuesta
    final jsonData = jsonDecode(response.body);

    // Accede a la lista de datos dentro de la respuesta
    List<dynamic> datos = jsonData['datos'];

    // Crea una lista para almacenar los objetos de tipo Caja
    List<Caja> listaCajas = [];

    // Itera sobre los datos y crea instancias de Caja
    for (var item in datos) {
      Caja caja = Caja(
        imagePath: item['foto'],
        name: item['nombre'],
        description: "Cargo: " + item['cargo'],
        videoPath: "", // Puedes ajustar esta parte si necesitas manejar videos
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
