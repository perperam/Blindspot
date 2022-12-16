import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:blindspot/reusable/functions/check_for_login.dart';

class ActiveUserSetting extends StatelessWidget {
  ActiveUserSetting({super.key});
  final String? _currentUser = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return checkForLogin(
        hasUser: Text("Hello, you are logged in as:\n$_currentUser\n"),
        noUser: const Text('Hello, you are not logged in')
    );
  }
}