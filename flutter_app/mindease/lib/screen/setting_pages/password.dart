import 'package:mindease/provider/importer.dart';




class PasswordPage extends ConsumerWidget {

 const  PasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(detProvider); // Recupera il colore di sfondo dal provider
    final TextEditingController oldPasswordController = TextEditingController(); // Controller per il vecchio nickname
    final TextEditingController newPasswordController = TextEditingController(); // Controller per il nuovo nickname

    oldPasswordController.text = ref.watch(passwordProvider); // Inizializza il controller con il vecchio nickname
    String newPassword="";
                String oldPassword = oldPasswordController.text; // Ottieni il vecchio nickname dal controller

    return Scaffold(
      backgroundColor: backcolor,
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Modifica la password:',
              style: AppFonts.settTitle,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: oldPasswordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value) {
                newPassword=value;
                newPasswordController.text = value;
              },
            ),
            const SizedBox(height: 20),
            CustomTextButton(
              onPressed: () async {

                await mongoDBService.open();
                await mongoDBService.updateUserByPassword(oldPassword, newPassword);
                await mongoDBService.close();

                // Aggiorna il vecchio nickname con il nuovo nickname nel provider
                ref.read(passwordProvider.notifier).state = newPassword;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password salvata con successo!')),
                );
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
