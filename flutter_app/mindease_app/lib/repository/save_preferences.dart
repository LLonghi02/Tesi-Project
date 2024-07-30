
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveProfileImage(String imagePath) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('profileImage', imagePath);
}

Future<String?> loadProfileImage() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('profileImage');
}

Future<void> saveBackgroundImage(String imagePath) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('backgroundImage', imagePath);
}

Future<String?> loadBackgroundImage() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('backgroundImage');
}
