import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Map<String, dynamic>>?> levelStory(String nickname) async {
  var url = Uri.parse(
      'https://qil94mawgk.execute-api.us-east-1.amazonaws.com/default/Mindfulness_nickname');
  var body = jsonEncode(<String, String>{
    'Nickname': nickname,
  });

  print('Sending POST request to $url');
  print('Request body: $body');

  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Parse the JSON response
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      print('Failed to load level story');
      return null;
    }
  } catch (e) {
    print('Error occurred while sending the POST request: $e');
    return null;
  }
}
