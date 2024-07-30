import 'dart:async';
import 'package:mindease_app/provider/importer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelSelectionPage extends ConsumerStatefulWidget {
  @override
  _LevelSelectionPageState createState() => _LevelSelectionPageState();
}

class _LevelSelectionPageState extends ConsumerState<LevelSelectionPage> {
  int _currentLevel = 1;
  DateTime? _lastCompletionDate;
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      setState(() {
        _currentLevel = _prefs?.getInt('currentLevel') ?? 1;
        String? lastCompletionDateStr = _prefs?.getString('lastCompletionDate');
        _lastCompletionDate = lastCompletionDateStr != null
            ? DateTime.tryParse(lastCompletionDateStr)
            : null;
      });
    } catch (e) {
      print('Errore durante l\'inizializzazione di SharedPreferences: $e');
    }
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  bool isNextDay(DateTime date1, DateTime date2) {
    return date1.add(Duration(days: 1)).day == date2.day &&
           date1.add(Duration(days: 1)).month == date2.month &&
           date1.add(Duration(days: 1)).year == date2.year;
  }

  void _openLevel(int level) async {
    if (_prefs == null) {
      print('SharedPreferences non è stato inizializzato');
      return;
    }

    bool isUnlocked = level == 1 || level <= _currentLevel;
    bool dailyGoalCompleted = _prefs?.getBool('dailyGoalCompleted_$level') ?? false;
    DateTime? lastCompletionTime = DateTime.tryParse(_prefs?.getString('lastCompletionTime_$level') ?? '');

    bool canOpenLevel = isUnlocked && (level == 1 || (dailyGoalCompleted && (lastCompletionTime != null && isNextDay(lastCompletionTime, DateTime.now()))));

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
    } else if (isUnlocked) {
      _showDailyGoalIncompleteDialog();
    } else {
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

  void _showDailyGoalIncompleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Obiettivo giornaliero completato'),
        content: const Text('Non puoi accedere a questo livello, hai già svolto il tuo obiettivo giornaliero. Torna domani'),
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
    if (_prefs == null) {
      print('SharedPreferences non è stato inizializzato');
      return;
    }

    DateTime now = DateTime.now();
    String today = '${now.year}-${now.month}-${now.day}';

    setState(() {
      if (_currentLevel <= level) {
        _currentLevel = level + 1; // Sblocca il prossimo livello
        _prefs?.setInt('currentLevel', _currentLevel);
        _prefs?.setString('lastCompletionDate', today); // Registra l'ultimo giorno di completamento
      }
    });

    await _prefs?.setBool('dailyGoalCompleted_$level', true);
    await _prefs?.setString('lastCompletionTime_$level', now.toIso8601String());
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

  List<Widget> _buildLevelButtons(
      Color backcolor, Color detcolor, Color lockcolor) {
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
      Offset(220, -260)
    ];

    for (int i = 0; i < positions.length; i++) {
      int level = i + 1;
      bool isUnlocked = level == 1 || level <= _currentLevel;
      bool dailyGoalCompleted = _prefs?.getBool('dailyGoalCompleted_$level') ?? false;
      DateTime? lastCompletionTime = DateTime.tryParse(_prefs?.getString('lastCompletionTime_$level') ?? '');

      bool canOpenLevel = isUnlocked && (level == 1 || (dailyGoalCompleted && (lastCompletionTime != null && isNextDay(lastCompletionTime, DateTime.now()))));

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
                    color: canOpenLevel ? detcolor : lockcolor,
                    width: 4,
                  ),
                ),
                color: backcolor,
                child: Center(
                  child: canOpenLevel
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
