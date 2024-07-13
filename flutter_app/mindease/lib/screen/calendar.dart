import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mindease/model/calendar_model.dart';
import 'package:mindease/provider/getEmotion.dart';
import 'package:mindease/repository/dateProvider.dart';
import 'package:mindease/widget/bottom_bar.dart';
import 'package:mindease/widget/emotion_BCalenda.dart';
import 'package:mindease/widget/top_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calendar_date_picker/calendar_date_picker.dart';
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

          return _buildCalendarWithEmotionButton(context, calendarData, todayEmotion);
        },
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  Widget _buildCalendarWithEmotionButton(
      BuildContext context, List<CalendarModel> calendarData, CalendarModel? todayEmotion) {
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
            child: CalendarDatePicker(
              initialSelectedDate: DateTime.now(),
              onDateChanged: (selectedDate) {
                print('Selected $selectedDate');
                // Optionally, you can perform actions based on the selected date
              },
              // Custom day builder to show emotions or other customizations
              dayBuilder: (BuildContext context, DateTime day) {
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
              locale: 'it', // Set your locale here
            ),
          ),
        ),
      ],
    );
  }
}
