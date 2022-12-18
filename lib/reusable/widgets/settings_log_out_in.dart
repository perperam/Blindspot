import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../reusable/widgets/settings_button_red.dart';
import 'package:blindspot/reusable/functions/check_for_login.dart';
import 'package:blindspot/screens/screen_login.dart';

class LogOutInSetting extends StatelessWidget {
  LogOutInSetting({super.key});

  final String? currentUser = FirebaseAuth.instance.currentUser?.email;

  void _signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return RedSettingsButton(
        text: checkForLogin(hasUser: 'Sign out', noUser: 'Sign in'),
        onPressed: checkForLogin(
            hasUser: () {
              _signOut();
              final NavigatorState navigator = Navigator.of(context);
              navigator.pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) {return LoginScreen();},
                      settings:
                      const RouteSettings(name: 'LoginScreen')
                  ),
                      (Route<dynamic> route) => false
              );
            },
            noUser: () {
              final NavigatorState navigator = Navigator.of(context);
              navigator.pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) {return LoginScreen();},
                      settings:
                      const RouteSettings(name: 'LoginScreen')
                  ),
                  (Route<dynamic> route) => false
              );
            })
    );
  }
}
