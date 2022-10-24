import 'package:flutter/material.dart';

/*******************************************************************************
* TAKE PHTO TAB
*******************************************************************************/
class TakePhotoTab extends StatelessWidget {
  const TakePhotoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(width: 200, height: 400, color: Colors.grey),
          ElevatedButton(onPressed: null, child: Text('Take Photo'))
        ]
    );
  }
}

/*******************************************************************************
 * GALLERIE TAB
 *******************************************************************************/
Widget buildList() {
  return ListView(
    children: [
      _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
      _tile('The Castro Theater', '429 Castro St', Icons.theaters),
      _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
      _tile('Roxie Theater', '3117 16th St', Icons.theaters),
      _tile('United Artists Stonestown Twin', '501 Buckingham Way', Icons.theaters),
      _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
      const Divider(),
      _tile('K\'s Kitchen', '757 Monterey Blvd', Icons.restaurant),
      _tile('Emmy\'s Restaurant', '1923 Ocean Ave', Icons.restaurant),
      _tile('Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
      _tile('La Ciccia', '291 30th St', Icons.restaurant),
    ],
  );
}

ListTile _tile(String title, String subtitle, IconData icon) {
  return ListTile(
    title: Text(title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
  );
}

/*******************************************************************************
 * SETTINGS TAB
 *******************************************************************************/
class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[Text('Darkmode'), Switch(value: false, onChanged: null)]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[Text('???'), Switch(value: false, onChanged: null)]),
          Text('AppVersion: 0.1'),
          ElevatedButton(
          child: Text('Logout'),
          onPressed: () => Navigator.pop(context)
          )
        ]
    );
  }
}