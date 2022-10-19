import 'package:flutter/Cupertino.dart';
import'AddPhoto.dart';
import'GalerieScreen.dart';
import'HomeScreen.dart';
import'LogScreen.dart';
import'Settings.dart';


class LogScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: Text("Login")
        ),
        child: Center(child:(
            //FlutterLogin(onLogin: ),
            CupertinoButton(child: Text('Login'), color: CupertinoColors.activeBlue, onPressed: () => Navigator.push (context, CupertinoPageRoute(builder: (_) => HomeScreen() )))
        )));
  }
}