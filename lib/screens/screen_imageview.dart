import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:blindspot/image_view.dart' as iv;

class ImageViewScreen extends StatefulWidget  {
  const ImageViewScreen({super.key});

  @override
  State<ImageViewScreen> createState() => _ImageViewScreen();
}


class _ImageViewScreen extends State<ImageViewScreen> {

  Future<Map<String, dynamic>> loadPic() async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/test_image_data.json");
    return jsonDecode(data);
  }

  late Future<Map<String, dynamic>> futureMap;

  @override
  void initState() {
    super.initState();
    futureMap = loadPic();
  }

  @override
  Widget build(BuildContext context) {
    return iv.ImageBuilder(futureMap, "listview");
  }
}