import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'dart:io' as Io;

import 'package:blindspot/image_view.dart' as iv;

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
        body: FutureBuilder<Map<String, dynamic>>(
          future: futureMap,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return iv.View(snapshot.data!);
            } else {
              return const CircularProgressIndicator();
            }
          }
          )
    );
  }
}