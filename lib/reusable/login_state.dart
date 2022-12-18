import 'package:blindspot/screens/screen_login.dart';
import 'package:flutter/material.dart';
import '../screens/screen_home.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginState extends StatefulWidget {
  LoginState({Key? key}) : super(key: key);

  @override
  State<LoginState> createState() => _LoginState();
}

class _LoginState extends State<LoginState> {
  bool valueUser = false;

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
