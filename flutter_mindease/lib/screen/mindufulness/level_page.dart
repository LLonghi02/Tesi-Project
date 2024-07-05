import 'package:flutter/material.dart';
import 'package:flutter_mindease/model/level_information.dart';
import 'package:flutter_mindease/screen/mindufulness/mindfulness.dart';
import 'package:flutter_mindease/widget/bottom_bar.dart';
import 'package:flutter_mindease/widget/font.dart';
import 'package:flutter_mindease/widget/theme.dart';
import 'package:flutter_mindease/widget/top_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LevelPage extends ConsumerStatefulWidget {
  final int level;
  final Function(int) onLevelCompleted;

  LevelPage({required this.level, required this.onLevelCompleted});

  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends ConsumerState<LevelPage> {
  bool _isCompleted = false;

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
              ), // Add rounded corners to image
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
                        fillColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        checkColor: Colors.teal,
                        value: _isCompleted,
                        onChanged: (bool? value) {
                          setState(() {
                            _isCompleted = value ?? false;
                          });
                          if (_isCompleted) {
                            widget.onLevelCompleted(widget.level);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LevelSelectionPage()),
                            );
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
