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
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text('Albergues', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder<List<Albergue>>(
          future: _alberguesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.black),
                ),
              );
            } else {
              final List<Albergue> albergues = snapshot.data ?? [];
              return ListView.builder(
                itemCount: albergues.length,
                itemBuilder: (context, index) {
                  final Albergue albergue = albergues[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Card(
                      color: Colors.black,
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        title: Text(albergue.edificio, style: TextStyle(color: Colors.white)),
                        subtitle: Text(albergue.ciudad, style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetallesAlbergueScreen(albergue: albergue),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
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
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text('Detalles del Albergue', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.black,
                child: Column(
                  children: [
                    Text('Edificio: ${albergue.edificio}', style: TextStyle(color: Colors.white)),
                    Text('Ciudad: ${albergue.ciudad}', style: TextStyle(color: Colors.white)),
                    Text('Coordinador: ${albergue.coordinador}', style: TextStyle(color: Colors.white)),
                    Text('Teléfono: ${albergue.telefono}', style: TextStyle(color: Colors.white)),
                    Text('Capacidad: ${albergue.capacidad}', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
