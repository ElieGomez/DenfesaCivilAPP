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
        title: Text('Configuración'),
      ),
      body: ListView(
        children: <Widget>[
          if (tokenProvider.token == '')
            ListTile(
              title: Text('Login'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InicioSesion()),
                );
              },
            ),
          if (tokenProvider.token == '')
            ListTile(
              title: Text('Registrarse'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SingUp()),
                );
              },
            ),
          if (tokenProvider.token != '')
            ListTile(
              title: Text('Cambiar contraseña'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePassword()),
                );
              },
            ),
          if (tokenProvider.token != '')
            ListTile(
              title: Text('Cerrar Sesion'),
              onTap: () {
                Provider.of<AuthToken>(context, listen: false).setToken('');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InicioSesion()),
                );
              },
            ),
        ],
      ),
    );
  }
}
