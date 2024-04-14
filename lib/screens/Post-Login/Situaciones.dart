import 'package:defensacivilapp/screens/Post-Login/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class Situaciones extends StatefulWidget {
  @override
  _SituacionesState createState() => _SituacionesState();
}

class _SituacionesState extends State<Situaciones> {
  List<dynamic> situaciones = [];

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
      setState(() {
        situaciones = jsonResponse['datos'];
      });
    } else {
      print('Error al obtener las situaciones');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Situaciones'),
      ),
      body: ListView.builder(
        itemCount: situaciones.length,
        itemBuilder: (context, index) {
          var situacion = situaciones[index];
          return ListTile(
            title: Text(situacion['titulo']),
            subtitle: Text(situacion['descripcion']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetallesSituacion(situacion: situaciones[index])),
              );
            },
          );
        },
      ),
    );
  }
}

class DetallesSituacion extends StatelessWidget {
  final Map<String, dynamic> situacion;

  const DetallesSituacion({Key? key, required this.situacion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Situación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Identificacion: ${situacion['id']}'),
            Text('Título: ${situacion['titulo']}'),
            Text('Descripción: ${situacion['descripcion']}'),
            Text('Estado: ${situacion['estado']}'),
            Text('Fecha: ${situacion['fecha']}'),
            SizedBox(height: 10),
            Image.memory(
              base64Decode(situacion['foto']),
              // width: 200,
              // height: 200,
            ),
          ],
        ),
      ),
    );
  }
}