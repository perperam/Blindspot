import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import 'package:blindspot/config/config.dart';

class DarkModeSetting extends StatelessWidget {
  const DarkModeSetting({super.key, required this.darkMode});
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text(darkMode ? 'Dark Mode' : 'Light Mode'),
      Switch(
        value: darkMode,
        onChanged: (val) {
          Hive.box(themeBox).put('darkMode', !darkMode);
          //reloadToHomeScreen(Navigator.of(context));
          FirebaseFirestore.instance
              .collection("user")
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .set({"darkMode": !darkMode});
        },
      ),
    ]);
  }
}