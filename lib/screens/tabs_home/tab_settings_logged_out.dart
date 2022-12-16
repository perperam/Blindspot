import 'package:blindspot/screens/screen_create_account.dart';
import 'package:blindspot/screens/screen_login.dart';
import 'package:blindspot/screens/tabs_home/tab_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../reusable/functions/local_storage.dart';
import '../../reusable/functions/relaod_home_screen.dart';
import '../../reusable/widgets/settings_button_black.dart';
import '../../reusable/widgets/settings_button_red.dart';
import 'package:blindspot/config/config.dart';

class ScreenSettingsLoggedOut extends StatelessWidget {
  const ScreenSettingsLoggedOut({Key? key, required this.value}) : super(key: key);
  final bool value;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text(value ? 'Dark Mode' : 'Light Mode'),
            Switch(
              value: value,
              onChanged: (val) {
                Hive.box(themeBox).put('darkMode', !value);
              },
            )
          ]),
          settingsButtonBlack('create Account', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) {
                      return const CreateAccountScreen();
                    },
                    settings:
                        const RouteSettings(name: 'CreateAccountScreen')));
          }),
          const SizedBox(height: 10),
          settingsButtonBlack('Login Screen', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) {
                      return LoginScreen();
                    },
                    settings: const RouteSettings(name: 'Login Screen')));
          }),
          const SizedBox(height: 10),
          const Text('AppVersion: 0.1'),
          const SizedBox(height: 10),
          settingsButtonRed('Delete all Data', () {
            deleteAllImageData();
            // should be changed to something different ??

            final NavigatorState navigator = Navigator.of(context);
            reloadToHomeScreen(navigator);
          }),
        ])));
  }
}
