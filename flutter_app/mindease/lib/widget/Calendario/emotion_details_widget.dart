import 'package:flutter/material.dart';
import 'package:mindease/model/calendar_model.dart';
import 'package:mindease/provider/getEmotion.dart';
import 'package:mindease/screen/calendar.dart';
import 'package:mindease/widget/Calendario/emotion_BCalenda.dart';
import 'package:mindease/widget/font.dart';

class EmotionDetailsWidget extends StatelessWidget {
  final List<CalendarModel> data;

  const EmotionDetailsWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('Non ci sono emozioni per questa giornata'));
    }

    final emotion = data.first.emozione; // Assuming one emotion per day
    final causa = data.first.causa; // Assuming one cause per day
    final date = data.first.data;
    final sintomi = data.first.sintomi; // List of symptoms
    print('Sintomi: $sintomi');

    return Container(
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
              Text('Causa: $causa', style: AppFonts.sett),
            ],
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
                  String englishName =
                      italianToEnglishSymptoms[sintomo] ?? sintomo; // Default to original if not found
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/sintomi/$englishName.png', // Assuming `$englishName` is the name in English
                        width: 40,
                        height: 40,
                      ),

                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
