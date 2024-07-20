import 'package:flutter/material.dart';
import 'package:mindease/screen/signin.dart';
import 'package:mindease/screen/home_page.dart';
import 'package:mindease/widget/SignIn/button_1.dart';
import 'package:mindease/widget/SignIn/social_signIn.dart';
import 'package:mindease/widget/font.dart';
import 'package:mindease/widget/SignIn/noAccount.dart';
import 'package:mindease/widget/SignIn/rememberMe.dart';
import 'package:mindease/widget/text_field.dart';
import 'package:mindease/provider/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindease/repository/mongoDB.dart';

// Provider for MongoDB service
final mongoDBServiceProvider =
    Provider<MongoDBService>((ref) => MongoDBService());

// Registration Page Widget
class RegistrazionePage extends ConsumerStatefulWidget {
  const RegistrazionePage({Key? key}) : super(key: key);

  @override
  _RegistrazionePageState createState() => _RegistrazionePageState();
}

class _RegistrazionePageState extends ConsumerState<RegistrazionePage> {
  final _emailController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nicknameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mongoDBService = ref.read(mongoDBServiceProvider);
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
                'Crea il tuo account',
                style: AppFonts.sign,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: _emailController,
                labelText: 'E-mail',
                suffixIcon: Icons.mail,
              ),
              const SizedBox(height: 5),
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
                  String email = _emailController.text;
                  String nickname = _nicknameController.text;
                  String password = _passwordController.text;

                  await mongoDBService.open();
                  await mongoDBService.registerUser(context,email, nickname, password);
                  await mongoDBService.close();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) =>  SignInPage()),
                  );
                },
                buttonText: 'Registrami',
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
              //SocialSignInButtonsWidget(iconColor: iconColor),
              SignUpPromptWidget(
                color: detColor,
                label: 'Hai un account?',
                label2: 'SignIn',
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) =>  SignInPage()),
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
