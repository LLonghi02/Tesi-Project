import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mindease/model/level_information.dart';
import 'package:mindease/widget/bottom_bar.dart';
import 'package:mindease/widget/font.dart';
import 'package:mindease/provider/theme.dart';
import 'package:mindease/widget/top_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelPage extends ConsumerStatefulWidget {
  final int level;
  final Function(int) onLevelCompleted;

  LevelPage({required this.level, required this.onLevelCompleted});

  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends ConsumerState<LevelPage> {
  bool _isCompleted = false;
  bool _dailyGoalCompleted = false;

  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _checkCompletionStatus();
    _checkDailyGoal();
  }

  void _checkCompletionStatus() {
    setState(() {
      _isCompleted = _prefs.getBool('isCompleted_${widget.level}') ?? false;
      print('Level ${widget.level} completion status: $_isCompleted'); // Debugging output
    });
  }

  void _checkDailyGoal() {
    final String lastCompletionDate = _prefs.getString('lastCompletionDate_${widget.level}') ?? '';
    final DateTime now = DateTime.now();
    final String today = '${now.year}-${now.month}-${now.day}';

    if (lastCompletionDate != today) {
      _dailyGoalCompleted = false;
      _prefs.setBool('dailyGoalCompleted_${widget.level}', false);
    } else {
      _dailyGoalCompleted = _prefs.getBool('dailyGoalCompleted_${widget.level}') ?? false;
    }
    setState(() {});
  }

  void _completeLevel() async {
    final DateTime now = DateTime.now();
    final String today = '${now.year}-${now.month}-${now.day}';

    await _prefs.setBool('dailyGoalCompleted_${widget.level}', true);
    await _prefs.setString('lastCompletionDate_${widget.level}', today);
    await _prefs.setBool('isCompleted_${widget.level}', true); // Memorizza lo stato di completamento
    widget.onLevelCompleted(widget.level);
    setState(() {
      _isCompleted = true;
      _dailyGoalCompleted = true;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    LevelInformation levelInfo = LevelInformation.getLevel(widget.level);
    final backcolor = ref.watch(accentColorProvider);
    final infocolor = ref.watch(barColorProvider);
    final titlecolor = ref.watch(detProvider);

    return Scaffold(
      backgroundColor: backcolor,
      appBar: const TopBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/montagna.jpg',
                  fit: BoxFit.cover,
                  width: 350,
                  height: 250,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                  color: titlecolor,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: titlecolor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Checkbox(
                        fillColor: MaterialStateProperty.all<Color>(Colors.white),
                        checkColor: Colors.teal,
                        value: _isCompleted,
                        onChanged: (bool? value) {
                          if (value == true && !_dailyGoalCompleted) {
                            _completeLevel();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          levelInfo.title,
                          style: AppFonts.calenda,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: 350,
                decoration: BoxDecoration(
                  color: infocolor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(205, 121, 85, 72),
                      offset: Offset(0, 4),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Text(levelInfo.description),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
