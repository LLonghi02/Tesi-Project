import 'package:flutter/material.dart';
import 'package:flutter_mindease/repository/login.dart';
import 'package:flutter_mindease/screen/home_page.dart';
import 'package:flutter_mindease/screen/registrazione.dart';
import 'package:flutter_mindease/widget/button_1.dart';
import 'package:flutter_mindease/widget/font.dart';
import 'package:flutter_mindease/widget/noAccount.dart';
import 'package:flutter_mindease/widget/rememberMe.dart';
import 'package:flutter_mindease/widget/social_signIn.dart';
import 'package:flutter_mindease/widget/text_field.dart';
import 'package:flutter_mindease/widget/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInPage extends ConsumerWidget {
  SignInPage({Key? key}) : super(key: key);

  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backColor = ref.watch(accentColorProvider);
    final detColor = ref.watch(signProvider);
    final iconColor = ref.watch(detProvider);

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
                    String loginResult = await logIn(
                        _nicknameController.text, _passwordController.text);
                    if (loginResult == 'login successful') {
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
              SocialSignInButtonsWidget(iconColor: iconColor),
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


}
