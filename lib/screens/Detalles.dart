// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, unnecessary_cast, prefer_const_constructors_in_immutables, library_private_types_in_public_api
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Detalles extends StatefulWidget {
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
  _DetallesState createState() => _DetallesState();
}

class _DetallesState extends State<Detalles> {
  late VideoPlayerController videoController;
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    initializeVideoController();
  }

  @override
  void dispose() {
    videoController.dispose();
    flickManager.dispose();
    super.dispose();
  }

  void initializeVideoController() {
    if (widget.videoPath == '1') {
      videoController = VideoPlayerController.asset('assets/pruebaVideo.mkv');
    } else if (widget.videoPath == '2') {
      videoController = VideoPlayerController.asset('assets/pruebaVideo.mkv');
    } else if (widget.videoPath == '3') {
      videoController = VideoPlayerController.asset('assets/pruebaVideo.mkv');
    } else {
      videoController = VideoPlayerController.asset('assets/pruebaVideo.mkv');
    }
    flickManager = FlickManager(
      videoPlayerController: videoController,
    );
    videoController.initialize().then((_) {
      setState(() {});
    });
  }

// Apartado de detalles donde se muestra la info que se envio al darle click a la caja que esta en cajas detro de todo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            // Video
            AspectRatio(
              aspectRatio: 16 / 9,
              child: FlickVideoPlayer(
                flickManager: flickManager,
              ),
            ),
            SizedBox(height: 10),
            // Nombre del personaje
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                widget.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            // Descripción del personaje
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Text(
                    widget.description,
                    textAlign: TextAlign.justify, // Justificar el texto
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
