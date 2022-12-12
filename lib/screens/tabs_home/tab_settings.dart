import 'package:blindspot/reusable/functions/relaod_home_screen.dart';
import 'package:blindspot/screens/screen_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../reusable/functions/local_storage.dart';

import '../../reusable/functions/local_storage.dart';
import '../../reusable/widgets/redTextButton.dart';

const themeBox = 'hiveThemeBox';

class SettingsTab extends StatelessWidget {
  final String? currentUser = FirebaseAuth.instance.currentUser?.email;
  final bool value;
  SettingsTab({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var darkMode = Hive.box(themeBox).get('darkMode', defaultValue: false);
    return Scaffold(
        body: (Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Text("Hello, you are logged in as:\n$currentUser\n"),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text(value ? 'Dark Mode' : 'Light Mode'),
            Switch(
              value: value,
              onChanged: (val) {
                Hive.box(themeBox).put('darkMode', !value);
                FirebaseFirestore.instance
                    .collection("user")
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .set({"darkMode": !value});
              },
            )
          ]),
          const Text('AppVersion: 0.1'),
          OutlinedButton(
            child: const Text('Delete all Data',
                style: TextStyle(color: Colors.red)),
            onPressed: () async {
              deleteAllImageData();
              // should be changed to something different ??
              reloadHomeScreen(context);
            },
          ),
          redTextButton('Delete all Data', () {
            deleteAllImageData();
            // should be changed to something different ??
            reloadHomeScreen(context);
          }),
          redTextButton('Sign out', () {
            // Message
            FirebaseAuth.instance.signOut();
            //Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return LoginScreen();
            }));
          }),
        ])));
  }
}
