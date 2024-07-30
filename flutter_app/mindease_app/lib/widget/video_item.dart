import 'package:flutter/material.dart';  // Importa i widget di Flutter per la UI
import 'package:youtube_player_flutter/youtube_player_flutter.dart';  // Importa il pacchetto per la riproduzione di video YouTube
import 'package:mindease_app/provider/importer.dart';  // Importa i provider e i modelli necessari

// Funzione per estrarre l'ID del video da un URL
String? extractVideoIdFromUrl(String url) {
  final RegExp youtubeIdPattern = RegExp(
    r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/|youtube-nocookie\.com\/v\/)([a-zA-Z0-9_-]{11})',
    caseSensitive: false,  
    multiLine: false,  
  );

  final match = youtubeIdPattern.firstMatch(url);  // Trova la prima corrispondenza del pattern nell'URL
  final videoId = match?.group(1);  // Estrae l'ID del video dalla corrispondenza

  // Stampa l'ID del video estratto per il debug
  print('Extracted video ID: $videoId');

  return videoId;  // Restituisce l'ID del video
}

class VideoListItem extends StatefulWidget {
  final VideoModel video;  // Modello del video da visualizzare
  final bool isSelected;  // Indica se il video è selezionato
  final VoidCallback onTap;  // Funzione da chiamare quando il video viene toccato

  const VideoListItem({
    Key? key,
    required this.video,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  _VideoListItemState createState() => _VideoListItemState();  // Crea lo stato associato a questo widget
}

class _VideoListItemState extends State<VideoListItem> {
  YoutubePlayerController? _controller;  // Controller per il player di YouTube
  bool _isPlayerVisible = false;  // Stato che indica se il player è visibile

  @override
  void initState() {
    super.initState();
    // Inizializza il controller se il video è selezionato
    if (widget.isSelected) {
      _initializeController();
    }
  }

  // Inizializza il controller di YouTube per il video
  void _initializeController() {
    final videoId = extractVideoIdFromUrl(widget.video.videoUrl);  // Estrae l'ID del video dall'URL
    if (videoId != null) {
      setState(() {
        _controller = YoutubePlayerController(
          initialVideoId: videoId,  // Imposta l'ID del video iniziale
          flags: YoutubePlayerFlags(
            autoPlay: false,  // Il video non parte automaticamente
            mute: false,  // Il video non è muto
          ),
        );
        _isPlayerVisible = true;  // Imposta lo stato del player come visibile
      });
    }
  }

  @override
  void didUpdateWidget(covariant VideoListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Rinizializza il controller se il video è selezionato e il controller non è stato creato
    if (widget.isSelected && _controller == null) {
      _initializeController();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();  // Libera le risorse del controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Estrae l'ID del video per ottenere l'URL della miniatura
    final videoId = extractVideoIdFromUrl(widget.video.videoUrl);
    final thumbnailUrl = videoId != null
        ? YoutubePlayer.getThumbnail(
            videoId: videoId,
            quality: ThumbnailQuality.high,  // Imposta la qualità alta per la miniatura
          )
        : '';

    return Card(
      margin: const EdgeInsets.all(8.0),  // Margine attorno alla card
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,  // Allinea gli elementi all'interno della colonna
        children: [
          GestureDetector(
            onTap: () {
              widget.onTap();  // Chiama la funzione onTap quando il video viene toccato
              if (!_isPlayerVisible) {
                setState(() {
                  _isPlayerVisible = true;  // Mostra il player se non è già visibile
                });
              }
            },
            child: _isPlayerVisible && _controller != null
                ? Container(
                    height: 200,  // Altezza del container del player
                    child: YoutubePlayer(
                      controller: _controller!,  // Imposta il controller per il player
                      showVideoProgressIndicator: true,  // Mostra l'indicatore di progresso del video
                      onReady: () {
                        print('Player is ready');  // Log quando il player è pronto
                      },
                      onEnded: (metadata) {
                        print('Video ended');  // Log quando il video è finito
                      },
                    ),
                  )
                : Container(
                    height: 200,  // Altezza del container per la miniatura
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(thumbnailUrl),  // Imposta l'immagine di sfondo come miniatura del video
                        fit: BoxFit.cover,  // Adatta l'immagine al contenitore
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.play_circle_outline,  // Icona di play per indicare che si può avviare il video
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),  // Padding per il titolo del video
            child: Text(
              widget.video.title,  // Titolo del video
              style: AppFonts.appTitle,  // Stile del titolo
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),  // Padding per il testo dell'autore
            child: Text(
              'Autore: ${widget.video.author}',  // Mostra l'autore del video
              style: AppFonts.emo,  // Stile del testo dell'autore
            ),
          ),
        ],
      ),
    );
  }
}
