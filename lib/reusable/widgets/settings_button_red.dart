import 'package:flutter/material.dart';

class RedSettingsButton extends StatelessWidget {
  const RedSettingsButton({super.key, required this.text, required this.onPressed});
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200.0,
        height: 30.0,
        child: OutlinedButton(
          onPressed: () {
            onPressed();
          },
          child: Text(text, style: const TextStyle(color: Colors.red)),
        )
    );
  }
}