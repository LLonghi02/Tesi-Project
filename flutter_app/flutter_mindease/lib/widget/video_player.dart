import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    print('Initializing VideoPlayer with URL: ${widget.videoUrl}');
    try {
      _controller = VideoPlayerController.network(widget.videoUrl)
        ..addListener(() {
          if (mounted) {
            setState(() {});
          }
        })
        ..initialize().then((_) {
          setState(() {
            _isInitialized = true;
            _hasError = false;
          });
          _controller.play();
        }).catchError((error) {
          print('VideoPlayer initialization error: $error');
          setState(() {
            _hasError = true;
          });
        });
    } catch (e) {
      print('Exception during VideoPlayer initialization: $e');
      setState(() {
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _hasError
          ? const Text('Errore nel caricamento del video')
          : _isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : const CircularProgressIndicator(),
    );
  }
}
