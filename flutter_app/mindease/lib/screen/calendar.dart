import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindease/provider/importer.dart';
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
                return Container(); // Non è più necessario visualizzare i dettagli qui
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
       availableCalendarFormats: const {
      CalendarFormat.month: 'Mese',
    }, 
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
        });

        // Filtra gli eventi per la data selezionata
        final eventsForDate = _selectedEvents.where(
          (event) => event.data == DateFormat('yyyy-MM-dd').format(selectedDay),
        ).toList();

        // Mostra un modal bottom sheet con i dettagli
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 400, // Adjust height as needed
              child: EmotionDetailsWidget(data: eventsForDate),
            );
          },
        );
      },
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          final eventsForDate = _selectedEvents.where(
            (event) => event.data == DateFormat('yyyy-MM-dd').format(date),
          ).toList();

          if (eventsForDate.isNotEmpty) {
            return Positioned(
              child: Stack(
                children: eventsForDate.map((event) {
                  String imageUrl = getEmotionImage(event.emozione);
                  return Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 200, // Adjust height as needed
                              child: EmotionDetailsWidget(data: eventsForDate),
                            );
                          },
                        );
                      },
                      child: EmotionCalenda(
                        imageUrl: imageUrl,
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
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