import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../reusable/widgets/settings_button_red.dart';
import '../../reusable/functions/user_login_request.dart';
import '../../reusable/widgets/message.dart';
import 'package:blindspot/reusable/functions/check_for_login.dart';

class LogOutInSetting extends StatelessWidget {
  LogOutInSetting({super.key});

  final String? currentUser = FirebaseAuth.instance.currentUser?.email;

  _backToLogin(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return RedSettingsButton(
        text: checkForLogin(hasUser: 'Sign out', noUser: 'Sign in'),
        onPressed: checkForLogin(hasUser: () {
          userLoginRequest(() {
            massage('Logged Out successful');
          }, () {
            massage('Error with logout');
          });
          _backToLogin(context);
        }, noUser: () {
          _backToLogin(context);
        }));
  }
}
