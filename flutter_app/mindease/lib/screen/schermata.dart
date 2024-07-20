import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mindease/screen/signin.dart';
import 'package:mindease/widget/font.dart';

class Schermata extends StatefulWidget {
  const Schermata({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SchermataState createState() => _SchermataState();
}

class _SchermataState extends State<Schermata> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Avvia il timer per navigare alla HomePage dopo 3 secondi
    _timer = Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) =>  SignInPage()),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Assicurati di cancellare il timer quando lo stato viene eliminato
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Utilizza context.read per accedere al provider
    const backcolor = Color(0xffd2f7ef);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: backcolor, // Colore di sfondo preso dal provider
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Immagine circolare
                Container(
                  width: 250,
                  height: 250,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Testo sotto l'immagine
                const Text(
                  'MindEase',
                  style: AppFonts.screenTitle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
