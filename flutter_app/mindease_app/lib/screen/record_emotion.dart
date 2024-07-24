import 'package:mindease_app/provider/importer.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class RecordEmotionPage extends StatefulWidget {
  final String emotion;
  final String name;

  const RecordEmotionPage({Key? key, required this.emotion,required this.name}) : super(key: key);

  @override
  _RecordEmotionPageState createState() => _RecordEmotionPageState();
}

class _RecordEmotionPageState extends State<RecordEmotionPage> {
  final CalendarDBService _calendarDBService = CalendarDBService();
  String symptoms = ''; // Variabile per memorizzare i sintomi inseriti
  Set<String> selectedSymptoms = {}; // Set per memorizzare i sintomi selezionati
  TextEditingController causeController = TextEditingController(); // Controller per la causa

  @override
  void initState() {
    super.initState();
    _calendarDBService.open(); // Apri la connessione al database all'inizio
  }

  @override
  void dispose() {
    _calendarDBService.close(); // Chiudi la connessione al database alla fine
    super.dispose();
  }

  void saveRecord() async {
    await _calendarDBService.recordEmotion(
      widget.emotion,
      causeController.text,
      selectedSymptoms.toList(),
      widget.name,
    );
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
            MyTextField2(
              labelText: 'Come mai sei ${widget.emotion}?',
              controller: causeController, // Usa il controller per il campo di testo
            ),
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
            Center(
              child: CustomTextButton(
                onPressed: saveRecord,
                buttonText: 'Salva',
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
