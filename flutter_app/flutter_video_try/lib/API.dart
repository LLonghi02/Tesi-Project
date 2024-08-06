import 'package:flutter_video_try/VIDEO.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


final videoProvider = FutureProvider.family<List<VideoModel>, String>((ref, tag) async {
  return await fetchVideos(tag);
});
Future<List<VideoModel>> fetchVideos(String tag) async {
  Uri url; // Define url variable
    url = Uri.parse('https://ox65hm90k1.execute-api.us-east-1.amazonaws.com/default/Respirazione_Player');


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

    // Aggiungi una stampa per vedere i dati ricevuti
    print('Response data: $responseData');

    return responseData.map((video) => VideoModel.fromJson(video)).toList();
  } else {
    throw Exception('Failed to load videos');
  }

}
