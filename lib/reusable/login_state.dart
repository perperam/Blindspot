import 'package:blindspot/screens/screen_login.dart';
import 'package:flutter/material.dart';
import '../screens/screen_home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginState extends StatefulWidget {
  //final bool value;
  //const MyLogin({Key? key, required this.value}) : super(key: key);
  LoginState({Key? key}) : super(key: key);

  @override
  State<LoginState> createState() => _LoginState();
}

class _LoginState extends State<LoginState> {
  User? user; //track the authenticated user here
  // final emailInput = TextEditingController(text: '');
  // final passInput = TextEditingController(text: '');
  // FirebaseAuth auth = FirebaseAuth.instance;
  bool valueUser = false;

  @override
  Widget build(BuildContext context) {
    // if (FirebaseAuth.instance.currentUser() != null) {
    //   return HomeScreen();
    // } else {
    //   return LoginScreen();
    // }
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        valueUser = false;
      } else {
        valueUser = true;
      }
      print('VALUE USER INSIDE: $valueUser');
    });
    print('VALUE USER OUTSIDE: $valueUser');

    if (valueUser != true) {
      print("DO: GO TO HOME SCREEN");
      return HomeScreen();
    } else {
      valueUser = false;
      print("DO: GO TO HOME SCREEN");
      return LoginScreen();
    }
  }
}
