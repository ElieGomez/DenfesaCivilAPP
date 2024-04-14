import 'package:defensacivilapp/screens/Post-Login/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class NoticiasEspecificas extends StatefulWidget {
  const NoticiasEspecificas({Key? key}) : super(key: key);

  @override
  _NoticiasEspecificasState createState() => _NoticiasEspecificasState();
}

class _NoticiasEspecificasState extends State<NoticiasEspecificas> {
  List<Noticia> noticias = [];

  @override
  void initState() {
    super.initState();
    final tokenProvider = Provider.of<AuthToken>(context, listen: false);

    obtenerNoticiasEspecificas(tokenProvider.token);
  }

  Future<void> obtenerNoticiasEspecificas(String token) async {
    var url = Uri.parse(
        'https://adamix.net/defensa_civil/def/noticias_especificas.php');
    var response = await http.post(url, body: {
      'token': token,
    });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['exito'] == true) {
        List<dynamic> datos = jsonResponse['datos'];
        setState(() {
          noticias = datos.map((e) => Noticia.fromJson(e)).toList();
        });
      } else {
        print('Error en la respuesta de la API: ${jsonResponse['mensaje']}');
      }
    } else {
      print('Error al obtener las noticias');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text('Noticias Específicas', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: noticias.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(noticias[index].titulo, style: TextStyle(color: Colors.white)),
                subtitle: Text(noticias[index].fecha, style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetalleNoticia(noticia: noticias[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class DetalleNoticia extends StatelessWidget {
  final Noticia noticia;

  const DetalleNoticia({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(noticia.titulo, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text(
              noticia.fecha,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(noticia.contenido, style: TextStyle(color: Colors.black)),
            SizedBox(height: 8),
            Image.network(noticia.foto),
          ],
        ),
      ),
    );
  }
}

class Noticia {
  final String id;
  final String fecha;
  final String titulo;
  final String contenido;
  final String foto;

  Noticia({
    required this.id,
    required this.fecha,
    required this.titulo,
    required this.contenido,
    required this.foto,
  });

  factory Noticia.fromJson(Map<String, dynamic> json) {
    return Noticia(
      id: json['id'],
      fecha: json['fecha'],
      titulo: json['titulo'],
      contenido: json['contenido'],
      foto: json['foto'],
    );
  }
}
