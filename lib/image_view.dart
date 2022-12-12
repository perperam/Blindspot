import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:blindspot/fbuilder_else_widgets.dart';
import 'package:blindspot/reusable/functions/local_storage.dart';


class ImageBuilder extends StatefulWidget {
  Future<Map<String, dynamic>> futureImageData;
  String mode;

  ImageBuilder(this.futureImageData, this.mode, {super.key});

  @override
  State<ImageBuilder> createState() => _ImageBuilder();
}

class _ImageBuilder extends State<ImageBuilder> {
  // changes which button is shown at which screen
  Widget _getViewModeButton(String mode) {
    if (mode == 'preview') {
      return IconButton(
          icon: const Icon(Icons.save),
          onPressed: () async {
            saveImageData(await widget.futureImageData);
            addToMapAllImageData(await widget.futureImageData);
            Navigator.of(context).popUntil((route){
              return route.settings.name == 'HomeScreen';
            });
          }
          );
    } else if (mode == 'listview') {
      return const IconButton(icon: Icon(Icons.settings), onPressed: null);
    } else {
      return const Icon(Icons.circle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Preview Page'),
          actions: [_getViewModeButton(widget.mode)],
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).popUntil((route){
              return route.settings.name == 'HomeScreen';
            })
          )
        ),
        body: FutureBuilder<Map<String, dynamic>>(
            future: widget.futureImageData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // String ImageData = (snapshot.data!).toString();
                // print('IMAGEDATA (SNAPSHOT) from future: ${ImageData!}');
                return View(snapshot.data!);
              } else if (snapshot.hasError) {
                // print('THE ERROR IS: ${snapshot.error.toString()}');
                return ElseError(massage: "Could not load the Image!");
              } else {
                return ElseWaiting(massage: "Loading the image...");
              }
            }));
  }
}

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
        ]));
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
  final Map<String, dynamic> data;

  const MetaView(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
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
          ListTile(
              title: Text("Confidence: ${labels["confidence"].toString()}")),
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
