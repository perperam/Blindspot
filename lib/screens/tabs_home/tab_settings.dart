import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import'package:blindspot/screens/Login/screen_login.dart';

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
          OutlinedButton(
              child: Text(
                'Sign out', style: TextStyle(color: Colors.red)),
                onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyLogin()));
                },
          )
        ]);
  }
}