import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as fb_auth;

Future<void> loginWithFacebook() async {
  try {
    // Esegui il login con Facebook
    print('Inizio del processo di login...');
    final result = await fb_auth.FacebookAuth.instance.login(
      permissions: ['public_profile', 'email'], // Permessi richiesti
    );

    print('Risultato del login: ${result.status}');

    if (result.status == fb_auth.LoginStatus.success) {
      // Se il login ha successo, ottieni il token
      final fb_auth.AccessToken accessToken = result.accessToken!;
      //print('Token di accesso: ${accessToken.token}');

      // Usa il token per fare richieste all'API di Facebook o al tuo backend
      // Puoi anche ottenere i dati dell'utente
      final userData = await fb_auth.FacebookAuth.instance.getUserData();
      print('Dati dell\'utente: $userData');
      print('Nome utente: ${userData['name']}');
      print('Email: ${userData['email']}');

      // Gestisci il login di successo qui, ad esempio, naviga a una schermata successiva
    } else {
      // Gestisci il caso in cui il login non ha successo
      print('Login fallito con stato: ${result.status}');
    }
  } catch (e) {
    // Gestisci eventuali errori
    print('Errore durante il login: $e');
  }
}
