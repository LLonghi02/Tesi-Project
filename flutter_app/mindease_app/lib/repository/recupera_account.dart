import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:http/http.dart' as http;
import 'package:mindease_app/provider/importer.dart';

Future<void> shareAccount(
  BuildContext context,
  WidgetRef ref,
  TextEditingController emailController,
) async {
  final email = emailController.text;

  if (email.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Questa e-mail non ha account associati')),
    );
    return;
  }

  final response = await http.post(
    Uri.parse('https://dg7q15jv5m.execute-api.us-east-1.amazonaws.com/default/Recupero_account'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email}),
  );

  if (response.statusCode == 200) {
    final List<dynamic> responseData = jsonDecode(response.body);

    final extractedData = responseData.map((user) {
      return {
        "Nickname": user["nickname"],
        "Password": user["password"]
      };
    }).toList();

    final emailBody = 'Questi sono i tuoi dati:\n\n' +
        extractedData.map((data) => 
          'Nickname: ${data["Nickname"]}\n' +
          'Password: ${data["Password"]}\n\n'
        ).join('');

    await sendEmailAccount(context, email, emailBody);

  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Errore durante il recupero dei dati')),
    );
  }
}

Future<void> sendEmailAccount(BuildContext context, String recipient, String body) async {
  final Email email = Email(
    body: body,
    subject: 'I dati del tuo account MindEase',
    recipients: [recipient],
    isHTML: false,
  );

    // Naviga alla pagina di accesso dopo aver inviato l'email
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );

  try {
    await FlutterEmailSender.send(email);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Recupero avvenuto con successo!')),
    );
  } catch (error) {
    print('Errore durante l\'invio della email: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Errore durante l\'invio dell\'email. Assicurati di avere un client email configurato.')),
    );
  }
}