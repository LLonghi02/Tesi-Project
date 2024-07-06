import 'package:flutter/material.dart';
import 'package:flutter_mindease/screen/settings.dart';
import 'package:flutter_mindease/widget/font.dart';
import 'package:flutter_mindease/widget/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopBar extends ConsumerWidget implements PreferredSizeWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accentColor = ref.watch(barColorProvider);
    final iconColor = ref.watch(detProvider);
    
    return AppBar(
      backgroundColor: accentColor,
      title: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage('assets/images/logo.jpg'), // Path to the image in your project
          ),
          const SizedBox(width: 8), // Space between the image and text
          const Text(
            'MindEase',
            style: AppFonts.appTitle,
          ),
          const Spacer(), // Pushes the icon button to the right
          IconButton(
            icon: Icon(Icons.view_headline, color: iconColor),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const SettingPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
