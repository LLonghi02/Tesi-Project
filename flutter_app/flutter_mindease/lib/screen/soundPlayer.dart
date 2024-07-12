
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SuoniPlayerPage extends StatefulWidget {
  final String videoUrl;

  const SuoniPlayerPage({required this.videoUrl});

  @override
  _SuoniPlayerPageState createState() => _SuoniPlayerPageState();
}

class _SuoniPlayerPageState extends State<SuoniPlayerPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      // placeholder: placeholderWidget,
      // aspectRatio: 16 / 9,
      // autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: Chewie(controller: _chewieController),
      ),
    );
  }
}
