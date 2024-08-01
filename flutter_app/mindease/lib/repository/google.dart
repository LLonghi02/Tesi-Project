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

    // Ottieni il nome visualizzato dall'account Google
    final String? nickname = googleUser.displayName;

    // Aggiorna il provider del nickname
    ref.read(nicknameProvider.notifier).state = nickname ?? 'Guest';

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
