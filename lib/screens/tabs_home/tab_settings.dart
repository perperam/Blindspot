import 'package:blindspot/screens/screen_setting_logged_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../screen_settings_logged_out.dart';

const themeBox = 'hiveThemeBox';

class SettingsTab extends StatelessWidget {
  bool value;
  bool valueUser = false;

  SettingsTab({Key? key, required this.value}) : super(key: key);
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    var darkMode = Hive.box(themeBox).get('darkMode', defaultValue: false);
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user != null) {
        valueUser = true;
      }
    });

    if (valueUser == true) {
      valueUser = false;
      return ScreenSettingsLoggedIn(value: darkMode);
    } else {
      return ScreenSettingsLoggedOut(value: darkMode);
    }
  }
}

// PUSH / POP issue first "if" for ever