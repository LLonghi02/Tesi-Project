class SuoniModel {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String durationSeconds;
  final String videoUrl;
  final String tag;

  SuoniModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.durationSeconds,
    required this.videoUrl, 
    required this.tag,
  });

  factory SuoniModel.fromJson(Map<String, dynamic> json) {
    return SuoniModel(
      id: json['_id'],
      title: json['Title'],
      artist: json['Artist(s)'],
      album: json['Album'],
      durationSeconds: json['Duration (ms)'],
      videoUrl: json['Track URL'],
      tag: json['Tag'],

    );
  }
}
