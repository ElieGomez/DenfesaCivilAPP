import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VideosScreen extends StatefulWidget {
  @override
  _VideosScreenState createState() => _VideosScreenState();
  
}

class _VideosScreenState extends State<VideosScreen> {
  List<Map<String, dynamic>>? videos;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/videos.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        videos = List<Map<String, dynamic>>.from(data['datos']);
      });
      print('Videos obtenidos:');
      print(videos);
    } else {
      throw Exception('Failed to load videos');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
      ),
      body: videos != null
          ? ListView.builder(
              itemCount: videos!.length,
              itemBuilder: (context, index) {
                final video = videos![index];
                return ListTile(
                  title: Text(video['titulo'] ?? ''),
                  subtitle: Text(video['descripcion'] ?? ''),
                  onTap: () {
                    String videoUrl = video['link'];
                    String titulo = video['titulo'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerScreen(videoUrl: videoUrl, titulo: titulo),
                      ),
                    );
                  },
                );
              },
            )
          : Center(child: CircularProgressIndicator()), // Muestra un indicador de carga mientras se obtienen los datos
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String titulo;

  const VideoPlayerScreen({required this.videoUrl, required this.titulo});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoUrl,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          onReady: () {
            print('Player is ready.');
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
