import 'package:flutter/material.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/font.dart';
import 'package:flutter_mindease/widget/top_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center, // Rimuovi questo per allineamento a sinistra di default
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Nickname',
              style: AppFonts.appTitle,
            ),
            const SizedBox(height: 20),
            // Allineamento a sinistra per le seguenti righe
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'I tuoi obiettivi raggiunti',
                  style: AppFonts.appTitle,
                ),
                const SizedBox(height: 10),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: List.generate(3, (index) {
                    return Card(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, size: 50, color: Colors.teal),
                            const SizedBox(height: 5),
                            Text(
                              index == 0
                                  ? 'Hai aggiornato il calendario 10 volte'
                                  : 'Hai vinto per 5 giorni Mindfulness',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Il tuo umore',
                  style: AppFonts.appTitle,
                  textAlign: TextAlign.left,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/calendario.png',
                          height: 150,
                          width: 150,
                        ),
                      ],
                    ),
                    const Column(
                      children: [
                        Icon(Icons.mood, size: 50, color: Colors.teal),
                        SizedBox(height: 5),
                        Text(
                          '28/4',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
