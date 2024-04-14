// ignore_for_file: prefer_const_constructors, file_names, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:flutter/material.dart';
import 'Drawer.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerContent(),
      drawerScrimColor: Colors.white.withOpacity(0.4),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Defensa Civil',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      body: SliderSection(),
    );
  }
}

class SliderSection extends StatefulWidget {
  @override
  _SliderSectionState createState() => _SliderSectionState();
}

class _SliderSectionState extends State<SliderSection> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Iniciar el temporizador para desplazar automáticamente
    Timer.periodic(Duration(seconds: 4), (timer) {
      if (_currentPage < 6) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _controller,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              SliderCard(
                imagePath: 'assets/ImageInicio/image1.jpeg',
                title:
                    'Supérate y Defensa Civil fortalecerán el voluntariado en comunidades vulnerables del país',
                description:
                    'Con la sinergia se pretende atender a los que viven en condiciones de riesgo, mediante un sistema de protección social que garantice el abordaje de la pobreza, la vulnerabilidad y la exclusión.\n\nEl acuerdo interinstitucional fue suscrito por Gloría Reyes, directora general de Supérate, y Juan Salas, presidente de la Comisión Nacional de Emergencias y director ejecutivo de la Defensa Civil. Dicho convenio buscan trabajar la prevención y la gestión de riesgo con los voluntarios y los participantes del programa Supérate a nivel nacional.',
              ),
              SliderCard(
                imagePath: 'assets/ImageInicio/image2.jpeg',
                title:
                    'Defensa Civil y OIM realizan taller de primeros auxilios para periodistas y comunicadores',
                description:
                    'En la sede de Defensa Civil República Dominicana se llevó a cabo el Taller Básico de primeros auxilios dirigido a periodistas y comunicadores. Esta capacitación forma parte de la Campaña ¨Aprendiendo a Salvar vidas¨ , campaña de generación de conciencia pública que lleva adelante Defensa Civil; la Comisión Nacional de Emergencia y la Escuela Nacional de Gestión de Riesgo.',
              ),
              SliderCard(
                imagePath: 'assets/ImageInicio/image3.jpeg',
                title:
                    'Defensa Civil realiza labores preventivas y de respuesta tras paso del fenómeno',
                description:
                    'Brigadas de la Defensa Civil Dominicana realizaron desde tempranas horas de este miércoles varias acciones preventivas y de respuesta con miras a proteger la vida y propiedades de la ciudadanía, ante los efectos de la tormenta tropical Fred sobre el país.\n\nEl personal naranja se movilizó hacia los sectores La Lila y El Dique en Santo Domingo Este, dos de los más vulnerables debido a su cercanía con el río Ozama, donde realizaron perifoneos preventivos y orientaron a la población sobre cómo y hacia dónde dirigirse en caso de una emergencia.',
              ),
              SliderCard(
                imagePath: 'assets/ImageInicio/image4.jpeg',
                title:
                    'Defensa Civil apuesta al uso de la tecnología para ser más eficiente ante cualquier fenomeno',
                description:
                    'Juan Salas, presidente de la Comisión Nacional de Emergencias y director de la Defensa Civil, afirmó este domingo que la institución de socorro ha apostado al uso de la tecnología para ser más eficientes en su labor ante cualquier fenómeno para proteger a la ciudadanía.\n\nSalas precisó que el mundo ha cambiado y parecería que la principal amenaza después de la Segunda Guerra Mundial son las afectaciones producto del cambio climático, por lo que las naciones deben estar preparadas y apoyarse de la ciencia para dar respuestas rápidas ante cualquier desastre natural.',
              ),
              SliderCard(
                imagePath: 'assets/ImageInicio/image5.jpeg',
                title:
                    'Defensa Civil apuesta a una "Semana Santa más Preventiva" con apoyo de instituciones como Adecor',
                description:
                    'Santo Domingo.- El director ejecutivo de la Defensa Civil, Juan Salas, encabezó este miércoles santo los bandereos preventivos que realizó el organismo en el Distrito Nacional, como parte del operativo “Conciencia por la Vida, Semana Santa 2024”, donde hizo un llamado a la población a mantener la prudencia durante el asueto de la Semana Mayor.\n\nDesde la avenida 27 de Febrero con Máximo Gómez, Salas detalló que, durante el operativo la institución naranja desplegará unos 10 mil 844 miembros.',
              ),
              SliderCard(
                imagePath: 'assets/ImageInicio/image6.jpeg',
                title:
                    'Recorrido aéreo: Director Defensa Civil supervisa balnearios de Samaná, Puerto Plata y Montecristi',
                description:
                    'El director ejecutivo de la Defensa Civil, Juan Salas, realizó este viernes santo un recorrido aéreo de supervisión que incluyó las provincias Samaná, Puerto Plata y Montecristi, esto como parte de las acciones que ejecuta el organismo naranja en el operativo “Conciencia por la Vida, Semana Santa 2024”.\n\nSalas, quien se hizo acompañar de varios periodistas de distintos medios de comunicación y oficiales de la Fuerza aérea dominicana, dijo que esta supervisión se realiza con el objetivo de garantizar la seguridad y la tranquilidad.',
              ),
              SliderCard(
                imagePath: 'assets/ImageInicio/image7.jpeg',
                title:
                    'Defensa Civil brinda asistencia a fanáticos y deportistas en gira de Grandes Ligas en RD',
                description:
                    'El pasado fin de semana la Defensa Civil dominicana brindó asistencia a los miles de fanáticos que asistieron al juego de Grandes Ligas que protagonizan los equipos Boston y Rays en el Estadio Quisqueya Juan Marichal, como parte de la gira mundial que efectúa la liga de beisbol profesional.\n\nDurante el evento de dos días, los técnicos de la institución de socorro y respuesta a emergencias, atendieron a las personas que sufrieron alguna afectación de salud en el lugar.',
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        DotsIndicator(
          controller: _controller,
          itemCount: 7,
          currentPage: _currentPage,
        ),
      ],
    );
  }
}

class SliderCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const SliderCard({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 200,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DotsIndicator extends StatelessWidget {
  final PageController controller;
  final int itemCount;
  final int currentPage;

  const DotsIndicator({
    required this.controller,
    required this.itemCount,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => Container(
          width: 10,
          height: 10,
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentPage ? Colors.blue : Colors.grey,
          ),
        ),
      ),
    );
  }
}
