import 'package:defensacivilapp/screens/InicioSesion.dart';
import 'package:defensacivilapp/screens/VoluntarioScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Post-Login/ChangePassword.dart';
import 'Post-Login/token.dart';

class ConfiguracionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<AuthToken>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Configuración',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Color.fromARGB(255, 164, 161, 161),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 0), // Espacio adicional en la parte superior
            if (tokenProvider.token == '')
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InicioSesion()),
                  );
                },
                child: Text('Login',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,

                  // primary: Colors.black,
                ),
              ),
            SizedBox(height: 16.0),
            if (tokenProvider.token == '')
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SingUp()),
                  );
                },
                child: Text('Registrarse',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  // primary: Colors.black,
                ),
              ),
            // Espacio adicional entre los botones y la parte inferior
            if (tokenProvider.token != '')
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangePassword()),
                  );
                },
                child: Text('Cambiar contraseña',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,

                  // primary: Colors.black,
                ),
              ),
            SizedBox(height: 16.0),
            if (tokenProvider.token != '')
              ElevatedButton(
                onPressed: () {
                  Provider.of<AuthToken>(context, listen: false).setToken('');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InicioSesion()),
                  );
                },
                child: Text('Cerrar Sesión',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,

                  // primary: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
