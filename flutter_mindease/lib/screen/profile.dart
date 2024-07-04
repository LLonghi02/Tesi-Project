import 'package:flutter/material.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/font.dart';
import 'package:flutter_mindease/widget/top_bar.dart';
import 'package:flutter_mindease/widget/trophie.dart';

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
  // Dummy data to simulate objectives completion
  final List<bool> objectivesMet = List.generate(20, (index) => index % 2 == 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd2f7ef),
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profilo.jpg'),
              ),
              const SizedBox(height: 10),
              const Text(
                'Nickname',
                style: AppFonts.appTitle,
              ),
              const SizedBox(height: 20),
              TrophiesSection(objectivesMet: objectivesMet),
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
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
