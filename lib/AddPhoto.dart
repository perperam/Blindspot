import 'package:flutter/Cupertino.dart';
import'AddPhoto.dart';
import'GalerieScreen.dart';
import'HomeScreen.dart';
import'LogScreen.dart';
import'Settings.dart';



class AddPhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          leading: CupertinoButton(child: Icon(CupertinoIcons.left_chevron), onPressed: () => Navigator.pop(context)),
          middle: Text("Galerie"),
          trailing: CupertinoButton(child: Icon(CupertinoIcons.home), onPressed: null)),

      child: Container(child: Text('Add Photo'), width: 400, height: 400, color: CupertinoColors.activeBlue),
    );
  }
}