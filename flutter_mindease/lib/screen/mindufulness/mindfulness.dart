import 'package:flutter/material.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/theme.dart';
import 'package:flutter_mindease/widget/top_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'level_page.dart';

class LevelSelectionPage extends ConsumerStatefulWidget {
  @override
  _LevelSelectionPageState createState() => _LevelSelectionPageState();
}

class _LevelSelectionPageState extends ConsumerState<LevelSelectionPage> {
  int _currentLevel = 1;

  void _openLevel(int level) {
    if (level <= _currentLevel) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LevelPage(
            level: level,
            onLevelCompleted: _onLevelCompleted,
          ),
        ),
      );
    }
  }

  void _onLevelCompleted(int level) {
    setState(() {
      if (_currentLevel == level) {
        _currentLevel++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final backcolor = ref.watch(accentColorProvider);

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
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            int level = index + 1;
            bool isUnlocked = level <= _currentLevel;
            return GestureDetector(
              onTap: () => _openLevel(level),
              child: Card(
                color: isUnlocked ? Colors.green : Colors.grey,
                child: Center(child: Text('Level $level')),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
