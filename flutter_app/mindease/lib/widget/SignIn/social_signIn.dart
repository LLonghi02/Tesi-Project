import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mindease/repository/facebook.dart';

class SocialSignInButtonsWidget extends StatelessWidget {
  final Color iconColor;
  final VoidCallback onGoogleSignIn; // Add a callback for Google sign-in

  const SocialSignInButtonsWidget({
    Key? key,
    required this.iconColor,
    required this.onGoogleSignIn, // Initialize the callback
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
            onPressed: onGoogleSignIn, // Use the callback
            icon: Icon(
              FontAwesomeIcons.google,
              color: iconColor,
              size: 40,
            ),
          ),
        ),
        /*const SizedBox(width: 20),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            onPressed: loginWithFacebook,
            icon: Icon(
              FontAwesomeIcons.facebook,
              color: iconColor,
              size: 40,
            ),
          ),
        ),*/
      ],
    );
  }
}
