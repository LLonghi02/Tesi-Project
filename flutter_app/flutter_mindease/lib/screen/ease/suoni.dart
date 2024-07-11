import 'package:flutter/material.dart';
import 'package:flutter_mindease/model/sound_model.dart'; // Assicurati di importare correttamente il modello SuoniModel
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/provider/theme.dart';
import 'package:flutter_mindease/widget/top_bar.dart';
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

class SoundPage extends ConsumerWidget {
  const SoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(accentColorProvider); // Recupera il colore di sfondo dal provider
    final AsyncValue<List<SuoniModel>> soundListAsyncValue = ref.watch(soundProvider('suoni')); // Esempio di chiamata al provider con il tag 'suoni'

    return Scaffold(
      backgroundColor: backcolor,
      appBar: const TopBar(),
      body: soundListAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        data: (soundList) {
          if (soundList.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: soundList.length,
              itemBuilder: (context, index) {
                final video = soundList[index];
                return ListTile(
                  title: Text(video.title),
                  subtitle: Text(video.artist),
                  onTap: () {
                    
                  },
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
