import 'package:flutter/material.dart';
import 'package:flutter_mindease/model/video_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final videoProvider = FutureProvider.family<List<VideoModel>, String>((ref, tag) async {
  return await fetchVideos(tag);
});

Future<List<VideoModel>> fetchVideos(String tag) async {
  Uri url; // Define url variable

  if (tag == "respirazione") {
    url = Uri.parse('https://02qhzuakib.execute-api.us-east-1.amazonaws.com/default/Respirazione_Player');
  } else if (tag == "meditazione") {
    url = Uri.parse('https://c41rctrt6a.execute-api.us-east-1.amazonaws.com/default/Meditazione_player');
  } else {
    throw Exception('Invalid tag: $tag');
  }

  var body = jsonEncode(<String, String>{
    'Tag': tag,
  });

  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: body,
  );

  if (response.statusCode == 200) {
    List<dynamic> responseData = jsonDecode(response.body);
    return responseData.map((video) => VideoModel.fromJson(video)).toList();
  } else {
    throw Exception('Failed to load videos');
  }
}
