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
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text('Situaciones',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: situaciones.length,
        itemBuilder: (context, index) {
          var situacion = situaciones[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8.0),
            ),
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                situacion['titulo'],
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                situacion['descripcion'],
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetallesSituacion(situacion: situaciones[index]),
                  ),
                );
              },
            ),
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
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Detalles de la Situación',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white,
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Identificación: ${situacion['id']}', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)),
                SizedBox(height: 8),
                Text('Título: ${situacion['titulo']}', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)),
                SizedBox(height: 8),
                Text('Descripción: ${situacion['descripcion']}', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)),
                SizedBox(height: 8),
                Text('Estado: ${situacion['estado']}', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)),
                SizedBox(height: 8),
                Text('Fecha: ${situacion['fecha']}', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)),
                SizedBox(height: 10),
                Image.memory(
                  base64Decode(situacion['foto']),
                  // width: 200,
                  // height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


