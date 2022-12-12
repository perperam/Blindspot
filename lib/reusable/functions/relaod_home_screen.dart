import 'package:flutter/material.dart';
import '../../screens/screen_home.dart';

reloadHomeScreen(BuildContext context) {
  Navigator.pop(context);
  // print("I RUNNED");
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) {
            return const HomeRoute();
          },
          settings: const RouteSettings(name: 'HomeScreen')));
}
