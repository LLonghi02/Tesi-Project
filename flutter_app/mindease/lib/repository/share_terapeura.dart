import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mindease/provider/userProvider.dart';

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
    final responseData = jsonDecode(response.body);

    // Estrai i dati desiderati
    final extractedData = responseData.map((user) {
      return {
        "Data": user["Data"],
        "Emozione": user["Emozione"],
        "Causa": user["Causa"],
        "Sintomi": user["Sintomi"].join(", "),
      };
    }).toList();

    // ignore: prefer_interpolation_to_compose_strings
    final emailBody = 'Questi sono i dati di ${nameController.text}:\n\n' +
        extractedData.map((data) => 
          'Data: ${data["Data"]}\n' +
          'Emozione: ${data["Emozione"]}\n' +
          'Causa: ${data["Causa"]}\n' +
          'Sintomi: ${data["Sintomi"]}\n\n'
        ).join(',');

    await sendEmail(emailController.text, emailBody, nameController);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Condivisione col terapeuta avvenuta con successo!')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Errore durante il recupero dei dati')),
    );
  }
}

Future<void> sendEmail(String recipient, String body, TextEditingController nameController) async {
  final Email email = Email(
    body: body,
    subject: 'Dati di ${nameController.text}',
    recipients: [recipient],
    isHTML: false,
  );

  try {
    await FlutterEmailSender.send(email);
  } catch (error) {
    print('Errore durante l\'invio della email: $error');
    throw error; //PlatformException(not_available, No email clients found!, null, null)
  }
}
