import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:blindspot/screens/screen_login.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const themeBox = 'hiveThemeBox';


class SettingsTab extends StatelessWidget {
  final bool value;
  const SettingsTab({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var darkMode = Hive.box(themeBox).get('darkMode', defaultValue: false);
    return Scaffold( body: (
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(value ? 'Dark Mode' : 'Light Mode'),
                Switch(
                  value: value,
                  onChanged: (val) {
                    Hive.box(themeBox).put('darkMode', !value);
                  },
                )
              ]),
          const Text('AppVersion: 0.1'),
          OutlinedButton(
              child: Text(
                'Sign out', style: TextStyle(color: Colors.red)),
                onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyLogin(value: darkMode,)));
                },
          )
        ])
    ));
  }
}


