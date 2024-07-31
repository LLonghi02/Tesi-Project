import 'package:mindease/provider/importer.dart';



class NicknamePage extends ConsumerWidget {

 const  NicknamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(detProvider); // Recupera il colore di sfondo dal provider
    final TextEditingController oldNicknameController = TextEditingController(); // Controller per il vecchio nickname
    final TextEditingController newNicknameController = TextEditingController(); // Controller per il nuovo nickname

    oldNicknameController.text = ref.watch(nicknameProvider); // Inizializza il controller con il vecchio nickname
    String newNickname="";
                String oldNickname = oldNicknameController.text; // Ottieni il vecchio nickname dal controller

    return Scaffold(
      backgroundColor: backcolor,
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Modifica il tuo nickname:',
              style: AppFonts.settTitle,
            ),
            const SizedBox(height: 20),

            TextFormField(
              controller: oldNicknameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nickname',
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value) {
                newNickname=value;
                newNicknameController.text = value;
              },
            ),
            const SizedBox(height: 20),
            CustomTextButton(
              onPressed: () async {

                await mongoDBService.open();
                await mongoDBService.updateUserByNickname(context, oldNickname, newNickname);
                await mongoDBService.close();

                final calendarDBService = CalendarDBService();
                await calendarDBService.open();
                await calendarDBService.updateDBByNickname(context,oldNickname, newNickname);
                await calendarDBService.close();

                final mindfulnessDBService = MindfulnessDBService();
                await mindfulnessDBService.open();
                await mindfulnessDBService.updateLevelByNickname(context,oldNickname, newNickname);
                await mindfulnessDBService.close();


                ref.read(nicknameProvider.notifier).state = newNickname;

               
              },
              buttonText: 'Salva',
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
