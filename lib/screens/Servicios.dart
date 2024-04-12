// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'ManejarElementos/CajasModel.dart';

Future<List<Caja>> obtenerServicios() async {
  // Realiza la solicitud HTTP a la URL de la API
  final response = await http
      .get(Uri.parse('https://adamix.net/defensa_civil/def/servicios.php'));

  if (response.statusCode == 200) {
    // Decodifica el JSON de la respuesta
    final jsonData = jsonDecode(response.body);

    // Crea una lista para almacenar los objetos de tipo Caja
    List<Caja> listaCajas = [];

    // Itera sobre los datos decodificados y crea instancias de Caja
    for (var item in jsonData) {
      Caja caja = Caja(
        imagePath: item['foto'],
        name: item['nombre'],
        description: item['descripcion'],
        videoPath: "",
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
