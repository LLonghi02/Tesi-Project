import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindease/provider/importer.dart';

Future<void> handleGoogleSignIn(BuildContext context, WidgetRef ref) async {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly'
    ],
  );

  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      // L'utente ha annullato il login
      return;
    }

    final String? email = googleUser.email;
    final String? displayName = googleUser.displayName;

    if (email == null || displayName == null) {
      // Se non c'è un'email o un nome, assegna valori predefiniti
      ref.read(nicknameProvider.notifier).state = 'Guest';
      return;
    }

    // Verifica se l'utente esiste già
    if (await mongoDBService.isUserExists(email)) {
      // Aggiorna il nickname se necessario
      String currentNickname = await mongoDBService.getNicknameByEmail(email);
      if (currentNickname != displayName) {
        await mongoDBService.updateNickname(email, displayName);
      }
    } else {
      // Registra un nuovo utente
      await mongoDBService.registerUserSocial(email, displayName);
    }

    // Imposta il nickname nel provider
    ref.read(nicknameProvider.notifier).state = displayName;

    // Naviga alla HomePage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  } catch (error) {
    print(error);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Google sign-in failed: $error')),
    );
  }
}
