import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mindease/provider/userProvider.dart';
import 'package:flutter_mindease/widget/SignIn/button_1.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_mindease/widget/font.dart';
import 'package:flutter_mindease/provider/theme.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/top_bar.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePage extends ConsumerWidget {
final List<String> predefinedImages = [
  'assets/images/user/profilo.png',
  'assets/images/user/p2.png',
  'assets/images/user/p3.png',
  'assets/images/user/p4.png',
  'assets/images/user/p5.png',
  'assets/images/user/p6.png',
  'assets/images/user/p7.png',
  'assets/images/user/p8.png',
];


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
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
              const SizedBox(height: 20),
              CustomTextButton(
                onPressed: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    ref.read(profileImageProvider.notifier).state =
                        File(pickedFile.path);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Foto del profilo salvata con successo!'),
                      ),
                    );
                  }
                },
                buttonText: 'Seleziona Immagine',
              ),
                            const SizedBox(height: 20),

              const Text(
                'Scegli tra le immagini predefinite:',
                style: AppFonts.settTitle,
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: predefinedImages.length,
                  itemBuilder: (context, index) {
                    final imagePath = predefinedImages[index];
                    return GestureDetector(
                      onTap: () {
                        ref.read(profileImageProvider.notifier).state =
                            File(imagePath);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Foto del profilo salvata con successo!'),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(imagePath),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
