import 'package:flutter/material.dart';
import 'package:flutter_mindease/model/sound_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final soundProvider = FutureProvider.family<List<SuoniModel>, String>((ref, tag) async {
  return await fetchSounds(tag);
});

Future<List<SuoniModel>> fetchSounds(String tag) async {
  var url = Uri.parse('https://kf0hzljph2.execute-api.us-east-1.amazonaws.com/default/Sound_player');
  var body = jsonEncode(<String, String>{ 'Tag': tag });

  final response = await http.post(
    url,
    headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8' },
    body: body,
  );

  if (response.statusCode == 200) {
    List<dynamic> responseData = jsonDecode(response.body);
    return responseData.map((video) => SuoniModel.fromJson(video)).toList();
  } else {
    throw Exception('Failed to load videos');
  }
}
