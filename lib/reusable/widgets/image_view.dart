import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:blindspot/reusable/functions/relaod_home_screen.dart';
import 'package:blindspot/reusable/widgets/fbuilder_else_widgets.dart';
import 'package:blindspot/reusable/functions/local_storage.dart';
import 'package:blindspot/reusable/functions/image_data_manipulation.dart';


class ImageBuilder extends StatefulWidget {
  const ImageBuilder(this.futureImageData, this.mode, {super.key, required this.callback});
  final Future<Map<String, dynamic>> futureImageData;
  final String mode;
  final Function callback;

  @override
  State<ImageBuilder> createState() => _ImageBuilder();
}

class _ImageBuilder extends State<ImageBuilder> {
  late TextEditingController controller;

  @override void initState() {
    super.initState();
    controller = TextEditingController();
  }

  Future _openDialog()  {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('This is an title'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Name InputData'),
            controller: controller,
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  // prevent navigator and async problem, look into readme link for more
                  // information
                  final NavigatorState navigator = Navigator.of(context);

                  Map<String, dynamic> imageData =  renameImageData(await widget.futureImageData, controller.text);

                  await saveImageData(imageData);
                  await addToMapAllImageData(imageData);

                  // close AlertDialog
                  navigator.pop();
                },
                child: const Text('Submit')),
            TextButton(
                onPressed: () {Navigator.pop(context);},
                child: const Text('Cancel'))
          ],
        )
    );
  }


  // changes which button is shown at which screen
  Widget _getViewModeButton(String mode) {
    if (mode == 'preview') {
      return IconButton(
          icon: const Icon(Icons.save),
          onPressed: () async {
            final NavigatorState navigator = Navigator.of(context);
            await _openDialog();
            widget.callback();
            reloadToHomeScreen(navigator);
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
            onPressed: () {
              final NavigatorState navigator = Navigator.of(context);
              reloadToHomeScreen(navigator);
            }
          )
        ),
        body: FutureBuilder<Map<String, dynamic>>(
            future: widget.futureImageData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return View(snapshot.data!);
              } else if (snapshot.hasError) {
                return const ElseError(massage: "Could not load the Image!");
              } else {
                return const ElseWaiting(massage: "Loading the image...");
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
