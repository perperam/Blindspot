import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text('Darkmode'),
                Switch(value: false, onChanged: null)
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text('???'),
                Switch(value: false, onChanged: null)
              ]),
          const Text('AppVersion: 0.1'),
          ElevatedButton(
              child: const Text('Logout'),
              onPressed: () => Navigator.pop(context))
        ]);
  }
}