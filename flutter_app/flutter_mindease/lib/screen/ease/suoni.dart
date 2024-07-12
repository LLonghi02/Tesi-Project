import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_mindease/model/sound_model.dart';
import 'package:flutter_mindease/provider/theme.dart';
import 'package:flutter_mindease/repository/soundProvider.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/top_bar.dart';
import 'package:flutter_mindease/screen/soundPlayer.dart';

class SoundPage extends ConsumerWidget {
  const SoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(accentColorProvider);
    final AsyncValue<List<SuoniModel>> soundListAsyncValue = ref.watch(soundProvider('suoni'));

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
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SuoniPlayerPage(videoUrl: video.videoUrl),
                    ));
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
