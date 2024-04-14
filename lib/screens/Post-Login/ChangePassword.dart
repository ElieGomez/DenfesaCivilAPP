import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'token.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool success = false;
  bool noSuccess = false;
  bool noEsIgual = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Cambiar Contraseña',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: buildBody());
  }

  void changePassword(String token) async {
    if (confirmPasswordController.text == newPasswordController.text) {
      var url =
          Uri.parse('https://adamix.net/defensa_civil/def/cambiar_clave.php');
      var response = await http.post(url, body: {
        'clave_anterior': oldPasswordController.text,
        'clave_nueva': newPasswordController.text,
        'token': token,
      });

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['exito'] == true) {
          setState(() {
            success = true;
            noSuccess = false;
            noEsIgual = false;
          });
          // Optionally, you can add a delay here to show the success message for a few seconds
          await Future.delayed(Duration(seconds: 2));
          Navigator.pop(context);
        } else {
          setState(() {
            success = false;
            noSuccess = true;
            noEsIgual = false;
          });
        }
      } else {
        setState(() {
          success = true;
          noSuccess = false;
          noEsIgual = false;
        });
      }
    } else {
      setState(() {
        noEsIgual = true;
      });
    }
  }

  Widget buildBody() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            compoOldPassword(),
            compoNewPassword(),
            compoConfirmPassword(),
            if (success)
              Text('Contraseña cambiada correctamente',
                  style: TextStyle(color: Colors.green)),
            if (noSuccess)
              Text('Error cambiando la contraseña',
                  style: TextStyle(color: Colors.red)),
            if (noEsIgual)
              Text('Las contraseñas no coinciden',
                  style: TextStyle(color: Colors.red)),
            SizedBox(height: 30),
            SizedBox(height: 30),
            boton(),
          ],
        ),
      ),
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage("assets/imagen_fondo_2.png"),
      //     fit: BoxFit.cover,
      //   ),
      // ),
    );
  }

  Widget compoOldPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextField(
        controller: oldPasswordController,
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Old Password",
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }

  Widget compoNewPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextField(
        controller: newPasswordController,
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "New Password",
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }

  Widget compoConfirmPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextField(
        controller: confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Confirm Password",
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }

  Widget boton() {
    final tokenProvider = Provider.of<AuthToken>(context);

    return FractionallySizedBox(
      widthFactor: 0.7,
      child: TextButton(
        onPressed: () {
          print(tokenProvider.token);
          print('Arriba de esta msj deberia estar el token');
          changePassword(tokenProvider.token);
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          foregroundColor: Colors.white,
        ),
        child: Text(
          "Aceptar",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
