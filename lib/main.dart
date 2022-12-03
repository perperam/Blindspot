import 'package:flutter/material.dart';
import 'screens/Login/screen_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(title: 'Blindspot', home: MyLogin()));
}
