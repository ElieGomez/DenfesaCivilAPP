// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors_in_immutables, file_names



import 'package:flick_video_player/flick_video_player.dart';

import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';



class Detalles extends StatelessWidget {

  final String imagePath;

  final String name;

  final String description;

  final String videoPath;



  Detalles({

    Key? key,

    required this.imagePath,

    required this.videoPath,

    required this.name,

    required this.description,

  }) : super(key: key);



  @override

  Widget build(BuildContext context) {

    if (videoPath.isNotEmpty) {

      return DetallesVideo(

        videoPath: videoPath,

        name: name,

        description: description,

      );

    } else {

      return DeetallesImage(

        imagePath: imagePath,

        name: name,

        description: description,

      );

    }

  }

}



class DetallesVideo extends StatefulWidget {

  final String videoPath;

  final String name;

  final String description;



  DetallesVideo({

    Key? key,

    required this.videoPath,

    required this.name,

    required this.description,

  }) : super(key: key);



  @override

  _DetallesVideoState createState() => _DetallesVideoState();

}



class _DetallesVideoState extends State<DetallesVideo> {

  late VideoPlayerController videoController;

  late FlickManager flickManager;



  @override

  void initState() {

    super.initState();

    if (widget.videoPath.isNotEmpty) {

      initializeVideoController();

    }

  }



  @override

  void dispose() {

    videoController.dispose();

    flickManager.dispose();

    super.dispose();

  }



  void initializeVideoController() {

    videoController = VideoPlayerController.asset(widget.videoPath);

    flickManager = FlickManager(

      videoPlayerController: videoController,

    );

    videoController.initialize().then((_) {

      setState(() {});

    });

  }



  @override

  Widget build(BuildContext context) {

    if (widget.videoPath.isNotEmpty) {

      return Scaffold(

        appBar: AppBar(

          iconTheme: const IconThemeData(color: Colors.white),

          backgroundColor: Colors.black,

          title: Text(

            widget.name,

            style: const TextStyle(color: Colors.white),

          ),

        ),

        body: Container(

          color: Colors.black,

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [

              const SizedBox(height: 20),

              // Video

              AspectRatio(

                aspectRatio: 16 / 9,

                child: FlickVideoPlayer(

                  flickManager: flickManager,

                ),

              ),

              const SizedBox(height: 10),

              // Nombre del personaje

              Padding(

                padding: const EdgeInsets.all(10),

                child: Text(

                  widget.name,

                  style: const TextStyle(

                    fontSize: 24,

                    fontWeight: FontWeight.bold,

                    color: Colors.white,

                  ),

                ),

              ),

              const SizedBox(height: 10),

              // Descripción del personaje

              Expanded(

                child: Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 20),

                  child: SingleChildScrollView(

                    child: Text(

                      widget.description,

                      textAlign: TextAlign.justify, // Justificar el texto

                      style: const TextStyle(

                        fontSize: 20,

                        color: Colors.white,

                      ),

                    ),

                  ),

                ),

              ),

              const SizedBox(height: 15),

            ],

          ),

        ),

      );

    } else {

      return Container();

    }

  }

}



class DetallesImage extends StatelessWidget {

  final String imagePath;

  final String name;

  final String description;



  const DetallesImage({

    Key? key,

    required this.imagePath,

    required this.name,

    required this.description,

  }) : super(key: key);



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        iconTheme: const IconThemeData(color: Colors.white),

        backgroundColor: Colors.black,

        title: Text(

          name,

          style: const TextStyle(color: Colors.white),

        ),

      ),

      body: Container(

        color: Colors.black,

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [

            const SizedBox(height: 20),

            // Imagen

            Image.network(

              imagePath,

              fit: BoxFit.cover,

            ),

            const SizedBox(height: 10),

            // Nombre del personaje

            Padding(

              padding: const EdgeInsets.all(10),

              child: Text(

                name,

                style: const TextStyle(

                  fontSize: 24,

                  fontWeight: FontWeight.bold,

                  color: Colors.white,

                ),

              ),

            ),

            const SizedBox(height: 10),

            // Descripción del personaje

            Expanded(

              child: Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: SingleChildScrollView(

                  child: Text(

                    description,

                    textAlign: TextAlign.justify,

                    style: const TextStyle(

                      fontSize: 20,

                      color: Colors.white,

                    ),

                  ),

                ),

              ),

            ),

            const SizedBox(height: 15),

          ],

        ),

      ),

    );

  }

}



///esto es una prueba

class DeetallesImage extends StatelessWidget {

  final String imagePath;

  final String name;

  final String description;



  const DeetallesImage({

    Key? key,

    required this.imagePath,

    required this.name,

    required this.description,

  }) : super(key: key);



  @override

  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(

          iconTheme: const IconThemeData(color: Colors.white),

          backgroundColor: const Color.fromARGB(255, 0, 0, 0),

          title: Text(

            name,

            style: const TextStyle(color: Colors.white),

          ),

        ),

        body: SingleChildScrollView(

          // Envolver todo el contenido con SingleChildScrollView

          child: Container(

            color: Colors.black,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [

                //cambio

                const SizedBox(height: 20),

                // Imagen

                _buildImage(),

                const SizedBox(height: 10),

                // Nombre del personaje

                Padding(

                  padding: const EdgeInsets.all(10),

                  child: Text(

                    name,

                    style: const TextStyle(

                      fontSize: 24,

                      fontWeight: FontWeight.bold,

                      color: Colors.white,

                    ),

                  ),

                ),

                const SizedBox(height: 10),

                // Descripción del personaje

                Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 20),

                  child: Text(

                    description,

                    textAlign: TextAlign.justify,

                    style: const TextStyle(

                      fontSize: 20,

                      color: Colors.white,

                    ),

                  ),

                ),

                const SizedBox(height: 15),

              ],

            ),

          ),

        ));

  }



  Widget _buildImage() {

    if (imagePath.startsWith('assets/')) {

      // La imagen proviene de recursos locales (assets)

      return Image.asset(

        imagePath,

        fit: BoxFit.cover,

      );

    } else {

      // La imagen proviene de una URL de red

      return Image.network(

        imagePath,

        fit: BoxFit.cover,

      );

    }

  }

}