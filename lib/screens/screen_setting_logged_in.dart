import 'package:blindspot/reusable/functions/user_login_request.dart';
import 'package:blindspot/screens/screen_login.dart';
import 'package:blindspot/screens/tabs_home/tab_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../reusable/functions/local_storage.dart';
import '../reusable/functions/relaod_home_screen.dart';
import '../reusable/widgets/message.dart';
import '../reusable/widgets/settings_button_red.dart';

class ScreenSettingsLoggedIn extends StatelessWidget {
  final String? currentUser = FirebaseAuth.instance.currentUser?.email;
  final bool value;
  ScreenSettingsLoggedIn({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 10),
          settingsButtonRed('Delete all Data', () {
            deleteAllImageData();
            // should be changed to something different ??
            reloadHomeScreen(context);
          }),
          const SizedBox(height: 10),
          settingsButtonRed('Sign out', () {
            userLoginRequest(() {
              massage('Logged Out successful');
            }, () {
              massage('Error with logout');
            });
            FirebaseAuth.instance.signOut();
            //Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return LoginScreen();
            }));
          }),
        ])));
  }
}
