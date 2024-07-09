import 'package:flutter/material.dart';
import 'package:flutter_mindease/widget/SignIn/button_1.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/font.dart';
import 'package:flutter_mindease/widget/sintomo_button.dart';
import 'package:flutter_mindease/widget/text_field_noIcon.dart';
import 'package:flutter_mindease/widget/theme.dart';
import 'package:flutter_mindease/widget/top_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Aggiunto per l'uso di Riverpod

class RecordEmotionPage extends StatefulWidget {
  final String emotion;

  const RecordEmotionPage({Key? key, required this.emotion}) : super(key: key);

  @override
  _RecordEmotionPageState createState() => _RecordEmotionPageState();
}

class _RecordEmotionPageState extends State<RecordEmotionPage> {
  String symptoms = ''; // Variabile per memorizzare i sintomi inseriti
  Set<String> selectedSymptoms = {}; // Set per memorizzare i sintomi selezionati

  void saveRecord() {
    // Implementa la logica per salvare l'emozione registrata e i sintomi
    print('Emotion: ${widget.emotion}, Symptoms: $symptoms');
    Navigator.of(context).pop(); // Chiudi la pagina dopo aver salvato
  }

  void toggleSymptom(String symptom) {
    setState(() {
      if (selectedSymptoms.contains(symptom)) {
        selectedSymptoms.remove(symptom);
      } else {
        selectedSymptoms.add(symptom);
      }
      symptoms = selectedSymptoms.join(', ');
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffd2f7ef),
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Oggi sei: ${widget.emotion}',
              style: AppFonts.appTitle,
            ),
            const SizedBox(height: 20),
             MyTextField2(labelText: 'Come mai sei ${widget.emotion}?'),
            const SizedBox(height: 20),
            const Text(
              'Seleziona i sintomi:',
              style: AppFonts.appTitle,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  SymptomImageButton(
                    imagePath: 'assets/images/sintomi/headache.png',
                    label: 'Mal di testa',
                    isSelected: selectedSymptoms.contains('Mal di testa'),
                    onClick: () {
                      toggleSymptom('Mal di testa');
                    },
                  ),
                  SymptomImageButton(
                    imagePath: 'assets/images/sintomi/heart.png',
                    label: 'Batticuore',
                    isSelected: selectedSymptoms.contains('Batticuore'),
                    onClick: () {
                      toggleSymptom('Batticuore');
                    },
                  ),
                  SymptomImageButton(
                    imagePath: 'assets/images/sintomi/insomnia.png',
                    label: 'Insonnia',
                    isSelected: selectedSymptoms.contains('Insonnia'),
                    onClick: () {
                      toggleSymptom('Insonnia');
                    },
                  ),
                  SymptomImageButton(
                    imagePath: 'assets/images/sintomi/nervous.png',
                    label: 'Nervosismo',
                    isSelected: selectedSymptoms.contains('Nervosismo'),
                    onClick: () {
                      toggleSymptom('Nervosismo');
                    },
                  ),
                  SymptomImageButton(
                    imagePath: 'assets/images/sintomi/parkinson.png',
                    label: 'Tremore',
                    isSelected: selectedSymptoms.contains('Tremore'),
                    onClick: () {
                      toggleSymptom('Tremore');
                    },
                  ),
                  SymptomImageButton(
                    imagePath: 'assets/images/sintomi/stomackache.png',
                    label: 'Mal di pancia',
                    isSelected: selectedSymptoms.contains('Mal di pancia'),
                    onClick: () {
                      toggleSymptom('Mal di pancia');
                    },
                  ),
                ],
              ),
            ),
            Center(  // Centra il CustomTextButton
              child: CustomTextButton(
                onPressed: saveRecord,
                buttonText:  'Salva',
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
