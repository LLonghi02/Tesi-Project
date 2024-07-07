import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialSignInButtonsWidget extends StatelessWidget {
  final Color iconColor; // Colore delle icone

  const SocialSignInButtonsWidget({
    Key? key,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
              // Gestisci l'accesso con Google

            },
            icon: Icon(
              FontAwesomeIcons.google,
              color: iconColor,
              size: 40,
            ),
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
              // Gestisci l'accesso con Facebook
            },
            icon: Icon(
              FontAwesomeIcons.facebook,
              color: iconColor,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
}
