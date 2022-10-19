import 'package:flutter/Cupertino.dart';
import'AddPhoto.dart';
import'GalerieScreen.dart';
import'HomeScreen.dart';
import'LogScreen.dart';
import'Settings.dart';



class GalerieScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            leading: CupertinoButton(child: Icon(CupertinoIcons.left_chevron), onPressed: () => Navigator.pop(context)),
            middle: Text("Galerie"),
            trailing: CupertinoButton(child: Icon(CupertinoIcons.home), onPressed: () => Navigator.push (context, CupertinoPageRoute(builder: (_) => HomeScreen())))),

        child: GridView.count(
          //maxCrossAxisExtent: 200,
            mainAxisSpacing: 4,
            crossAxisCount: 4
          //children: _buildGridTileList(30));

          //List <Container> _buildGridTileList(int count) => List.generate(
          //count, (i) => Container(child: Image.asset('images/image$i.jpeg')));
        ));
  }
}