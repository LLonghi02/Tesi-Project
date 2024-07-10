import 'package:flutter/material.dart';
import 'package:flutter_mindease/repository/dateProvider.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/top_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_mindease/model/calendar_model.dart';
import 'package:flutter_mindease/widget/emotion_button.dart'; // Import the EmotionButton widget

class CalendarPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<CalendarModel>> calendarDataAsync =
        ref.watch(calendarProvider(DateTime.now().toString()));

    return Scaffold(
      backgroundColor: const Color(0xffd2f7ef),
      appBar: const TopBar(),
      body: calendarDataAsync.when(
        loading: () => const Center(
            child:
                CircularProgressIndicator()), // Use const for constant widgets
        error: (error, stackTrace) => Center(child: Text('Errore: $error')),
        data: (calendarData) {
          return _buildCalendarWithEmotionButton(calendarData);
        },
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  Widget _buildCalendarWithEmotionButton(List<CalendarModel> calendarData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Il tuo calendario',
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold), // Use const for constant styles
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: TableCalendar<CalendarModel>(
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekVisible: true,
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 1,
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false, // Use const for constant properties
              ),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              selectedDayPredicate: (day) {
                return calendarData
                    .any((entry) => entry.data == day.toString());
              },
              onDaySelected: (selectedDay, focusedDay) {
                print('Selected $selectedDay');
              },
              calendarBuilders: CalendarBuilders<CalendarModel>(
                defaultBuilder: (context, day, focusedDay) {
                  final emotionsForDay = calendarData
                      .where((entry) => entry.data == day.toString());

                  if (emotionsForDay.isNotEmpty) {
                    return InkWell(
                      onTap: () {
                        print('Tapped on emotion for ${day.toString()}');
                      },
                      child: const EmotionButton(
                        imageUrl:
                            '', // Inserisci l'URL dell'immagine dell'emozione qui
                        text:
                            'Emotion', // Puoi inserire un testo per l'emozione
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        day.day.toString(),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
