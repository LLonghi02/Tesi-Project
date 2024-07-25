import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<String> logIn(String nickname, String password) async {
  var url = Uri.parse(
      'https://ma24de1q49.execute-api.us-east-1.amazonaws.com/default/MindEase_login');
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


class RememberHelper {
  static Future<void> saveCredentials(String nickname, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nickname', nickname);
    prefs.setString('password', password);
  }

  static Future<Map<String, String>> loadCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nickname = prefs.getString('nickname') ?? '';
    String password = prefs.getString('password') ?? '';
    return {'nickname': nickname, 'password': password};
  }

  static Future<void> clearCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('nickname');
    prefs.remove('password');
  }

  static Future<bool> loadRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('remember_me') ?? false;
  }

  static Future<void> saveRememberMe(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('remember_me', value);
  }
}
