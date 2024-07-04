import 'package:flutter/material.dart';
import 'package:flutter_mindease/screen/calendar.dart';
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

  // Simulated current date for the calendar icon
  String currentDate = '4/7'; // Assuming today's date is July 4th

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd2f7ef),
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/profilo.jpg'),
                ),
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
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CalendarPage(),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/calend.png',
                            height: 150,
                            width: 150,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.calendar_today,
                                  size: 50, color: Color(0xffd2f7ef)),
                              const SizedBox(height: 5),
                              Text(
                                currentDate,
                                style: AppFonts.calenda,
                              ),
                            ],
                          ),
                        ),
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
