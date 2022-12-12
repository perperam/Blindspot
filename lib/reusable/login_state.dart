import 'package:blindspot/screens/screen_login.dart';
import 'package:flutter/material.dart';
import '../screens/screen_home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyLogin extends StatefulWidget {
  //final bool value;
  //const MyLogin({Key? key, required this.value}) : super(key: key);
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLogin createState() => _MyLogin();
}

class _MyLogin extends State<MyLogin> {
  User? user; //track the authenticated user here
  final emailInput = TextEditingController(text: '');
  final passInput = TextEditingController(text: '');
  FirebaseAuth auth = FirebaseAuth.instance;
  bool valueUser = false;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user != null) {
        valueUser = true;
      }
    });

    if (valueUser == true) {
      return const HomeRoute();
    } else {
      valueUser = false;
      return LoginScreen();
    }
  }
}
