import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:blindspot/reusable/widgets/image_view.dart' as iv;

class ImageViewScreen extends StatefulWidget  {
  String imageDataUuid;
  ImageViewScreen(this.imageDataUuid, {super.key});

  @override
  State<ImageViewScreen> createState() => _ImageViewScreen();
}


class _ImageViewScreen extends State<ImageViewScreen> {

  // read the json file by uuid which is specified in the listViewBuilder
  Future<Map<String, dynamic>> loadImageData() async {
    // print('THE UUID IS: ${widget.imageDataUuid}');
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory appDocDirImageData = Directory('${appDocDir.path}/image_data');
    File pathMapAllImageData = File('${appDocDirImageData.path}/${widget.imageDataUuid}.json');
    // print('THE PATH IS: ${pathMapAllImageData.toString()}');
    final contents = await pathMapAllImageData.readAsString();
    return jsonDecode(contents);
  }

  late Future<Map<String, dynamic>> futureMap;

  @override
  void initState() {
    super.initState();
    futureMap = loadImageData();
  }

  @override
  Widget build(BuildContext context) {
    return iv.ImageBuilder(futureMap, "listview");
  }
}