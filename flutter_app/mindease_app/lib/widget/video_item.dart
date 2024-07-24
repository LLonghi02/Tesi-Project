import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:mindease_app/provider/importer.dart';

class VideoListItem extends StatefulWidget {
  final VideoModel video;
  final bool isSelected;
  final VoidCallback onTap;

  const VideoListItem({
    Key? key,
    required this.video,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  _VideoListItemState createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  YoutubePlayerController? _controller;
  bool _isPlayerVisible = false;

  @override
  void initState() {
    super.initState();
    if (widget.isSelected) {
      _initializeController();
    }
  }

  void _initializeController() {
    final videoId = YoutubePlayer.convertUrlToId(widget.video.videoUrl);
    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: false, // Default to not auto-playing
          mute: false,
        ),
      );
    }
  }

  @override
  void didUpdateWidget(covariant VideoListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && _controller == null) {
      _initializeController();
      setState(() {
        _isPlayerVisible = true;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final thumbnailUrl = YoutubePlayer.getThumbnail(
      videoId: YoutubePlayer.convertUrlToId(widget.video.videoUrl)!,
      quality: ThumbnailQuality.high,
    );

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              widget.onTap();
              setState(() {
                _isPlayerVisible = true;
              });
            },
            child: _isPlayerVisible && _controller != null
                ? Container(
                    height: 200,
                    child: YoutubePlayer(
                      controller: _controller!,
                      showVideoProgressIndicator: true,
                      onReady: () {
                        print('Player is ready');
                      },
                    ),
                  )
                : Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(thumbnailUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.play_circle_outline,
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.video.title,
              style: AppFonts.appTitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Text(
              'Autore: ${widget.video.author}',
              style: AppFonts.emo,
            ),
          ),
        ],
      ),
    );
  }
}
