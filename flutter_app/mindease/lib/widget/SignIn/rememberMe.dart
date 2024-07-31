import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberMeCheckbox extends StatefulWidget {
  const RememberMeCheckbox({Key? key}) : super(key: key);

  @override
  _RememberMeCheckboxState createState() => _RememberMeCheckboxState();
}

class _RememberMeCheckboxState extends State<RememberMeCheckbox> {
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  Future<void> _loadRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('remember_me') ?? false;
    });
  }

  Future<void> _saveRememberMe(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('remember_me', value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          fillColor: MaterialStateProperty.all(Colors.white),
          checkColor: Colors.teal,
          value: _rememberMe,
          onChanged: (bool? value) {
            setState(() {
              _rememberMe = value ?? false;
            });
            _saveRememberMe(_rememberMe);
          },
        ),
        const Text('Ricordati di me'),
      ],
    );
  }
}
