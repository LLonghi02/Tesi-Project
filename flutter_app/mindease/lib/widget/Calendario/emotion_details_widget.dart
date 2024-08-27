import 'package:flutter/material.dart';
import 'package:mindease/provider/importer.dart';

class EmotionDetailsWidget extends StatelessWidget {
  final List<CalendarModel> data;

  const EmotionDetailsWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(
          child: Text('Non ci sono emozioni per questa giornata'));
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final event = data[index];
        final emotion = event.emozione;
        final causa = event.causa;
        final date = event.data;
        final sintomi = event.sintomi;

        return Container(
          width: double.infinity,
          height: 180.0, // Adjust the height as needed
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Data: $date', style: AppFonts.sett),
                    EmotionCalenda(
                      imageUrl: getEmotionImage(emotion),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Causa: $causa',
                  style: AppFonts.sett,
                ),
                const SizedBox(height: 10.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sintomi:', style: AppFonts.sett),
                    const SizedBox(width: 10),
                    Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: sintomi.map((sintomo) {
                        String englishName = italianToEnglishSymptoms[sintomo] ?? sintomo;
                        return Image.asset(
                          'assets/images/sintomi/$englishName.png',
                          width: 40,
                          height: 40,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
