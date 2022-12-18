import 'package:flutter/material.dart';

reloadToHomeScreen(NavigatorState navigator) {
  navigator.popUntil((route) => route.isFirst);
}
