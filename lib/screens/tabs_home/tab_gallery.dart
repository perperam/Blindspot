import 'package:flutter/material.dart';
import '../screen_image_viewer.dart';
import 'package:hive/hive.dart';
import 'tab_settings.dart';

import 'package:blindspot/config/config.dart';


class GalleryTab extends StatefulWidget {
  const GalleryTab(this.mapAllImageData, {super.key});
  final Map<String, dynamic> mapAllImageData;


  @override
  State<GalleryTab> createState() => _GalleryTab();
}

class _GalleryTab extends State<GalleryTab> {
  
  @override
  Widget build(BuildContext context) {
    // List<Map<String, String>> listAllImageData;
    List<String> uuidKeys = widget.mapAllImageData.keys.toList();

    Hive.box(themeBox).get('darkMode', defaultValue: false);

    return ListView.builder(
        itemCount: widget.mapAllImageData.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                  title: Text(widget.mapAllImageData[uuidKeys[index]]!['name']!),
                  leading: const Icon(Icons.movie),
                  subtitle: Text(widget.mapAllImageData[uuidKeys[index]]!['datetime']!),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) => ImageViewScreen(
                              // get the uuid from mapAllImageData at index
                              uuidKeys[index]
                          )
                      )
                  )
              ));
        });
  }
}