import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:mindease/provider/importer.dart';

Future<void> handleGoogleSignIn(BuildContext context) async {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '932816395142-de98ubeepan61sk7ho2fc3khshicuvd2.apps.googleusercontent.com',
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

    // Handle successful Google sign-in here, e.g., navigate to HomePage or save user data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  HomePage()),
    );
  } catch (error) {
    print(error);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Google sign-in failed: $error')),
    );
  }
}
