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
          const ElevatedButton(onPressed: null, child: Text('Take Photo'))
        ]
    );
  }
}

/*******************************************************************************
 * GALLERY TAB
 *******************************************************************************/
class GalleryTab extends StatelessWidget {
  const GalleryTab({super.key});

  // const List<String> _items = List<String>.generate(10000, (i) => 'Item $i');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return const Card(child: ListTile(
              title: Text('image'),
              leading: Icon(Icons.movie),
              subtitle: Text('subtitle')
          ));
        }
    );
  }
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
          Row(mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text('Darkmode'),
                Switch(value: false, onChanged: null)
              ]),
          Row(mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text('???'),
                Switch(value: false, onChanged: null)
              ]),
          const Text('AppVersion: 0.1'),
          ElevatedButton(
              child: const Text('Logout'),
              onPressed: () => Navigator.pop(context)
          )
        ]
    );
  }
}