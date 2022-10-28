import 'package:flutter/material.dart';
import 'screens/screen_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  runApp(MaterialApp(title: 'Blindspot', home: LogScreen()));
}


/*
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
 */