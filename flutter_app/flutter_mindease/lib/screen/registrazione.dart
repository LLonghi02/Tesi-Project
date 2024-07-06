import 'package:flutter/material.dart';
import 'package:flutter_mindease/screen/Sign_in.dart';
import 'package:flutter_mindease/widget/font.dart';
import 'package:flutter_mindease/widget/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Provider per l'autenticazione
final signInProvider = Provider<SignIn>((ref) => SignIn());

class SignIn {
  // Implementa qui la logica per l'autenticazione con Firebase o altri provider

  SignIn();

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    // Esempio di implementazione del sign-in con email e password
    print('Signing in with email: $email, password: $password');
    // Aggiungi qui la tua logica per l'autenticazione
  }

  Future<void> signInWithGoogle() async {
    // Esempio di implementazione del sign-in con Google
    print('Signing in with Google');
    // Aggiungi qui la tua logica per l'autenticazione con Google
  }

  Future<void> signInWithFacebook() async {
    // Esempio di implementazione del sign-in con Facebook
    print('Signing in with Facebook');
    // Aggiungi qui la tua logica per l'autenticazione con Facebook
  }
}

class RegistrazionePage extends ConsumerWidget {
  const RegistrazionePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signIn = ref.read(signInProvider);
    final iconColor =
        ref.watch(detProvider); // Recupera il colore delle icone dal provider
    final buttonColor = ref
        .watch(barColorProvider); // Recupera il colore di sfondo dal provider
    final backColor = ref.watch(accentColorProvider);
    final detColor = ref.watch(signProvider);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Immagine rotonda del logo
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo.jpg'),
                radius: 60,
              ),
              const SizedBox(height: 20),
              // Scritta
              const Text(
                'Crea il tuo account',
                style: AppFonts.sign,
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.mail,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Nickname',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // TextField per la password
              const Row(
                children: [
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              // Checkbox per 'Ricordati di me'
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (bool? value) {
                      // Aggiungi qui la logica per gestire il valore del checkbox
                    },
                  ),
                  const Text('Ricordati di me'),
                ],
              ),
              const SizedBox(height: 5),
              // Tasto del SignIn
              ElevatedButton(
                onPressed: () {
                  // Esempio di sign-in con email e password
                  signIn.signInWithEmailAndPassword(
                      'test@example.com', 'password');
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(buttonColor),
                ),
                child: Text(
                  'Registrami',
                  style: TextStyle(color: detColor),
                ),
              ),
              
              const SizedBox(height: 10),
              //riga or
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(color: detColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'or',
                      style: TextStyle(
                        color: iconColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: detColor),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              // Accesso con Google o Facebook
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () {
                        signIn.signInWithGoogle();
                      },
                      icon: Icon(FontAwesomeIcons.google,
                          color: iconColor, size: 40),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () {
                        signIn.signInWithFacebook();
                      },
                      icon: Icon(FontAwesomeIcons.facebook,
                          color: iconColor, size: 40),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:5,horizontal: 10),
                    child: Text(
                      'Hai già un account?',
                      style: TextStyle(
                        color: detColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (_) => const SignInPage()),
                      );
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        color: detColor, // Cambia colore a tuo piacimento
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: backColor, // Imposta il colore di sfondo della schermata
    );
  }
}
