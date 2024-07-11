// custom_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_mindease/provider/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTextButton extends ConsumerWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const CustomTextButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonColor = ref.watch(barColorProvider); // Recupera il colore di sfondo dal provider
    final detColor = ref.watch(signProvider); // Recupera il colore del testo dal provider

    return Container(
      alignment: Alignment.center,
      width: 200, // Imposta la larghezza del pulsante
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 20, vertical: 16)), // Padding del pulsante
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0), // Bordo del pulsante arrotondato
            ),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(color: detColor), // Colore del testo
        ),
      ),
    );
  }
}
