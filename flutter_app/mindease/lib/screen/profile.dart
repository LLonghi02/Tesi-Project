import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart'; // Import firstWhereOrNull
import 'package:mindease/provider/importer.dart';

class ProfilePage extends ConsumerStatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late String currentDate;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now().toIso8601String().split('T')[0];
    _loadProfileImage();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh data when the page is viewed
    ref.refresh(calendarProvider(currentDate));
  }

  Future<void> _loadProfileImage() async {
    final imagePath = await loadProfileImage();
    if (imagePath != null) {
      ref.read(profileImageProvider.notifier).state = imagePath;
    }
  }

  @override
  Widget build(BuildContext context) {
    final nickname = ref.watch(nicknameProvider);
    final profileImage = ref.watch(profileImageProvider);

    return Scaffold(
      backgroundColor: const Color(0xffd2f7ef),
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.teal,
                      width: 4,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: profileImage != null && profileImage.isNotEmpty
                        ? profileImage.startsWith('assets/')
                            ? AssetImage(profileImage) as ImageProvider
                            : FileImage(File(profileImage))
                        : const AssetImage('assets/images/user/profilo.png'),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                nickname,
                style: AppFonts.appTitle,
              ),
              const SizedBox(height: 20),
              TrophiesSection(
                objectivesMet: List.generate(20, (index) => index % 2 == 0),
                nickname: nickname,
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Il tuo umore',
                    style: AppFonts.appTitle,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CalendarPage(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/calend.png',
                          height: 150,
                          width: 150,
                        ),
                      ),
                      const SizedBox(width: 10),
const SizedBox(width: 10),
Expanded(
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Container(
      height: 100,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.calendar_today,
                size: 50,
                color: Color(0xffd2f7ef),
              ),
              const SizedBox(height: 5),
              Padding(
padding: const EdgeInsets.only(left: 10.0), // Aggiungi padding solo a sinistra
                child: Text(
                  currentDate,
                  style: AppFonts.calenda,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          FutureBuilder<List<CalendarModel>>(
            future: ref.watch(calendarProvider(currentDate).future),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Errore: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final calendarData = snapshot.data!;
                // Trova l'ultima emozione per la data corrente
                final todayEmotion = calendarData
                    .where((entry) => entry.data == currentDate)
                    .toList()
                    .lastOrNull; // Ottieni l'ultimo elemento o null

                if (todayEmotion != null) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: EmotionCalenda(
                      imageUrl: getEmotionImage(todayEmotion.emozione),
                    ),
                  );
                } else {
                  return const Flexible(
                    child: Text(
                      'non ci hai fatto sapere come stai',
                      style: AppFonts.calenda,
                    ),
                  );
                }
              } else {
                return const Text('Nessun dato disponibile');
              }
            },
          ),
        ],
      ),
    ),
  ),
),

                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
