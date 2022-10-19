import 'package:flutter/Cupertino.dart';
import'AddPhoto.dart';
import'GalerieScreen.dart';
import'HomeScreen.dart';
import'LogScreen.dart';
import'Settings.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            leading: CupertinoButton(child: Icon(CupertinoIcons.person), onPressed: () => Navigator.push (context, CupertinoPageRoute(builder: (_) => LogScreen()))),
            middle: Text("Blindspot"),
            trailing: CupertinoButton(child: Icon(CupertinoIcons.line_horizontal_3_decrease_circle), onPressed: () => Navigator.push (context,
                CupertinoPageRoute(builder: (_) => GalerieScreen())))
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Welcome to Blindspot, your AI!'),
              CupertinoButton(child: Text('Galerie'), color: CupertinoColors.activeBlue, onPressed: () => Navigator.push (context,
                  CupertinoPageRoute(builder: (_) => GalerieScreen()))),
              CupertinoButton(child: Text('Neues Foto hinzufügen'), color: CupertinoColors.activeBlue, onPressed: () => Navigator.push (context,
                  CupertinoPageRoute(builder: (_) => AddPhoto()))),
              CupertinoButton(child: Text('Logout'), color: CupertinoColors.activeBlue, onPressed: () => Navigator.push (context,
                  CupertinoPageRoute(builder: (_) => LogScreen()))),
            ])
    );
  }
}