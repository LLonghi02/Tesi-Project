import 'package:flutter/material.dart';

class SignUpPromptWidget extends StatelessWidget {
  final Color color; // Colore del testo
  final String label; // Testo del label
  final String label2; // Testo del label

  final VoidCallback onTap; // Azione da eseguire al tap

  const SignUpPromptWidget({
    Key? key,
    required this.color,
    required this.label,
    required this.label2,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 16,
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            label2,
            style: TextStyle(
              color: color, // Cambia colore a tuo piacimento
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
