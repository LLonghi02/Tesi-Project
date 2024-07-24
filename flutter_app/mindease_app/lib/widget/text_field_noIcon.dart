import 'package:flutter/material.dart';

class MyTextField2 extends StatelessWidget {
  final String labelText;
  final TextEditingController controller; // Aggiungi il controller come parametro

  const MyTextField2({
    Key? key,
    required this.labelText,
    required this.controller, // Assicurati di aggiungere questo parametro
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Usa il controller nel TextField
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
