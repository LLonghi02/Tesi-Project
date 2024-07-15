import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mindease/model/calendar_model.dart';
import 'package:mindease/repository/dateProvider.dart';
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
      appBar: AppBar(
        title: Text('Il tuo calendario'),
      ),
      body: Column(
        children: [
          _buildCalendar(),
          Expanded(
            child: calendarData.when(
              data: (data) {
                _selectedEvents = data;
                return _buildEmotionDetails(_selectedEvents);
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
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
              orElse: () => CalendarModel(id: '', data: '', emozione: '', causa: ''),
            );
            if (event.emozione.isNotEmpty) {
              // Customize the marker appearance based on emotion
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue, // Example color, change based on emotion
                ),
                child: Center(
                  child: Text(event.emozione),
                ),
              );
            }
          }
          return null;
        },
      ),
    );
  }

  Widget _buildEmotionDetails(List<CalendarModel> data) {
    if (data.isEmpty) {
      return Center(child: Text('No emotions recorded for this day'));
    }

    final emotion = data.first.emozione; // Assuming one emotion per day
    final causa = data.first.causa; // Assuming one cause per day
    final date = data.first.data;

    return Column(
      children: [
        Text('Emotion for $date: $emotion'),
        Text('Cause: $causa'),
        // Add more details if available
      ],
    );
  }
}
