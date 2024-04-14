import 'dart:convert';

import 'package:defensacivilapp/screens/InicioSesion.dart';
import 'package:flutter/material.dart';
// No olvides importar el LogIn
import 'package:http/http.dart' as http;

class SingUp extends StatelessWidget {
  const SingUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text(
          'Quiero ser voluntario',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          // decoration: BoxDecoration(
          //   image: DecorationImage(image: AssetImage(""), fit: BoxFit.cover),
          // ),
          child: SingUpForm(),
        ),
      ),
    );
  }
}

class SingUpForm extends StatefulWidget {
  @override
  _SingUpFormState createState() => _SingUpFormState();
}

class _SingUpFormState extends State<SingUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _cedulaController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _correoController = TextEditingController();
  final _telefonoController = TextEditingController();
  bool exito = false;
  bool noExito = false;

  void registrar() async {
    var url = Uri.parse('https://adamix.net/defensa_civil/def/registro.php');
    var response = await http.post(url, body: {
      'cedula': _cedulaController.text,
      'nombre': _nombreController.text,
      'apellido': _apellidoController.text,
      'clave': _contrasenaController.text,
      'correo': _correoController.text,
      'telefono': _telefonoController.text,
    });

    if (response.statusCode == 200) {
      print('Registro exitoso');
      print('Respuesta: ${response.body}');

      // Verificar si el registro fue exitoso
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['exito'] == true) {
        _cedulaController.text = "";
        _nombreController.text = "";
        _apellidoController.text = "";
        _contrasenaController.text = "";
        _correoController.text = "";
        _telefonoController.text = "";

        print('EL registro se realizo');
        setState(() {
          exito = true;
          noExito = false;
        });
        await Future.delayed(Duration(seconds: 2));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InicioSesion()),
        );
      } else {
        setState(() {
          noExito = true;
          exito = false;
        });
      }
      // Aquí puedes procesar la respuesta, como guardar el token de sesión, etc.
    } else {
      print('Error al registrar');
      print('Código de estado: ${response.statusCode}');
      print('Mensaje de error: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          compoCedula(),
          SizedBox(
            height: 10,
          ),
          campoNombre(),
          SizedBox(
            height: 10,
          ),
          campoApellido(),
          SizedBox(
            height: 10,
          ),
          campoContrasena(),
          SizedBox(
            height: 10,
          ),
          campoCorreo(),
          SizedBox(
            height: 10,
          ),
          campoTelefono(),
          if (exito)
            Text('Registro creado con exito',
                style: TextStyle(color: Colors.green)),
          if (noExito)
            Text('No fue posible el registro',
                style: TextStyle(color: Colors.red)),
          SizedBox(
            height: 30,
          ),
          boton(),
          SizedBox(
            height: 5,
          ),
          logIn(),
          // if (exito == false) errorMessage(),
        ],
      ),
    );
  }

  Widget compoCedula() {
    return TextFormField(
      controller: _cedulaController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "User",
        fillColor: Colors.white,
        filled: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, introduce tu cédula';
        }
        return null;
      },
    );
  }

  Widget campoNombre() {
    return TextFormField(
      controller: _nombreController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Name",
        fillColor: Colors.white,
        filled: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, introduce tu nombre';
        }
        return null;
      },
    );
  }

  Widget campoApellido() {
    return TextFormField(
      controller: _apellidoController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Apellido",
        fillColor: Colors.white,
        filled: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, introduce tu apellido';
        }
        return null;
      },
    );
  }

  Widget campoContrasena() {
    return TextFormField(
      controller: _contrasenaController,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Password",
        fillColor: Colors.white,
        filled: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, introduce tu contraseña';
        }
        return null;
      },
    );
  }

  Widget campoCorreo() {
    return TextFormField(
      controller: _correoController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Correo",
        fillColor: Colors.white,
        filled: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, introduce tu correo';
        }
        return null;
      },
    );
  }

  Widget campoTelefono() {
    return TextFormField(
      controller: _telefonoController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Telefono",
        fillColor: Colors.white,
        filled: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, introduce tu número de teléfono';
        }
        return null;
      },
    );
  }

  Widget logIn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account? "),
        InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => InicioSesion()),
            // );
          },
          child: Text(
            "Click Here",
            style: TextStyle(
                color: Color.fromARGB(255, 33, 82, 243),
                fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }

  Widget boton() {
    return FractionallySizedBox(
      widthFactor: 0.9, // Factor de ancho para ajustar el tamaño del botón
      child: TextButton(
        onPressed: () {
          if (_formKey.currentState != null &&
              _formKey.currentState!.validate()) {
            registrar();
          }
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
          "Register",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
