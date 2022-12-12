import 'package:flutter/material.dart';
import '../../screens/screen_home.dart';

reloadHomeScreen(BuildContext context) {
  Navigator.pop(context);
  print("I RUNNED");
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) {
            return HomeRoute();
          },
          settings: RouteSettings(name: 'HomeScreen')));
}
