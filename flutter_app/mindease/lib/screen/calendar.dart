import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mindease/model/calendar_model.dart';
import 'package:mindease/provider/getEmotion.dart';
import 'package:mindease/repository/dateProvider.dart';
import 'package:mindease/widget/Calendario/emotion_BCalenda.dart';
import 'package:mindease/widget/Calendario/emotion_details_widget.dart';
import 'package:mindease/widget/bottom_bar.dart';
import 'package:mindease/widget/font.dart';
import 'package:mindease/widget/top_bar.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends ConsumerStatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  DateTime _selectedDay = DateTime.now();
  List<CalendarModel> _selectedEvents = [];

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final selectedDate = dateFormat.format(_selectedDay);
    final calendarData = ref.watch(calendarProvider(selectedDate));

    return Scaffold(
      backgroundColor: const Color(0xffd2f7ef),
      appBar: const TopBar(),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Il tuo calendario',
              style: AppFonts.appTitle,
            ),
          ),
          _buildCalendar(),
          Expanded(
            child: calendarData.when(
              data: (data) {
                _selectedEvents = data;
                return EmotionDetailsWidget(data: _selectedEvents); // Utilizzo del nuovo widget
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      focusedDay: _selectedDay,
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      calendarFormat: CalendarFormat.month,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
        });
      },
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          if (_selectedEvents.isNotEmpty) {
            final event = _selectedEvents.firstWhere(
              (event) => event.data == DateFormat('yyyy-MM-dd').format(date),
              orElse: () =>
                  CalendarModel(id: '', data: '', emozione: '', causa: '', sintomi: []),
            );
            if (event.emozione.isNotEmpty) {
              String imageUrl = getEmotionImage(event.emozione);
              return EmotionCalenda(
                imageUrl: imageUrl,
                onTap: () {
                  // Handle the tap event if needed
                },
              );
            }
          }
          return null;
        },
      ),
    );
  }
}



// Mappa di traduzione dei sintomi da italiano a inglese
Map<String, String> italianToEnglishSymptoms = {
  'Mal di testa': 'headache',
  'Batticuore': 'heart',
  'Insonnia': 'insomnia',
  'Nervosismo': 'nervous',
  'Tremore': 'parkinson',
  'Mal di pancia': 'stomachache',
};
