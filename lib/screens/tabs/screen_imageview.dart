import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('image')),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200,
                width: 150,
                color: Colors.amber,
              ),
              Card(
                  child: Center(
                      child: Text('This is the images metadata\nData: 2022-10-24\nLocation: There'))),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context), child: Text('Back'))
            ]));
  }
}
