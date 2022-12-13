import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:blindspot/reusable/widgets/image_view.dart' as iv;
import 'package:blindspot/config/api_access.dart';


class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}


class _PreviewPageState extends State<PreviewPage> {
  Future<Map<String, dynamic>> postPic() async {
    var request = http.MultipartRequest('POST', apiUrlPicture);
    request.files.add(await http.MultipartFile.fromPath(
        'image', widget.picture.path)); // HERE IS THE ERROR

    var streamedResponse = await request.send();
    final responseString = await http.Response.fromStream(streamedResponse);
    // imageData = response from API
    final imageData = await json.decode(responseString.body);
    return imageData;
  }

  late Future<Map<String, dynamic>> futureImageData;

  @override
  void initState() {
    super.initState();
    futureImageData = postPic();
  }

  @override
  Widget build(BuildContext context) {
    return iv.ImageBuilder(futureImageData, "preview");
  }
}