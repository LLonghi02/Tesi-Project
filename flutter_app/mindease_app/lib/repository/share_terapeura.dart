import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:http/http.dart' as http;
import 'package:mindease_app/provider/importer.dart';

Future<void> shareData(
  BuildContext context,
  WidgetRef ref,
  TextEditingController nameController,
  TextEditingController emailController,
) async {
  final nickname = ref.read(nicknameProvider);

  if (nickname == null || nickname.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nickname non valido')),
    );
    return;
  }

  final response = await http.post(
    Uri.parse('https://uwzyouum4m.execute-api.us-east-1.amazonaws.com/default/calendar_nickname'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'Nickname': nickname}),
  );

  if (response.statusCode == 200) {
    final List<dynamic> responseData = jsonDecode(response.body);

    final extractedData = responseData.map((user) {
      return {
        "Data": user["Data"],
        "Emozione": user["Emozione"],
        "Causa": user["Causa"],
        "Sintomi": (user["Sintomi"] as List<dynamic>).join(", "),
      };
    }).toList();

    final emailBody = 'Questi sono i dati di ${nameController.text}:\n\n' +
        extractedData.map((data) => 
          'Data: ${data["Data"]}\n' +
          'Emozione: ${data["Emozione"]}\n' +
          'Causa: ${data["Causa"]}\n' +
          'Sintomi: ${data["Sintomi"]}\n\n'
        ).join(',');

    await sendEmail(context, emailController.text, emailBody, nameController);

  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Errore durante il recupero dei dati')),
    );
  }
}

Future<void> sendEmail(BuildContext context, String recipient, String body, TextEditingController nameController) async {
  final Email email = Email(
    body: body,
    subject: 'Dati di ${nameController.text}',
    recipients: [recipient],
    isHTML: false,
  );

  try {
    await FlutterEmailSender.send(email);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Condivisione col terapeuta avvenuta con successo!')),
    );
  } catch (error) {
    print('Errore durante l\'invio della email: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Errore durante l\'invio dell\'email. Assicurati di avere un client email configurato.')),
    );
  }
}
