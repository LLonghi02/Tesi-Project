
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final nicknameProvider = StateProvider<String>((ref) => ''); // Provider per gestire il nickname
final passwordProvider = StateProvider<String>((ref) => ''); // Provider per gestire la password
final profileImageProvider = StateProvider<File?>((ref) => null);
