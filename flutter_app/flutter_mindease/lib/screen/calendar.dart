import 'package:flutter/material.dart';
import 'package:flutter_mindease/provider/getEmotion.dart';
import 'package:flutter_mindease/repository/dateProvider.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/emotion_BCalenda.dart';
import 'package:flutter_mindease/widget/top_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_mindease/model/calendar_model.dart';
import 'package:collection/collection.dart'; // Import for firstWhereOrNull method

class CalendarPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDate = DateTime.now().toIso8601String().split('T')[0];
    final AsyncValue<List<CalendarModel>> calendarDataAsync =
        ref.watch(calendarProvider(currentDate));

    return Scaffold(
      backgroundColor: const Color(0xffd2f7ef),
      appBar: const TopBar(),
      body: calendarDataAsync.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Errore: $error')),
        data: (calendarData) {
          // Find emotion for the current date
          CalendarModel? todayEmotion =
              calendarData.firstWhereOrNull((entry) => entry.data == currentDate);

          return _buildCalendarWithEmotionButton(calendarData, todayEmotion);
        },
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  Widget _buildCalendarWithEmotionButton(
      List<CalendarModel> calendarData, CalendarModel? todayEmotion) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Il tuo calendario',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
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
                formatButtonVisible: false,
              ),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              selectedDayPredicate: (day) {
                return calendarData.any((entry) =>
                    entry.data == day.toIso8601String().split('T')[0]);
              },
              onDaySelected: (selectedDay, focusedDay) {
                print('Selected $selectedDay');
              },
              calendarBuilders: CalendarBuilders<CalendarModel>(
                defaultBuilder: (context, day, focusedDay) {
                  final emotionsForDay = calendarData.where((entry) =>
                      entry.data == day.toIso8601String().split('T')[0]);

                  if (emotionsForDay.isNotEmpty) {
                    final todayEmotion = emotionsForDay.first;
                    return EmotionCalenda(
                      imageUrl: getEmotionImage(todayEmotion.emozione),
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
