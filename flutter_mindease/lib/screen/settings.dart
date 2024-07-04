import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_mindease/widget/font.dart';
import 'package:flutter_mindease/widget/theme.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/top_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MindEase',
      home: SettingPage(),
    );
  }
}

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(detProvider); // Recupera il colore di sfondo dal provider

    return Scaffold(
      backgroundColor: backcolor,
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profilo.jpg'),
              ),
              const SizedBox(height: 10),
              const Text(
                'Nickname',
                style: AppFonts.settTitle,
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 300, // Set the desired width
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Color(0xffECFEF1),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildListItem(context, 'Nickname', Icons.person, () {
                        // Handle nickname tap
                      }),
                      _buildListItem(context, 'Password', Icons.lock, () {
                        // Handle password tap
                      }),
                      _buildListItem(context, 'Immagine del profilo', Icons.image, () {
                        // Handle profile image tap
                      }),
                      _buildListItem(context, 'Tema', Icons.brush, () {
                        // Handle theme tap
                      }),
                      _buildListItem(context, 'Condivisione con terapeuta', Icons.share, () {
                        // Handle share with therapist tap
                      }),
                      _buildListItem(context, 'About Us', Icons.info, () {
                        // Handle about us tap
                      }),
                    ],
                  ),
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

  Widget _buildListItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF4FA69E)),
      title: Text(
        title,
        style: AppFonts.sett,
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF4FA69E)),
      onTap: onTap,
    );
  }
}
