import 'package:mindease_app/provider/importer.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

final videoProvider = FutureProvider.family<List<VideoModel>, String>((ref, tag) async {
  return await fetchVideos(tag);
});
Future<List<VideoModel>> fetchVideos(String tag) async {
  Uri url; // Define url variable

  if (tag == "meditazione") {
    url = Uri.parse('https://rfsogpn796.execute-api.us-east-1.amazonaws.com/default/Meditazione_player');
  } else if (tag == "respirazione") {
    url = Uri.parse('https://ox65hm90k1.execute-api.us-east-1.amazonaws.com/default/Respirazione_Player');
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

    // Aggiungi una stampa per vedere i dati ricevuti
    print('Response data: $responseData');

    return responseData.map((video) => VideoModel.fromJson(video)).toList();
  } else {
    throw Exception('Failed to load videos');
  }

}
