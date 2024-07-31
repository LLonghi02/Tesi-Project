import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mindease/provider/importer.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String defaultProfileImage = 'assets/images/user/profilo.png';

class ProfileImagePage extends ConsumerWidget {
  final List<String> predefinedImages = [
    'assets/images/user/profilo.png',
    'assets/images/user/p2.png',
    'assets/images/user/p3.png',
    'assets/images/user/p4.png',
    'assets/images/user/p5.png',
    'assets/images/user/p6.png',
    'assets/images/user/p7.png',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(detProvider);
    final profileImage = ref.watch(profileImageProvider) ?? defaultProfileImage;

    // Funzione per salvare l'immagine del profilo
    Future<void> _saveProfileImage(String imagePath) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profileImage', imagePath);
      ref.read(profileImageProvider.notifier).state = imagePath;
    }

    // Funzione per selezionare un'immagine dalla galleria
    Future<void> _selectImageFromGallery() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        await _saveProfileImage(pickedFile.path);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Foto del profilo salvata con successo!'),
          ),
        );
      }
    }

    // Funzione per scegliere un'immagine predefinita
    void _selectDefaultImage(String imagePath) async {
      await _saveProfileImage(imagePath);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Foto del profilo salvata con successo!'),
        ),
      );
    }

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
              CircleAvatar(
                radius: 50,
                backgroundImage: profileImage.startsWith('assets/')
                    ? AssetImage(profileImage) as ImageProvider
                    : FileImage(File(profileImage)),
              ),
              const SizedBox(height: 20),
              CustomTextButton(
                onPressed: _selectImageFromGallery,
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
                      onTap: () => _selectDefaultImage(imagePath),
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
