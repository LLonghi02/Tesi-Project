import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindease/provider/importer.dart';
import 'package:mindease/repository/level_history.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LevelSelectionPage extends ConsumerStatefulWidget {
  @override
  _LevelSelectionPageState createState() => _LevelSelectionPageState();
}
class _LevelSelectionPageState extends ConsumerState<LevelSelectionPage> {
  int _currentLevel = 1;
  bool _dailyGoalCompleted = false;
  SharedPreferences? _prefs;
  List<bool> _levelUnlockStatus = []; // Lista per memorizzare lo stato di sblocco dei livelli

  @override
  void initState() {
    super.initState();
    _initializeLevelData();
  }

  Future<void> _initializeLevelData() async {
    final String nickname = ref.read(nicknameProvider);
    var levelDataList = await levelStory(nickname);

    if (levelDataList != null && levelDataList.isNotEmpty) {
      var latestData = levelDataList.last;
      print('Level Data Retrieved: $latestData'); // Debugging output

      try {
        // Parsing Date from String
        DateTime lastCompletionDate = DateTime.parse(latestData['Data']);
        DateTime today = DateTime.now();

        // Check if the last completion date is today
        bool isToday = _isSameDay(lastCompletionDate, today);

        // Update state
        setState(() {
          _currentLevel = int.parse(latestData['Livello']);
          _dailyGoalCompleted = isToday;

          // Initialize or update the unlock status for all levels
          _levelUnlockStatus = List.generate(
            (_currentLevel > 30 ? _currentLevel : 30), // Assicurati di avere abbastanza spazio
            (index) => index < _currentLevel || index == 0,
          );
        });

        print('Current Level: $_currentLevel');
        print('Last Completion Date: $lastCompletionDate');
        print('Today\'s Date: $today');
        print('Daily Goal Completed: $_dailyGoalCompleted');
        print('Level Unlock Status: $_levelUnlockStatus');
      } catch (e) {
        print('Error parsing date or updating state: $e');
      }
    } else {
      print('Failed to fetch level story.');
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }
void _openLevel(int level) {
  // Verifica se il livello è sbloccato
  bool isUnlocked = (level == 1) || (level > 1 && level <= _currentLevel + 1);

  // Verifica se il livello precedente è stato completato
  bool previousLevelCompleted = level == 1 || (level > 1 && (level - 1) <= _currentLevel);

  // Verifica se la data odierna è diversa dalla data di completamento
  bool isDifferentDay = level == 1 || (level > 1 && !_dailyGoalCompleted);

  // Determina se possiamo aprire il livello
  bool canOpenLevel = isUnlocked && previousLevelCompleted && isDifferentDay;

  print('Attempting to open level $level');
  print('Is Level Unlocked: $isUnlocked');
  print('Is Previous Level Completed: $previousLevelCompleted');
  print('Is Different Day: $isDifferentDay');
  print('Can Open Level: $canOpenLevel');

  if (canOpenLevel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LevelPage(
          level: level,
          onLevelCompleted: _onLevelCompleted,
        ),
      ),
    );
  } else if (isUnlocked && !isDifferentDay) {
    _showDailyGoalIncompleteDialog(); // Mostra il dialogo se il giorno non è diverso
  } else if (!isUnlocked) {
    _showLockedLevelDialog();
  }
}



  void _showDailyGoalIncompleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Obiettivo giornaliero completato'),
        content: const Text('Non puoi accedere a questo livello, hai già svolto il tuo obiettivo giornaliero. Torna domani.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showLockedLevelDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Livello bloccato'),
        content: const Text('Questo livello non è ancora sbloccato.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onLevelCompleted(int level) async {
    setState(() {
      if (_currentLevel <= level) {
        _currentLevel = level + 1; // Sblocca il prossimo livello
        _dailyGoalCompleted = true;

        // Aggiorna lo stato di sblocco per il prossimo livello
        if (_currentLevel - 1 < _levelUnlockStatus.length) {
          _levelUnlockStatus[_currentLevel - 1] = true;
        }
      }
    });

    // Qui puoi chiamare un servizio backend per aggiornare lo stato del completamento del livello
  }

  @override
  Widget build(BuildContext context) {
    final backcolor = ref.watch(accentColorProvider);
    final detcolor = ref.watch(detProvider);
    final lockcolor = ref.watch(lockProvider);

    return Scaffold(
      backgroundColor: backcolor,
      appBar: TopBar(),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          height: 1200,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/background.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              ..._buildLevelButtons(backcolor, detcolor, lockcolor),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  List<Widget> _buildLevelButtons(Color backcolor, Color detcolor, Color lockcolor) {
    final List<Widget> levelButtons = [];
    final List<Offset> positions = [
      Offset(80, 1110),
      Offset(200, 1080),
      Offset(150, 1000),
      Offset(80, 930),
      Offset(220, 870),
      Offset(60, 800),
      Offset(180, 750),
      Offset(120, 690),
      Offset(220, 640),
      Offset(80, 580),
      Offset(140, 530),
      Offset(200, 480),
      Offset(100, 430),
      Offset(220, 390),
      Offset(60, 340),
      Offset(180, 300),
      Offset(120, 260),
      Offset(220, 220),
      Offset(80, 180),
      Offset(150, 140),
      Offset(200, 100),
      Offset(60, 60),
      Offset(180, 20),
      Offset(120, -20),
      Offset(220, -60),
      Offset(80, -100),
      Offset(140, -140),
      Offset(200, -180),
      Offset(100, -220),
      Offset(220, -260),
    ];

    for (int i = 0; i < positions.length; i++) {
      int level = i + 1;
bool isUnlocked = (level == 1) || (level - 1 < _levelUnlockStatus.length && _levelUnlockStatus[level - 1]);

      levelButtons.add(
        Positioned(
          left: positions[i].dx,
          top: positions[i].dy,
          child: GestureDetector(
            onTap: () {
              _openLevel(level);
            },
            child: Container(
              width: 60,
              height: 60,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: BorderSide(
                    color: isUnlocked ? detcolor : lockcolor,
                    width: 6,
                  ),
                ),
                color: backcolor,
                child: Center(
                  child: isUnlocked
                      ? Text('$level', style: TextStyle(fontSize: 20, color: detcolor,fontWeight: FontWeight.bold,))
                      : Icon(Icons.lock, size: 35, color: lockcolor),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return levelButtons;
  }
}
