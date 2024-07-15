import 'package:flutter/material.dart';
import 'package:mindease/widget/bottom_bar.dart';
import 'package:mindease/widget/font.dart';
import 'package:mindease/provider/theme.dart';
import 'package:mindease/widget/top_bar.dart';
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

    return Scaffold(
      backgroundColor: backcolor,
      appBar: const TopBar(),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          height: 1200, // Set height to fit all levels
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
  Offset(80, 1110), Offset(200, 1080), Offset(150, 1000), Offset(80, 930), Offset(220, 870),
  Offset(60, 800), Offset(180, 750), Offset(120, 690), Offset(220, 640), Offset(80, 580),
  Offset(140, 530), Offset(200, 480), Offset(100, 430), Offset(220, 390), Offset(60, 340),
  Offset(180, 300), Offset(120, 260), Offset(220, 220), Offset(80, 180), Offset(150, 140),
  Offset(200, 100), Offset(60, 60), Offset(180, 20), Offset(120, -20), Offset(220, -60),
  Offset(80, -100), Offset(140, -140), Offset(200, -180), Offset(100, -220), Offset(220, -260)
];

    for (int i = 0; i < positions.length; i++) {
      int level = i + 1;
      bool isUnlocked = level <= _currentLevel;

      levelButtons.add(
        Positioned(
          left: positions[i].dx,
          top: positions[i].dy,
          child: GestureDetector(
            onTap: () => _openLevel(level),
            child: Container(
              width: 60,
              height: 60,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: BorderSide(
                    color: isUnlocked ? detcolor : lockcolor,
                    width: 4,
                  ),
                ),
                color: backcolor,
                child: Center(
                  child: isUnlocked
                      ? Text('$level', style: AppFonts.screenTitle)
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
