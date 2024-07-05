import 'package:flutter/material.dart';
import 'package:flutter_mindease/widget/font.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/top_bar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  // Esempio di lista di giorni con test completati (simulati)
  List<DateTime> completedTests = [
    DateTime(2024, 7, 1),
    DateTime(2024, 7, 5),
    DateTime(2024, 7, 10),
    DateTime(2024, 7, 15),
    DateTime(2024, 7, 20),
    DateTime(2024, 7, 25),
    DateTime(2024, 7, 30),
  ];

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Il tuo calendario',
              style:  AppFonts.appTitle,
              textAlign: TextAlign.center,
            ),
          ),
          TableCalendar(
            calendarFormat: _calendarFormat,
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            startingDayOfWeek: StartingDayOfWeek.monday,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onDaySelected: _onDaySelected,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            /*eventLoader: (day) {
              // Controlla se il giorno ha un test completato
              return completedTests.contains(day);
            },*/
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
          ),
          const SizedBox(height: 20),
          if (completedTests.contains(_selectedDay))
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Mostra il recap del test per il giorno selezionato
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Recap del test - ${_selectedDay.day}/${_selectedDay.month}/${_selectedDay.year}'),
                      content: const Text('Inserire qui il recap del test'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Chiudi'),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.grey.withOpacity(0.3),
                  child: const Text('Premi qui per vedere il recap del test'),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
