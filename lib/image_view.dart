import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:blindspot/fbuilder_else_widgets.dart';
import 'package:path_provider/path_provider.dart';


saveImage(Future<Map<String, dynamic>> newFutureImageData) async {
  final directory = await getApplicationDocumentsDirectory();
  File jsonFile = File('${directory.path}/map_all_image_data.json');
  final contents = await jsonFile.readAsString();
  print("THE STRING$contents");
  // Map<String, dynamic> mapAllImageData = json.decode(contents);
  //
  // Map<String, dynamic> newImageData = await newFutureImageData;
  // print(newImageData.toString());

  // // stores tha newImageData map in a form needed for map_all_image_data.json
  // Map<String, dynamic> newImageListViewData = {
  //   newImageData['uuid'] : {
  //     'name' : newImageData['name'],
  //     'datetime' : newImageData['metadata']['datatime']
  //   }
  // };
  //
  // // add to newImageData so that new Data is at beginning of the Map
  // newImageListViewData.addAll(mapAllImageData);
  //
  // print(newImageListViewData.toString());
}

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
            // =========
            // String directory;
            // List files;
            //
            // directory = (await getApplicationDocumentsDirectory()).path;
            // files = Directory(directory).listSync();
            //
            // ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text(files.toString())));
            // print(files.toString());
            // =========

            // write api response to  local storage
            final Directory appDocDir = await getApplicationDocumentsDirectory();
            Directory appDocDirImageData = Directory('${appDocDir.path}/image_data');

            File pathImageData = File('${appDocDirImageData.path}/${(await widget.futureImageData)["uuid"]}.json');
            pathImageData.writeAsString((await widget.futureImageData).toString());

            File pathMapAllImageData = File('${appDocDir.path}/map_all_image_data.json');
            final contents = await pathMapAllImageData.readAsString();
            Map mapAllImageData = json.decode(contents);
            print(mapAllImageData.toString());

            Map newImageListViewData = {
              (await widget.futureImageData)['uuid'] : {
                'name' : (await widget.futureImageData)['name'],
                'datetime' : (await widget.futureImageData)['metadata']['datetime']
              }
            };
            // print((await widget.futureImageData)['metadata'].toString());
            print(newImageListViewData.toString());

            // add to newImageData so that new Data is at beginning of the Map
            newImageListViewData.addAll(mapAllImageData);
            print(newImageListViewData.toString());

            // override map_all_image_data.json with new one
            pathMapAllImageData.writeAsString(jsonEncode(newImageListViewData));


          } //saveImage(widget.futureImageData)
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
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).popUntil((route){
              return route.settings.name == 'CameraScreen';
            })
          )
        ),
        body: FutureBuilder<Map<String, dynamic>>(
            future: widget.futureImageData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return View(snapshot.data!);
              } else if (snapshot.hasError) {
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
