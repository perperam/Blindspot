import 'package:flutter/material.dart';
import 'package:blindspot/screens/screen_home.dart';

/*
Use this line in combination with the function bellow to prevent navigator
and async problem, look here for more information:
https://stackoverflow.com/questions/69466478/waiting-asynchronously-for-navigator-push-linter-warning-appears-use-build

final NavigatorState navigator = Navigator.of(context);

 */

reloadToHomeScreen(NavigatorState navigator) {
  navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) {return const HomeScreen();},
          settings:
          const RouteSettings(name: 'HomeScreen')
      ),
      (Route<dynamic> route) => false);
}
