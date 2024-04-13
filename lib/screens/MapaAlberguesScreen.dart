import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Albergue {
  final String ciudad;
  final String codigo;
  final String edificio;
  final String coordinador;
  final String telefono;
  final String capacidad;
  final double lat;
  final double lng;

  Albergue({
    required this.ciudad,
    required this.codigo,
    required this.edificio,
    required this.coordinador,
    required this.telefono,
    required this.capacidad,
    required this.lat,
    required this.lng,
  });
}

class MapaAlberguesScreen extends StatefulWidget {
  @override
  _MapaAlberguesState createState() => _MapaAlberguesState();
}

class _MapaAlberguesState extends State<MapaAlberguesScreen> {
  late GoogleMapController mapController;
  late List<Albergue> albergues = [];
  late Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    obtenerAlbergues();
  }

  void obtenerAlbergues() async {
    final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/albergues.php'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final alberguesData = jsonData['datos'] as List<dynamic>;
      setState(() {
        albergues = alberguesData.map((data) {
          return Albergue(
            ciudad: data['ciudad'],
            codigo: data['codigo'],
            edificio: data['edificio'],
            coordinador: data['coordinador'],
            telefono: data['telefono'],
            capacidad: data['capacidad'],
            lat: double.parse(data['lat']),
            lng: double.parse(data['lng']),
          );
        }).toList();

        markers = albergues.map((albergue) {
          return Marker(
            markerId: MarkerId(albergue.codigo),
            position: LatLng(albergue.lng, albergue.lat),
            infoWindow: InfoWindow(
              title: albergue.edificio,
              snippet: 'Ciudad: ${albergue.ciudad}\nTeléfono: ${albergue.telefono}\nCapacidad: ${albergue.capacidad}',
            ),
          );
        }).toSet();
      });
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de Albergues'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(18.47893, -69.89178),
          zoom: 10,
        ),
        markers: markers,
      ),
    );
  }
}