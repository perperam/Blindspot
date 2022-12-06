import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'dart:io' as Io;

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  var apiUrlPicture = Uri.parse('http://dev.icatas.eu:5000/picture');

  Future<Map<String, dynamic>> postPic() async {
    var request = http.MultipartRequest('POST', apiUrlPicture);
    request.files.add(await http.MultipartFile.fromPath(
        'image', widget.picture.path)); // HERE IS THE ERROR

    var streamedResponse = await request.send();
    final responseString = await http.Response.fromStream(streamedResponse);
    final m = await json.decode(responseString.body);
    return m;
  }

  late Future<Map<String, dynamic>> futureMap;

  @override
  void initState() {
    super.initState();
    futureMap = postPic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Preview Page')),
        body: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
          FutureBuilder<Map<String, dynamic>>(
              future: futureMap,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Image.memory(base64Decode(snapshot.data!["image"]));
                } else {
                  return const CircularProgressIndicator();
                }
              }),
          // Image.file(File(widget.picture.path), fit: BoxFit.cover, width: 250),
          const SizedBox(height: 24),
          Text(widget.picture.name),
          FutureBuilder<Map<String, dynamic>>(
              future: futureMap,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MetaView(snapshot.data!["metadata"]);
                  // return Text(snapshot.data!["metadata"]);
                } else {
                  return const CircularProgressIndicator();
                }
              })
        ])));
  }
}

// class ImageClasse {
//   final String name;
//   final int classnumber;
//   final double confidence;
//   final double xmin;
//   final double ymin;
//   final double xmax;
//   final double ymax;
//
//   const ImageClasse({
//     required  this.name,
//     required  this.classnumber,
//     required  this.confidence,
//     required  this.xmin,
//     required  this.ymin,
//     required  this.xmax,
//     required  this.ymax
// })
// }

class MetaView extends StatelessWidget {
  final String metadata;

  const MetaView(this.metadata);

  @override
  Widget build(BuildContext context) {
    print(metadata.runtimeType);
    List data = json.decode(metadata);
    for (var d in data) {
      print("OBJEKT: $d");
    }

    List<Widget> textChildren = [];
    for (var d in data) {
      // print(d.runtimeType);
      textChildren.add(Container(
        color: Colors.orangeAccent,
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("name: ${d["name"].toString()}"),
          Text("name: ${d["class"].toString()}"),
          Text("confidence: ${d["confidence"].toString()}")
        ],
      )));
      // textChildren.add(
      //     Container(color: Colors.orangeAccent, child: Text(d.toString())));
      textChildren.add(Container(color: Colors.white, height: 20));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: textChildren,
    );
  }
}
