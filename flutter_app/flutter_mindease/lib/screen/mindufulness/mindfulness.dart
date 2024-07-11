import 'package:flutter/material.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/font.dart';
import 'package:flutter_mindease/provider/theme.dart';
import 'package:flutter_mindease/widget/top_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'level_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelSelectionPage extends ConsumerStatefulWidget {
  @override
  _LevelSelectionPageState createState() => _LevelSelectionPageState();
}

class _LevelSelectionPageState extends ConsumerState<LevelSelectionPage> {
  int _currentLevel = 1;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _currentLevel = _prefs.getInt('currentLevel') ?? 1;
  }

void _openLevel(int level) {
  bool isUnlocked = level <= _currentLevel;
  bool dailyGoalCompleted = _prefs.getBool('dailyGoalCompleted_$level') ?? false;

  if (isUnlocked && !dailyGoalCompleted) {
    // Navigate to LevelPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LevelPage(
          level: level,
          onLevelCompleted: _onLevelCompleted,
        ),
      ),
    );
  } else if (isUnlocked && dailyGoalCompleted) {
    // Show dialog if daily goal is completed
    _showDailyGoalCompletedDialog();
  } else {
    // Show dialog if level is locked
    _showLockedLevelDialog();
  }
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
  void _showDailyGoalCompletedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Obiettivo giornaliero completato'),
        content: const Text('Torna domani per continuare con il prossimo livello.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onLevelCompleted(int level) {
    setState(() {
      if (_currentLevel == level) {
        _currentLevel++;
        _prefs.setInt('currentLevel', _currentLevel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final backcolor = ref.watch(accentColorProvider);
    final detcolor = ref.watch(detProvider);
    final lockcolor = ref.watch(lockProvider);

    // Definizione del numero totale di livelli
    int totalLevels = 30;

    return Scaffold(
      backgroundColor: backcolor,
      appBar: const TopBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: GridView.builder(
          reverse: true, // Reverse the grid to start from the bottom
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // One column
            childAspectRatio: 6.0, // Height of the cards (adjust as needed)
          ),
          itemCount: totalLevels,
          itemBuilder: (context, index) {
            int level = index + 1; // Calculate the level number
            bool isUnlocked = level <= _currentLevel;

            return GestureDetector(
              onTap: () => _openLevel(level),
              child: Container(
                width: 50, // Width of the card
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100), // Circular shape
                    side: BorderSide(
                      color: isUnlocked ? detcolor : lockcolor,
                      width: 10,
                    ), // Border
                  ),
                  color: backcolor,
                  child: Center(
                    child: isUnlocked
                        ? Text('$level', style: AppFonts.screenTitle)
                        : Icon(Icons.lock, size: 40, color: lockcolor),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
