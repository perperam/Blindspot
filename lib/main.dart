import 'package:flutter/Cupertino.dart';
import'AddPhoto.dart';
import'GalerieScreen.dart';
import'HomeScreen.dart';
import'LogScreen.dart';
import'Settings.dart';

void main(){
  runApp(CupertinoApp(
      title: 'Blindspot',
      home: LogScreen()
  ));
}