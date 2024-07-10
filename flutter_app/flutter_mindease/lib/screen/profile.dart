import 'package:flutter/material.dart';
import 'package:flutter_mindease/provider/getEmotion.dart';
import 'package:flutter_mindease/widget/emotion_BCalenda.dart';
import 'package:flutter_mindease/widget/emotion_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_mindease/model/calendar_model.dart';
import 'package:flutter_mindease/repository/dateProvider.dart';
import 'package:flutter_mindease/screen/calendar.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/font.dart';
import 'package:flutter_mindease/widget/top_bar.dart';
import 'package:flutter_mindease/widget/trophie.dart';
import 'package:collection/collection.dart'; // Import firstWhereOrNull

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

class ProfileScreen extends ConsumerWidget {
  // Dummy data to simulate objectives completion
  final List<bool> objectivesMet = List.generate(20, (index) => index % 2 == 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String currentDate = DateTime.now().toIso8601String().split('T')[0];

    final AsyncValue<List<CalendarModel>> calendarDataAsync =
        ref.watch(calendarProvider(currentDate));

    return Scaffold(
      backgroundColor: const Color(0xffd2f7ef),
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
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
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CalendarPage(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/calend.png',
                          height: 150,
                          width: 150,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 50,
                                    color: Color(0xffd2f7ef),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    currentDate,
                                    style: AppFonts.calenda,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              calendarDataAsync.when(
                                loading: () =>
                                    const CircularProgressIndicator(),
                                error: (error, stackTrace) =>
                                    Text('Errore: $error'),
                                data: (calendarData) {
                                  // Find emotion for the current date
                                  CalendarModel? todayEmotion =
                                      calendarData.firstWhereOrNull(
                                    (entry) => entry.data == currentDate,
                                  );

                                  if (todayEmotion != null) {
                                    return Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: EmotionCalenda(
                                        imageUrl: getEmotionImage(
                                            todayEmotion.emozione),
                                      ),
                                    );
                                  } else {
                                    return const Text(
                                      'non ci hai fatto sapere come stai',
                                      style: AppFonts.calenda,
                                    );
                                  }
                                },
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
