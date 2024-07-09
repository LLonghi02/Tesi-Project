import 'package:flutter/material.dart';

class RememberMeCheckbox extends StatefulWidget {
  const RememberMeCheckbox({Key? key}) : super(key: key);

  @override
  _RememberMeCheckboxState createState() => _RememberMeCheckboxState();
}

class _RememberMeCheckboxState extends State<RememberMeCheckbox> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Checkbox(
          fillColor: WidgetStatePropertyAll(Colors.white),
          checkColor: Colors.teal, // Colore del segno di spunta preso dal tema
          value: _rememberMe,
          onChanged: (bool? value) {
            setState(() {
              _rememberMe = value ?? false;
            });
          },
        ),
        const Text('Ricordati di me'),
      ],
    );
  }
}
