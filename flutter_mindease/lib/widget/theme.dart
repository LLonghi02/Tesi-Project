import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final brightnessProvider = StateProvider<Brightness>((ref) => Brightness.light);

final accentColorProvider = StateProvider<Color>((ref) =>const Color(0xffd2f7ef));
final barColorProvider = StateProvider<Color>((ref) =>const Color(0xFFA9EED8));
final detProvider = StateProvider<Color>((ref) =>const Color(0xFF4FA69E));
final signProvider = StateProvider<Color>((ref) =>const Color(0xFF04438A));
final backgrounDetail = StateProvider<Color>((ref) =>const Color(0xFF6fc6cd));

