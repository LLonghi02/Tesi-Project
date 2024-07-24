import 'package:mindease_app/provider/importer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoListItem extends StatefulWidget {
  final VideoModel video;
  final VoidCallback onTap;

  const VideoListItem({Key? key, required this.video, required this.onTap}) : super(key: key);

  @override
  _VideoListItemState createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.video.videoUrl)!,
      flags: YoutubePlayerFlags(
        autoPlay: false, // Imposta su true se vuoi che il video parta automaticamente
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          YoutubePlayerBuilder(
            player: YoutubePlayer(controller: _controller),
            builder: (context, player) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _controller = YoutubePlayerController(
                      initialVideoId: YoutubePlayer.convertUrlToId(widget.video.videoUrl)!,
                      flags: YoutubePlayerFlags(
                        autoPlay: true,
                        mute: false,
                      ),
                    );
                    _controller.play();
                  });
                },
                child: Container(
                  height: 200, // Altezza del container per il video
                  child: player,
                ),
              );
            },
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
