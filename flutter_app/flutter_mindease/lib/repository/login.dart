import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> logIn(String nickname, String password) async {
  var url = Uri.parse(
      'https://pqfgb1jyz0.execute-api.us-east-1.amazonaws.com/default/MindEase_login');
  var body = jsonEncode(<String, String>{
    'nickname': nickname,
    'password': password,
  });

  print('Sending POST request to $url');
  print('Request body: $body');

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
    var responseBody = jsonDecode(response.body);
    if (responseBody['Message'] == 'Success') {
      return 'login successful'; // Login successful
    } else {
      return responseBody['Message'] ?? 'login failed'; // Login failed with specific reason
    }
  } else if (response.statusCode == 404) {
    return 'Incorrect Nickname or Password'; // Email or password not found
  } else {
    return 'Server error: ${response.statusCode}'; // Server error with response status code
  }
}

