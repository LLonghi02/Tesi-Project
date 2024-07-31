import 'package:mindease/provider/importer.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindease/provider/theme.dart';

class SignInPage extends ConsumerWidget {
  SignInPage({Key? key}) : super(key: key);
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const RememberMeCheckbox(),
                  const SizedBox(width: 40),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecoverpasswordPage()),
                      );
                    },
                    child: Text(
                      'Non ricordo la password',
                      style: TextStyle(
                        color: detColor, // Cambia colore a tuo piacimento
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              CustomTextButton(
                onPressed: () async {
                  ref.read(nicknameProvider.notifier).state =
                      _nicknameController.text;
                  ref.read(passwordProvider.notifier).state =
                      _passwordController.text;
                  String loginResult = await logIn(
                      _nicknameController.text, _passwordController.text);
                  if (loginResult == 'login successful') {
                    bool rememberMe = await RememberHelper.loadRememberMe();
                    if (rememberMe) {
                      await RememberHelper.saveCredentials(
                          _nicknameController.text, _passwordController.text);
                    } else {
                      await RememberHelper.clearCredentials();
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Login effettuato con successo')),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
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
                onGoogleSignIn: () => handleGoogleSignIn(context),
              ),
              SignUpPromptWidget(
                color: detColor,
                label: 'Non hai un account?',
                label2: 'Registrati',
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (_) => const RegistrazionePage()),
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