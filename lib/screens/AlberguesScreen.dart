// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  factory Albergue.fromJson(Map<String, dynamic> json) {
    return Albergue(
      ciudad: json['ciudad'],
      codigo: json['codigo'],
      edificio: json['edificio'],
      coordinador: json['coordinador'],
      telefono: json['telefono'],
      capacidad: json['capacidad'],
      lat: double.parse(json['lat']),
      lng: double.parse(json['lng']),
    );
  }
}

class AlbergueService {
  Future<List<Albergue>> fetchAlbergues() async {
    final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/albergues.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> alberguesData = data['datos'];
      return alberguesData.map((json) => Albergue.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load albergues');
    }
  }
}

class AlberguesScreen extends StatefulWidget {
  @override
  _AlberguesScreenState createState() => _AlberguesScreenState();
}

class _AlberguesScreenState extends State<AlberguesScreen> {
  final AlbergueService _albergueService = AlbergueService();
  late Future<List<Albergue>> _alberguesFuture;

  @override
  void initState() {
    super.initState();
    _alberguesFuture = _albergueService.fetchAlbergues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albergues'),
      ),
      body: FutureBuilder<List<Albergue>>(
        future: _alberguesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Albergue> albergues = snapshot.data ?? [];
            return ListView.builder(
              itemCount: albergues.length,
              itemBuilder: (context, index) {
                final Albergue albergue = albergues[index];
                return ListTile(
                  title: Text(albergue.edificio),
                  subtitle: Text(albergue.ciudad),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetallesAlbergueScreen(albergue: albergue),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class DetallesAlbergueScreen extends StatelessWidget {
  final Albergue albergue;

  const DetallesAlbergueScreen({Key? key, required this.albergue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Albergue'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Edificio: ${albergue.edificio}'),
            Text('Ciudad: ${albergue.ciudad}'),
            Text('Coordinador: ${albergue.coordinador}'),
            Text('Teléfono: ${albergue.telefono}'),
            Text('Capacidad: ${albergue.capacidad}'),
          ],
        ),
      ),
    );
  }
}
