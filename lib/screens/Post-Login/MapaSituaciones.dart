import 'package:defensacivilapp/screens/Post-Login/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Situacion {
  final String id;
  final String titulo;
  final String estado;
  final double latitud;
  final double longitud;

  Situacion({
    required this.id,
    required this.titulo,
    required this.estado,
    required this.latitud,
    required this.longitud,
  });
}

class MapaSituaciones extends StatefulWidget {
  @override
  _MapaSituacionesState createState() => _MapaSituacionesState();
}

class _MapaSituacionesState extends State<MapaSituaciones> {
  late GoogleMapController mapController;
  late List<Situacion> situaciones = [];
  late Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    final tokenProvider = Provider.of<AuthToken>(context, listen: false);
    obtenerSituaciones(tokenProvider.token);
  }

  Future<void> obtenerSituaciones(String token) async {
    var url = Uri.parse('https://adamix.net/defensa_civil/def/situaciones.php');
    var response = await http.post(url, body: {
      'token': token,
    });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      List<dynamic> datos = jsonResponse['datos'];
      setState(() {
        situaciones = datos.map((data) {
          return Situacion(
            id: data['id'],
            titulo: data['titulo'],
            estado: data['estado'],
            latitud: double.parse(data['latitud']),
            longitud: double.parse(data['longitud']),
          );
        }).toList();

        markers = situaciones.map((situacion) {
          return Marker(
            markerId: MarkerId(situacion.id),
            position: LatLng(situacion.latitud, situacion.longitud),
            infoWindow: InfoWindow(
              title: 'Situación: ${situacion.titulo}',
              snippet: 'Estado: ${situacion.estado}',
            ),
          );
        }).toSet();
      });
    } else {
      print('Error al obtener las situaciones');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de Situaciones'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(18.47893, -69.89178), // Puedes ajustar esta posición inicial
          zoom: 10,
        ),
        markers: markers,
      ),
    );
  }
}
