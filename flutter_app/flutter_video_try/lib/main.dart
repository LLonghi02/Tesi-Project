import 'package:flutter/material.dart';
import 'package:flutter_video_try/API.dart';
import 'package:flutter_video_try/VIDEO.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Main function
void main() {
  runApp(ProviderScope(child: MyApp()));
}

// MyApp widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Player App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideoListScreen(),
    );
  }
}

// Video data class

// VideoListScreen widget
class VideoListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final videoListAsyncValue = watch(videoProvider('respirazione'));

    return Scaffold(
      appBar: AppBar(
        title: Text('Video List'),
      ),
      body: videoListAsyncValue.when(
        data: (videos) => ListView.builder(
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return VideoListItem(video: videos[index]);
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Failed to load videos')),
      ),
    );
  }
}

// VideoListItem widget
class VideoListItem extends StatefulWidget {
  final VideoModel video;

  VideoListItem({required this.video});

  @override
  _VideoListItemState createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  late YoutubePlayerController _controller;
  bool _isPlayerVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.video.videoUrl) ?? '',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayer() {
    setState(() {
      _isPlayerVisible = !_isPlayerVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(widget.video.videoUrl)}/0.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
              if (!_isPlayerVisible)
                IconButton(
                  icon: Icon(Icons.play_circle_outline, color: Colors.white, size: 64.0),
                  onPressed: _togglePlayer,
                ),
              if (_isPlayerVisible)
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  onReady: () {
                    _controller.play();
                  },
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.video.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'by ${widget.video.author}',
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
