import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindease/provider/userProvider.dart';
import 'package:mindease/repository/login.dart';
import 'package:mindease/screen/home_page.dart';
import 'package:mindease/screen/registrazione.dart';
import 'package:mindease/widget/SignIn/button_1.dart';
import 'package:mindease/widget/SignIn/social_signIn.dart';
import 'package:mindease/widget/font.dart';
import 'package:mindease/widget/SignIn/noAccount.dart';
import 'package:mindease/widget/SignIn/rememberMe.dart';
import 'package:mindease/widget/text_field.dart';
import 'package:mindease/provider/theme.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends ConsumerWidget {
  SignInPage({Key? key}) : super(key: key);

  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _handleGoogleSignIn(BuildContext context, WidgetRef ref) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId: '1068698468225-jei0dqjtdrjmeka2nse9t60himhn5i1c.apps.googleusercontent.com',
      scopes: <String>['email', 'https://www.googleapis.com/auth/contacts.readonly'],
    );

    try {
      await _googleSignIn.signIn();
      // Handle successful Google sign-in here, e.g., navigate to HomePage or save user data
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backColor = ref.watch(accentColorProvider);
    final detColor = ref.watch(signProvider);
    final iconColor = ref.watch(detProvider);

    // Load saved credentials when the widget is built
    _loadCredentials();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo.jpg'),
                radius: 60,
              ),
              const SizedBox(height: 20),
              const Text(
                'Bentornato in MindEase',
                style: AppFonts.sign,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: _nicknameController,
                labelText: 'Nickname',
                suffixIcon: Icons.person,
              ),
              const SizedBox(height: 5),
              MyTextField(
                controller: _passwordController,
                labelText: 'Password',
                suffixIcon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 1),
              RememberMeCheckbox(),
              const SizedBox(height: 3),
              CustomTextButton(
                onPressed: () async {
                  ref.read(nicknameProvider.notifier).state = _nicknameController.text;
                  ref.read(passwordProvider.notifier).state = _passwordController.text;

                  String loginResult = await logIn(
                      _nicknameController.text, _passwordController.text);
                  if (loginResult == 'login successful') {
                    bool rememberMe = await RememberHelper.loadRememberMe();
                    if (rememberMe) {
                      await RememberHelper.saveCredentials(_nicknameController.text, _passwordController.text);
                    } else {
                      await RememberHelper.clearCredentials(); 
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login effettuato con successo')),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(loginResult)),
                    );
                  }
                },
                buttonText: 'Accedi',
              ),
              const SizedBox(height: 10),
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
              SocialSignInButtonsWidget(
                iconColor: iconColor,
                onGoogleSignIn: () => _handleGoogleSignIn(context, ref),
              ),
              SignUpPromptWidget(
                color: detColor,
                label: 'Non hai un account?',
                label2: 'Registrati',
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const RegistrazionePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: backColor,
    );
  }

  Future<void> _loadCredentials() async {
    Map<String, String> credentials = await RememberHelper.loadCredentials();
    _nicknameController.text = credentials['nickname'] ?? '';
    _passwordController.text = credentials['password'] ?? '';
  }
}
