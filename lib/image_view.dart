import 'package:flutter/material.dart';
import 'dart:convert';

class View extends StatelessWidget {
  final Map<String, dynamic> imageData;
  const View(this.imageData, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ImageView(imageData["image"]),
            MetaView(imageData["metadata"])
          ]
      )
    );
  }
}

class ImageView extends StatelessWidget {
  final String b64image;
  const ImageView(this.b64image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.memory(base64Decode(b64image));
  }
}

class MetaView extends StatelessWidget {
  final Map<String, dynamic> metadata;
  const MetaView(this.metadata, {super.key});

  @override
  Widget build(BuildContext context) {
    Map data = metadata;

    List<Widget> textChildren = [];
    textChildren.add(Card(
        child: ListTile(title: Text("Date: ${data["datetime"].toString()}"))));

    for (var labels in data["labels"]) {
      textChildren.add(Card(
          child: ExpansionTile(
            title: Text("Class name: ${labels["name"].toString()}"),
            controlAffinity: ListTileControlAffinity.leading,
            children: <Widget>[
              ListTile(title: Text("Class ID: ${labels["class"].toString()}")),
              ListTile(title: Text("Confidence: ${labels["confidence"].toString()}")),
              ListTile(title: Text("x-min: ${labels["xmin"].toString()}")),
              ListTile(title: Text("y-min: ${labels["ymin"].toString()}")),
              ListTile(title: Text("x-max: ${labels["xmax"].toString()}")),
              ListTile(title: Text("y-max: ${labels["ymax"].toString()}")),
            ],
      )));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: textChildren,
    );
  }
}
