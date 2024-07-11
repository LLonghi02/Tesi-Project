import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_mindease/widget/font.dart';
import 'package:flutter_mindease/provider/theme.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/top_bar.dart';
import 'package:image_picker/image_picker.dart';

final profileImageProvider = StateProvider<File?>((ref) => null);

class ProfileImagePage extends ConsumerWidget {
  const ProfileImagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(detProvider);
    final profileImage = ref.watch(profileImageProvider);

    return Scaffold(
      backgroundColor: backcolor,
      appBar: const TopBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Modifica la tua foto del profilo:',
                style: AppFonts.settTitle,
              ),
              const SizedBox(height: 20),
              profileImage != null
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(profileImage),
                    )
                  : const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child:
                          Icon(Icons.person, size: 50, color: Colors.white),
                    ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    ref.read(profileImageProvider.notifier).state =
                        File(pickedFile.path);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Foto del profilo salvata con successo!')),
                    );
                  }
                },
                child: const Text('Seleziona Immagine'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
