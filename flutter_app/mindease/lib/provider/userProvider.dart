
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nicknameProvider = StateProvider<String>((ref) => ''); // Provider per gestire il nickname
final passwordProvider = StateProvider<String>((ref) => ''); // Provider per gestire la password
final profileImageProvider = StateProvider<String?>((ref) => null);

final backgroundImageProvider = StateProvider<String?>((ref) => null);
