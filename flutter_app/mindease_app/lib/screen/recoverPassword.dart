import 'package:mindease_app/provider/importer.dart';


class RecoverpasswordPage extends ConsumerStatefulWidget {
  const RecoverpasswordPage({Key? key}) : super(key: key);

  @override
  _RecoverpasswordPageState createState() => _RecoverpasswordPageState();
}

class _RecoverpasswordPageState extends ConsumerState<RecoverpasswordPage> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final backColor = ref.watch(accentColorProvider);

    return Scaffold(
      backgroundColor: backColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Inserisci la tua e-mail per recuperare le tue credenziali',
              style: AppFonts.settTitle,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'e-mail',
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 20),
            CustomTextButton(
              onPressed: () => shareAccount(context, ref,  _emailController),
              buttonText: 'Recupera Password',
            ),
          ],
        ),
      ),
    );
  }
}
