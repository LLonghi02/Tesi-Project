import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int> fetchResultCount(String nickname) async {
  final response = await http.post(
    Uri.parse('https://2la86e82af.execute-api.us-east-1.amazonaws.com/default/Calendar_nickname'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'Nickname': nickname}),
  );

  if (response.statusCode == 200) {
    final List<dynamic> responseData = jsonDecode(response.body);

    // Restituisci il numero di risultati
    print(responseData.length);
    return responseData.length;
  } else {
    print('Errore nella richiesta: ${response.statusCode}');
    return 0;
  }
}
