class VideoModel {
  final String id;
  final String title;
  final String author;
  final int duration;
  final String videoUrl;
  final String tag;

  VideoModel({
    required this.id,
    required this.title,
    required this.author,
    required this.duration,
    required this.videoUrl,
    required this.tag,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['_id'],
      title: json['Title'],
      author: json['Author'],
      duration: int.parse(json['Duration (seconds)']),
      videoUrl: json['Video URL'],
      tag: json['Tag'],
    );
  }
}
