import 'dart:convert';

import 'package:defensacivilapp/screens/InicioScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'Post-Login/token.dart';
import 'VoluntarioScreen.dart';

class InicioSesion extends StatefulWidget {
  const InicioSesion({super.key});

  @override
  State<InicioSesion> createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  final usuarioController = TextEditingController();
  final contrasenaController = TextEditingController();
  bool exito = true;
  String token = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Iniciar Sesion',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: cuerpo());
  }

  void iniciarSesion() async {
    var url =
        Uri.parse('https://adamix.net/defensa_civil/def/iniciar_sesion.php');
    var response = await http.post(url, body: {
      'cedula': usuarioController.text,
      'clave': contrasenaController.text,
    });

    if (response.statusCode == 200) {
      print('Inicio de sesión exitoso');
      print('Respuesta: ${response.body}');

      // Verificar si el inicio de sesión fue exitoso
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['exito'] == true) {
        print(jsonResponse['datos']['token']);
        Provider.of<AuthToken>(context, listen: false)
            .setToken(jsonResponse['datos']['token']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InicioScreen()),
        );
        usuarioController.text = "";
        contrasenaController.text = "";
        setState(() {
          exito = true;
        });
      } else {
        setState(() {
          exito = false;
        });
      }
      // Aquí puedes procesar la respuesta, como guardar el token de sesión, etc.
    } else {
      print('Error al iniciar sesión');
      print('Código de estado: ${response.statusCode}');
      print('Mensaje de error: ${response.body}');
    }
  }

  Widget cuerpo() {
    return Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            // nombre(),
            SizedBox(
              height: 100,
            ),
            compoUsuario(),

            compoContrasena(),
            if (exito == false) errorMessage(),
            forgotPass(),
            SizedBox(
              height: 30,
            ),
            boton(),
            SizedBox(
              height: 5,
            ),
            signUp()
          ],
        )),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/imagen_fondo_2.png"),
              fit: BoxFit.cover),
        ));
  }

  // Widget nombre() {
  //   return Text(
  //     "Sign In",
  //     style: TextStyle(
  //         color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold),
  //   );
  // }

  Widget compoUsuario() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextField(
        controller: usuarioController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "User",
            fillColor: Colors.white,
            filled: true),
      ),
    );
  }

  Widget compoContrasena() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextField(
        controller: contrasenaController,
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Password",
            fillColor: Colors.white,
            filled: true),
      ),
    );
  }

  Widget boton() {
    return FractionallySizedBox(
      widthFactor: 0.7, // Factor de ancho para ajustar el tamaño del botón
      child: TextButton(
        onPressed: () {
          iniciarSesion();
        },
        style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            foregroundColor: Colors.white),
        child: Text(
          "Enter",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget forgotPass() {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: InkWell(
        onTap: () {
          // print('boton de forgot password presionado');
          // Navigator.push(context,
          //     MaterialPageRoute(builder: ((context) => ChangePassword())));
        },
        child: Text(
          'Forgot password?',
          textAlign: TextAlign.right,
          style: TextStyle(
              color: Color.fromARGB(255, 33, 82, 243),
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget errorMessage() {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Text(
        'Cedula y/o contraseña incorrectos',
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget signUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account? "),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SingUp()),
            );
          },
          child: Text(
            "Sing Up",
            style: TextStyle(
                color: Color.fromARGB(255, 33, 82, 243),
                fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
