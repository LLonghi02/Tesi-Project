import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mindease/model/calendar_model.dart';

final calendarProvider = FutureProvider.family<List<CalendarModel>, String>((ref, date) async {
  var url = Uri.parse('https://y57w4bg3la.execute-api.us-east-1.amazonaws.com/default/Calendar_emotion');
  var body = jsonEncode(<String, String>{
    'Data': date,
  });

  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: body,
  );

  if (response.statusCode == 200) {
    List<dynamic> responseData = jsonDecode(response.body);
    return responseData.map((json) => CalendarModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load calendar data');
  }
});
