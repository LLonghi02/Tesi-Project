import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindease/provider/importer.dart';
import 'package:mindease/repository/level_history.dart';
import 'package:mindease/repository/mind_level.dart';
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

  final MindfulnessDBService _dbService = MindfulnessDBService();

  @override
  void initState() {
    super.initState();
    _checkCompletionStatus();
  }

  Future<void> _checkCompletionStatus() async {
    final String nickname = ref.read(nicknameProvider);

    try {
      // Chiamata alla funzione aggiornata che ora restituisce una lista
      var levelDataList = await levelStory(nickname);
      if (levelDataList != null) {
        // Trova se il livello attuale è stato completato
        bool completed = levelDataList.any((data) => data['Livello'] == widget.level.toString());
        setState(() {
          _isCompleted = completed;
        });
      } else {
        print('Failed to fetch level story.');
      }
    } catch (e) {
      print('Error fetching level story: $e');
    }
  }

  Future<void> _completeLevel() async {
    final String nickname = ref.read(nicknameProvider);

    try {
      await _dbService.recordLevel(widget.level.toString(), nickname);
      setState(() {
        _isCompleted = true;
      });
      widget.onLevelCompleted(widget.level);
      Navigator.pop(context);
    } catch (e) {
      print('Error recording level completion: $e');
    }
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
                    Checkbox(
                      fillColor: MaterialStateProperty.all<Color>(Colors.white),
                      checkColor: Colors.teal,
                      value: _isCompleted,
                      onChanged: (bool? value) {
                        if (value == true && !_isCompleted) {
                          _completeLevel();
                        }
                      },
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
